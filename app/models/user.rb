class User < ApplicationRecord
  has_secure_password

  has_many :links, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 3 }
end