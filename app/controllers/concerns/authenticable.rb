module Authenticable
  extend ActiveSupport::Concern

  included do

    def requires_user
      requires
    end

    def requires_vip
      requires(:vip)
    end

    def requires_admin
      requires(:admin)
    end

    def requires(role)
      if user_signed_in?
        has_role = role.nil? ? true : current_user.role == User::ROLES[role]
        return if has_role
      end
      render text: 'unauthorized', status: :unauthorized
    end

  end

end
