require "tty-prompt"
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'selenium-webdriver'

puts "Welcome to Bell Starting Price LookUp CLI"
prompt = TTY::Prompt.new
option = prompt.yes?("Do you want to retrieve the names of the top 12 devices from Bell Smartphone page?")
  if option == true
    PAGE_URL = 'https://www.bell.ca/Mobility/Smartphones_and_mobile_internet_devices'
    document = Nokogiri::HTML(open(PAGE_URL).read)
    fullProductsList = document.css('div.rsx-product-list-product-details-col').map do |product|
      date = product.at_css('.rsx-product-name-group.rsx-product-list-product-name-top.rsx-h3').at_css('.rsx-product-name.hidden-xs.hidden-sm').text.strip
    end
    top12Products = fullProductsList[0..11]
  else 
    puts "Thank you for using Bell Starting Price LookUp CLI"
    exit
  end

chosenProduct = prompt.select("Choose the device to get more info", top12Products, filter: true) 
productIndex = top12Products.index(chosenProduct)
class ProductDetails< Struct.new(:name, :prices, :terms)
end

# Headless mode: 
# options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless')
# options.add_argument('--window-size=1200x764')
#driver = Selenium::WebDriver.for :chrome, options: options

driver = Selenium::WebDriver.for :chrome
driver.get 'https://www.bell.ca/Mobility/Smartphones_and_mobile_internet_devices'
overflowEl = driver.find_elements(:css, 'div.rsx-product-list-product-details-col')[0..11]
overflowEl[productIndex.to_i].find_element(:class, 'rsx-product-hotspot').click()
payment = driver.find_elements(:class, 'rsx-radio')[0].click()
smartPayIndex = 1
puts("Smart Payment Options: ")
driver.find_element(:id,'bcx-order-now-group-smartpay').find_elements(:class, 'payments').map do |payments|
  puts smartPayIndex.to_s+": "+payments.text
  smartPayIndex+=1
end
puts
payment = driver.find_elements(:class, 'rsx-radio')[1].click()
subsidizedPayIndex = 1
puts("Subsidized Payment Options: ")
driver.find_element(:id,'bcx-order-now-group-subsidized').find_elements(:class, 'bcx-order-now-box-body').map do |payments|
    puts subsidizedPayIndex.to_s+": "+payments.text
    subsidizedPayIndex+=1
end
driver.quit()
