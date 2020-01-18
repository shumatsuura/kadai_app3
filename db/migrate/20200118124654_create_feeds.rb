class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.text :image
      t.text :content
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
