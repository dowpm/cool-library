class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :full_name, presence: true
    validates :password, presence: true, length: { in: 6..100 }
  
    has_secure_password
end
