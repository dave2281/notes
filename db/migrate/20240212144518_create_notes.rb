class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :text
      t.string :tags

      t.timestamps
    end
  end
end
