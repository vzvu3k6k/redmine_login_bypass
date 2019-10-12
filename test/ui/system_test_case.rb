module RedmineLoginBypass
  SystemTestCase =
    if defined? ActionDispatch::SystemTestCase
      ActionDispatch::SystemTestCase
    else
      # Use headless mode to avoid
      # `unknown error: DevToolsActivePort file doesn't exist` on GitHub Actions.
      # Capybara has `:selenium_chrome_headless` driver by default, but it causes
      # `NameError: uninitialized constant Selenium::WebDriver::Chrome::Options`
      # because Redmine uses a older version of selenium-webdriver gem.
      Capybara.register_driver :redmine_login_bypass_selenium_chrome_headless do |app|
        Capybara::Selenium::Driver.new(app, browser: :chrome, args: ['--headless'])
      end

      # for Redmine < 4 (Rails < 5)
      require File.expand_path('../../../../../test/ui/base', __FILE__)
      Redmine::UiTest::Base
    end
end
