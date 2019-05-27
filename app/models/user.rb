class User < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts


    validates :full_name, presence: true

    validates :email, presence: true

  def should_generate_new_friendly_id?
    slug.blank? || full_name_changed?
  end
end
