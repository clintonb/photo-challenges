class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user, index: true, null: false
      t.string :url, null: false
      t.references :data_source, index: true, null: false
      t.string :data_source_external_id, null: false

      t.timestamps
    end

    add_index :photos, [:data_source_id, :data_source_external_id], unique: true
  end
end
