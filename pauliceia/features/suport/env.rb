require 'capybara/cucumber'
require 'selenium-webdriver'

Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium_chrome
Capybara.default_max_wait_time = 5

Capybara.app_host = 'http://localhost:8080'

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
