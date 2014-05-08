require 'watir-webdriver'

def mock_browser_for_watir
  watir_browser = double('watir')
  watir_browser.stub(:is_a?).with(Watir::Browser).and_return(true)
  watir_browser.stub(:is_a?).with(Selenium::WebDriver::Driver).and_return(false)
  watir_browser
end