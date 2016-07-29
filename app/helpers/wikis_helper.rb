module WikisHelper
  #Makes "Edit" and "Delete" buttons visible only to wiki owner
  def user_is_authorized_for_wiki?(wiki)
       current_user && (current_user == wiki.user)
  end

  def other_plan(current_user)
      return "Premium" if current_user.standard?
      return "Standard" if current_user.premium?
  end


end
