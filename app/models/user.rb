class User < ApplicationRecord
  has_many :itineraries
  has_secure_password

  validates :password, presence: true, length: { maximum: 32, minimum: 3 }
  validates :email, presence: true, length: { maximum: 40 }

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt :Password.create(string, cost: cost)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def full_name 
    self.first_name + " " + self.last_name
  end
end
