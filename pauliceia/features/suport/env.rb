require 'capybara/cucumber'
require 'selenium-webdriver'
require 'webmock/cucumber'
require 'webdrivers'

Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome
Capybara.default_max_wait_time = 5

Capybara.app_host = 'http://localhost:8080'

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

WebMock.disable_net_connect!(allow_localhost: true, allow: [
  'googlechromelabs.github.io',
  'chromedriver.storage.googleapis.com',
  'edgedl.me.gvt1.com'
])