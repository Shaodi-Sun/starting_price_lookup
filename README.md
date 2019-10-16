# Starting Price Lookup

This is a starting price lookup CLI which could fetch devices information from the [Bell Smartphone page](https://www.bell.ca/Mobility/Smartphones_and_mobile_internet_devices)

## Prerequisite

Below is a list of required software packages needed to be installed: 

- Ruby 2.4.1
- Google Chrome Version 77.0.3865.120 (Official Build) (64-bit)
- ChromeDriver 77.0.3865.40
- tty-prompt, rubygems, nokogiri, open-uri, selenium-webdriver <br/>
Those can be installed via the command:
```
gem install tty-prompt
```
- Internet access is needed for running the CLI

## How to run the program
The main logic and functions are in the main.rb file. The program can be executed using the following bash command

```
cd starting_price_lookup/
ruby main.rb
```
This program will then prompt to ask the user if they want to fetch top 12 devices from [Bell Smartphone page](https://www.bell.ca/Mobility/Smartphones_and_mobile_internet_devices). 
If the user chooses yes, the program will then provide a list of top 12 devices as a drop-down list, and the user can then choose which specific device they want to look up prices and terms for. 
If the user chooses no, the program will simply exit. 

## Additional Information
Preferably this CLI should perform the web operations in the background. But because the time is limited, I cannot get the CLI to work in headless mode. I think the reason is something wrong with the version of Chrome WebDriver and headless mode supported in Chrome on MacOS. So, for now, the CLI will open the webpage and perform actions like select and click, and close the web page after operations being successfully performed. I also had a block of comment in main.rb which is the example code snippet if everything set up correctly. 

