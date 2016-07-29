class WikiPolicy < ApplicationPolicy


  def edit?
    if record.private == false
      true if user.present?
    elsif record.private == true
      true if user.present? && (user.admin? || record.user == user)
    else
      false
    end
  end

end
