Redmine::Plugin.register :redmine_login_bypass do
  name 'Redmine Login Bypass'
  description 'Login without passwords'
  version '1.0.0'
  url 'https://github.com/vzvu3k6k/redmine_login_bypass'
end

require 'redmine_login_bypass/hook'

ActiveSupport::Reloader.to_prepare do
  User.prepend RedmineLoginBypass::UserPatch
end
