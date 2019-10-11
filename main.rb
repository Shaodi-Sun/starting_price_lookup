require "tty-prompt"
require 'net/http'
require 'json'
require "httparty"
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pp'


puts "Welcome to statring price CLI"
prompt = TTY::Prompt.new
option = prompt.yes?("Do you want to retrieve the names of the top 12 devices from Bell Smartphone page? \nType y/Y to continue, n to exit")
  if option == true
    PAGE_URL = 'https://www.bell.ca/Mobility/Smartphones_and_mobile_internet_devices'
    document = Nokogiri::HTML(open(PAGE_URL).read)
    fullProductsList = document.css('div.rsx-product-list-product-details-col').map do |product|
      date = product.at_css('.rsx-product-name-group.rsx-product-list-product-name-top.rsx-h3').at_css('.rsx-product-name.hidden-xs.hidden-sm').text.strip
    end
    top12Products = fullProductsList[0..11]
  end
  # puts top12Products
  prompt.select("Choose the device to get more info", top12Products)
