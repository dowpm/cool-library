class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :full_name, presence: true
    validates :password, presence: true, length: { in: 6..100 }
  
    has_secure_password

    def self.find_or_create_by_omniauth(auth_hash)
        self.where(:email => auth_hash["info"]["email"]).first_or_create do |user|
            user.full_name = auth_hash["info"]["name"]
            user.password = SecureRandom.hex
        end
    end
end
