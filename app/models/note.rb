class Note < ApplicationRecord
  belongs_to :user
  before_save :process_tags
  after_save 

  validates :title, presence: true, length: {maximum:255}
  validates :text, presence: true
  validates :tags, length: { maximum: 255 }, allow_blank: true

  private

  def process_tags
    if tags.present?
      # Разделяем строку на отдельные теги по символу '#', а также удаляем все пробелы
      tags_array = tags.split(/[#\s]+/).map(&:strip).reject(&:empty?)
  
      # Сохраняем массив тегов в параметр tags
      self.tags = tags_array
    end
  end  
end
