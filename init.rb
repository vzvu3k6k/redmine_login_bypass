# Disable on non-development environments by default
# so that it won't affect other plugin's tests or open a backdoor in production
if Rails.env.development? || ENV['ENABLE_REDMINE_LOGIN_BYPASS'] == '1'
  Redmine::Plugin.register :redmine_login_bypass do
    name 'Redmine Login Bypass'
    description 'Login without passwords'
    version '1.0.0'
    url 'https://github.com/vzvu3k6k/redmine_login_bypass'
  end

  require 'redmine_login_bypass/hook'

  # ActionDispatch::Reloader is deprecated in Rails 5 (Redmine 4).
  reloader =
    if defined? ActiveSupport::Reloader
      ActiveSupport::Reloader
    else
      ActionDispatch::Reloader
    end

  reloader.to_prepare do
    User.prepend RedmineLoginBypass::UserPatch
  end
end
