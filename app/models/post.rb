class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_attached_file :image, styles: {large: "600x600>", medium: "300x300>", thumb: "150x150#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :title, :content, :category_id, presence:true

  belongs_to :user


  scope :approved, -> {
  where(approved: true)
  }
  scope :waiting_for_approval, -> {
  where(waiting_for_approval: true, approved: false)
  }
end
