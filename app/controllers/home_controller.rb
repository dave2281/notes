class HomeController < ApplicationController
  before_action :all_tags, only: [:index]

  def show_by_tag
    @tag = params[:tag]
    @notes = Note.where('tags LIKE ?', "%#{@tag}%")
  end

  def index
    @notes = Note.all
  end

  private

  def all_tags
    @tags = Note.pluck(:tags).map { |tags| JSON.parse(tags) }.flatten.uniq.compact
  end
end
