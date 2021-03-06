class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  has_many :relationships
  has_many :relationshipfavos
  has_many :favorites, through: :relationshipfavos, source: :favorite
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  # has_many :favorites, :through => :relationshipfavos, :source => <name>'

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def favorite(micro)
    # unless self == other_user
      # self.relationshipfavos.find_or_create_by(favorite_id: micro.id)
    # end
    
    p micro
    favo = Relationshipfavo.create!(user_id: self.id, favorite_id: micro.id)
  end
    

  def unfavorite(micro)
    relationshipfavo = self.relationshipfavos.find_by(favorite_id: micro.id)
    relationshipfavo.destroy if relationshipfavo
  end

  def favorite?(micro)
    self.favorites.include?(micro)
  end

  
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  def feed_self
    Micropost.where(user_id: self.id)
  end
  
end