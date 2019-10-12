module RedmineLoginBypass
  # Use headless mode to avoid
  # `unknown error: DevToolsActivePort file doesn't exist` on GitHub Actions.
  SystemTestCase =
    if defined? ActionDispatch::SystemTestCase
      # for Redmine 4 (Rails 5)
      Class.new(ActionDispatch::SystemTestCase) do
        driven_by :selenium, using: :headless_chrome
      end
    else
      # for Redmine 3 (Rails 4)
      require File.expand_path('../../../../../test/ui/base', __FILE__)
      Class.new(Redmine::UiTest::Base) do
        # Capybara has `:selenium_chrome_headless` driver by default, but it causes
        # `NameError: uninitialized constant Selenium::WebDriver::Chrome::Options`
        # because Redmine uses a older version of selenium-webdriver gem.
        Capybara.register_driver :redmine_login_bypass_selenium_chrome_headless do |app|
          Capybara::Selenium::Driver.new(app, browser: :chrome, args: ['--headless'])
        end

        # Redmine 3 uses phantomjs via remote driver but phantomjs is deprecated.
        # Use chromedriver instead.
        def before_setup
          Capybara.current_driver = :redmine_login_bypass_selenium_chrome_headless
          super
        end
      end
    end
end
