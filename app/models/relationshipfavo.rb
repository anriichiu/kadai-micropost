class Relationshipfavo < ApplicationRecord
  belongs_to :user
  belongs_to :favorite, class_name: 'User'
  
  validates :user_id, presence: true
  validates :favorite_id, presence: true
end
