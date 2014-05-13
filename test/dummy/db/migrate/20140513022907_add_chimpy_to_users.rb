class AddChimpyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :chimpy_synced_at, :datetime
  end
end