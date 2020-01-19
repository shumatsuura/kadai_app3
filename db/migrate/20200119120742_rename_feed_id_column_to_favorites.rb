class RenameFeedIdColumnToFavorites < ActiveRecord::Migration[5.2]
  def change
    rename_column :favorites, :feed_id, :picture_id
  end
end
