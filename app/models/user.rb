class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable,
         :confirmable, 
         :omniauthable
  include GraphqlDevise::Concerns::Model
  has_secure_password

  has_many :links, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 3 }
end