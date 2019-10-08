module RedmineLoginBypass
  class Hook < Redmine::Hook::ViewListener
    render_on :view_account_login_bottom, partial: 'redmine_login_bypass/hooks/view_account_login_bottom'
  end
end
