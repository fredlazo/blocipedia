class Wiki < ActiveRecord::Base
  belongs_to :user

  default_scope { order('created_at DESC') }

  #scope :public_wikis, -> {where(private: false)}

  scope :visible_to, -> (user) { user && ((user.role == "admin") || (user.role == "premium")) ? all : where(private: false)}
end
