class CreateServers < ActiveRecord::Migration[8.0]
  def change
    create_table :servers do |t|
      t.string :name
      t.string :ip
      t.integer :region
      t.datetime :frabricated_at

      t.timestamps
    end
  end
end
