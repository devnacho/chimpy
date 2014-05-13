class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :chimpy_synced_at, :string
  end
end
