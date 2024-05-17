require 'rails_helper'

default_title = 'Test title!'
default_text = 'This is a test note'

RSpec.describe Note, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john1@gmail.com', password: 'password') }

  context 'validations' do
    it 'is valid with valid attributes' do
      note = Note.new(title: default_title, text: default_text, color: 'blue', user: user)
      expect(note).to be_valid
    end

    it 'is not valid without a title' do
      note = Note.new(text: default_text, color: 'blue', user: user)
      expect(note).not_to be_valid
    end

    it 'is not valid without text' do
      note = Note.new(title: default_title, color: 'blue', user: user)
      expect(note).not_to be_valid
    end

    it 'is not valid with a title longer than 255 characters' do
      long_title = 'a' * 256
      note = Note.create(title: long_title, text: default_text, color: 'blue', user: user)
      expect(note).not_to be_valid
    end

    it 'is not valid with tags longer than 255 characters' do
      long_tags = 'a' * 256
      note = Note.new(title: default_title, text: default_text, color: 'blue', tags: long_tags, user: user)
      expect(note).not_to be_valid
    end
  end

  context 'note limits' do
    it 'limits the number of notes created per day to 15' do
      allow(Time).to receive(:now).and_return(Time.zone.today.midday)

      15.times do
        Note.create(title: default_title, text: default_text, color: 'blue', user: user)
      end

      extra_note = Note.new(title: default_title, text: default_text, color: 'blue', user: user)
      expect(extra_note).not_to be_valid
      expect(extra_note.errors[:note]).to include('Превышено максимальное количество заметок за сегодня')
    end
  end

  context 'tags processing' do
    it 'processing tags correctly before saving' do
      note = Note.new(title: default_title, text: default_text, color: 'blue', tags: '#tag1 #tag2 #tag3', user: user)
      note.save 
      expect(note.tags).to eq("[\"tag1\", \"tag2\", \"tag3\"]")
    end
  end
end
