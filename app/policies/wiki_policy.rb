class WikiPolicy < ApplicationPolicy



  def edit?
    if record.private == false
      true if user.present?
    elsif record.private == true
      true if user.present? && (@user.admin? || record.user_id == @user.id || !(record.collaborations.where(user_id: @user.id).empty?))
    else
      false
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !(wiki.private?) || wiki.user_id == @user.id || wiki.collaborations.include?(@user)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if (wiki.private? == false) || !(wiki.collaborations.where(user_id: @user.id).empty?)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end


end
