module RedmineLoginBypass
  module UserPatch
    def check_password?(*)
      true
    end

    def must_change_password?(*)
      false
    end
  end
end
