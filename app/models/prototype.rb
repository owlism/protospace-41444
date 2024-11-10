class Prototype < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  validates :title,presence:true
  validates :catch_copy,presence:true
  validates :concept, presence:true
  validates :image, presence:true, unless: :was_attached?

  has_many :comments, dependent: :destroy

  def was_attached?
    self.image.attached?
  end
end
