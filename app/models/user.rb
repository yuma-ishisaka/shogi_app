class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: {maximum: 30}
    validates :email, presence: true, length: {maximum: 100}
    validates :kiryoku, presence: true, length: {maximum: 20}
    validates :battle_app, presence: true, length: {maximum: 20}
    validates :profile, presence: true, length: {maximum: 255}
    
    has_secure_password
    
    has_many :posts
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    has_many :messages
    has_many :sent_messages, through: :messages, source: :receive
    has_many :reverses_of_message, class_name: 'Message', foreign_key: 'receive_id'
    has_many :received_messages, through: :reverses_of_message, source: :user
    
    mount_uploader :icon, ImagesUploader
    
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
end
