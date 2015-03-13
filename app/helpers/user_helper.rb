module UserHelper

  def is_admin?
    return false unless user_signed_in?
    return false unless current_user.is_admin?
    return true
  end

  def is_vip?
    return false unless user_signed_in?
    return false unless current_user.is_vip?
    return true
  end

end
