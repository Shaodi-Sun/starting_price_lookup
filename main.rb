require "tty-prompt"
require 'net/http'
require 'json'
require "httparty"
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'
require 'selenium-webdriver'

puts "Welcome to statring price CLI"
prompt = TTY::Prompt.new
option = prompt.yes?("Do you want to retrieve the names of the top 12 devices from Bell Smartphone page?")
  if option == true
    PAGE_URL = 'https://www.bell.ca/Mobility/Smartphones_and_mobile_internet_devices'
    document = Nokogiri::HTML(open(PAGE_URL).read)
    fullProductsList = document.css('div.rsx-product-list-product-details-col').map do |product|
      date = product.at_css('.rsx-product-name-group.rsx-product-list-product-name-top.rsx-h3').at_css('.rsx-product-name.hidden-xs.hidden-sm').text.strip
    end
    top12Products = fullProductsList[0..11]
  end

chosenProduct = prompt.select("Choose the device to get more info", top12Products, filter: true) 
productIndex = top12Products.index(chosenProduct)
class ProductDetails< Struct.new(:name, :prices, :terms)
end


driver = Selenium::WebDriver.for :chrome
driver.get 'https://www.bell.ca/Mobility/Smartphones_and_mobile_internet_devices'
overflowEl = driver.find_elements(:css, 'div.rsx-product-list-product-details-col')[0..11]
overflowEl[productIndex.to_i].find_element(:class, 'rsx-product-hotspot').click()
smartPay = driver.find_elements(:class, 'rsx-radio')[0].click()
puts("start of smart pay")
puts driver.find_element(:id,'bcx-order-now-group-smartpay').text
smartPay = driver.find_elements(:class, 'rsx-radio')[1].click()
puts("start of subsidized")
puts driver.find_element(:id,'bcx-order-now-group-subsidized').text
driver.quit()
