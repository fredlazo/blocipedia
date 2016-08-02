class User < ActiveRecord::Base
  #before_save { self.role ||= :standard }
  after_initialize { self.role ||= :standard }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #has_many :wikis
  has_many :collaborations
  has_many :wikis, through: :collaborations

  enum role: [:standard, :premium, :admin]
end
