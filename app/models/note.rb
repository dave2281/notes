class Note < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {maximum:255}
  validates :text, presence: true
  validates :tags, length: { maximum: 255 }, allow_blank: true
end
