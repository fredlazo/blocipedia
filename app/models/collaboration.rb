class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  validates_uniqueness_of :user_id, scope: :wiki_id, message: " is already a collaborator"

end
