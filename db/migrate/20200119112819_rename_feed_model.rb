class RenameFeedModel < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :feeds, :users
    remove_index :feeds, :user_id
    remove_reference :feeds, :user
  end
end
