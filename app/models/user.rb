class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: {maximum: 30}
    validates :email, presence: true, length: {maximum: 255}
    
    has_secure_password
end
