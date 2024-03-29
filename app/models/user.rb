class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }
  has_many :tasks, dependent: :destroy, foreign_key: :user_id
  has_secure_password
  has_secure_token :authentication_token

  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, on: :create

  before_save :to_lowercase

  private

  def to_lowercase
    email.downcase
  end
end