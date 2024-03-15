module NotesHelper
  def format_tags(tags, as_hash_tags: true)
    if as_hash_tags
      tags.map { |tag| "##{tag}" }.join(' ')
    else
      tags.join(' ')
    end
  end
end
