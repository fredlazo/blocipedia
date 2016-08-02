include ApplicationHelper

class Wiki < ActiveRecord::Base
  belongs_to :user

  #scope :public_wikis, -> {where(private: false)}

  has_many :collaborations
  #has_many :users
  has_many :users, through: :collaborations


  default_scope { order('title DESC') }

  scope :visible_to, -> (user) { user && ((user.role == "admin") || (user.role == "premium")) ? all : where(private: false)}

  def available_users
      available = []

      User.order(username: :asc).each do |user|
        available << user unless self.users.include?(user)
      end

      return available

  end
end
