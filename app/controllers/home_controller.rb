class HomeController < ApplicationController
  before_action :all_tags, only: [:index]

  def index
    @notes = Note.all
  end

  private

  def all_tags
    @tags = Note.pluck(:tags).flatten.uniq.compact
  end
end
