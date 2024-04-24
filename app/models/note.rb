# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user
  before_save :process_tags
  after_save :render_markdown

  validate :check_notes_limit, on: :create
  validates :title, presence: true, length: { maximum: 255 }
  validates :text, presence: true
  validates :tags, length: { maximum: 255 }, allow_blank: true

  private

  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, 
                                                                   fenced_code_blocks: true, strikethrough: true, underline: true,
                                                                   highlight: true, quote: true, footnotes: true,
                                                                   superscript: true, no_intra_emphasis: true, lax_spacing: true)
  end

  def render_markdown
    self.text = markdown.render(text)
  end

  def check_notes_limit
    if Note.where(created_at: Time.zone.today.all_day).count >= 15
      errors.add(:note, 'Превышено максимальное количество заметок за сегодня')
    end
  end

  def process_tags
    if tags.present?
      # Разделяем строку на отдельные теги по символу '#', а также удаляем все пробелы
      tags_array = tags.split(/[#\s]+/).map(&:strip).reject(&:empty?)

      # Сохраняем массив тегов в параметр tags
      self.tags = tags_array
    end
  end
end
