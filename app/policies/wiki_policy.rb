class WikiPolicy < ApplicationPolicy


  def edit?
    #false if record.private? && record.user != user
    case record.private
      when false
        #Public wikis. All users should be able to edit any public wiki
        true if user.present?
      when true
        #Private wikis. Must be admin, or the post creator to edit private wiki
        true if user.present? && (user.admin? || record.user == user)
      else
        #Dissallow any other record.private value
        false
    end

    

  end

end
