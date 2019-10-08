module RedmineLoginBypass
  module UserPatch
    def check_password?(*)
      true
    end

    def check_password_change(*)
      # Do nothing
    end
  end
end
