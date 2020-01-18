class RemoveUsersIdToFeeds < ActiveRecord::Migration[5.2]
  def change
    remove_index :feeds, :users_id
    remove_reference :feeds, :users
  end
end
