class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.boolean :enabled
      t.boolean :visible
      t.string :name
    end
  end
end
