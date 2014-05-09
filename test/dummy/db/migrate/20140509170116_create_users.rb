class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.datetime :chimpy_synced_at
      t.integer :chimpy_mc_id

      t.timestamps
    end
  end
end
