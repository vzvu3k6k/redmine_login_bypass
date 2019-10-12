module RedmineLoginBypass
  SystemTestCase =
    if defined? ActionDispatch::SystemTestCase
      ActionDispatch::SystemTestCase
    else
      # for Redmine < 4 (Rails < 5)
      require File.expand_path('../../../../../test/ui/base', __FILE__)
      Redmine::UiTest::Base
    end
end
