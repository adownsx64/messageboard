module ApplicationHelper

  def admin?
    if logged_in?
      if current_user.permission_level == 1 || current_user.id == 1
        return true
      else
        return false
      end
    end
  end
end
