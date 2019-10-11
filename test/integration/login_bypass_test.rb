require File.expand_path('../../../../../test/test_helper', __FILE__)

# This file is a system test but placed in test/integration directory
# because Redmine doesn't have a Rake task to run plugin's system tests.
class LoginByPassTest < ActionDispatch::SystemTestCase
  fixtures :users

  # To avoid `unknown error: DevToolsActivePort file doesn't exist` on GitHub Actions
  driven_by :selenium, using: :headless_chrome

  def test_login_page_form
    visit signin_path

    assert_selector 'select[name=username]'
    assert_selector 'input[name=password][type=hidden]', visible: false
  end

  def test_login_bypass
    visit signin_path

    select 'jsmith', from: 'username'
    click_on 'Login'

    assert_text 'Logged in as jsmith'
  end

  # admin accounts have a suffix of "(admin)".
  def test_admin_label
    visit signin_path

    assert_selector 'option', text: 'admin (admin)'
  end

  def test_must_change_password_bypass
    jsmith = users(:users_002)

    # Use `update_attribute` instead of `update!` to avoid validation.
    # Because jsmith lacks an email address, it is an invalid record.
    jsmith.update_attribute(:must_change_passwd, true)

    visit signin_path

    select 'jsmith', from: 'username'
    click_on 'Login'

    assert_no_text 'Change password'
    assert_text 'Logged in as jsmith'
  end
end
