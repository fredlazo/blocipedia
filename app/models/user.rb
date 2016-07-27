class User < ActiveRecord::Base
  #before_save { self.role ||= :standard }
  after_initialize { self.role ||= :standard }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis

  enum role: [:standard, :premium, :admin]
end
