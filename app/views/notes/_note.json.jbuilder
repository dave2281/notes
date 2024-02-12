json.extract! note, :id, :title, :text, :tags, :created_at, :updated_at
json.url note_url(note, format: :json)
