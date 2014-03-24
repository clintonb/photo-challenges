class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user, index: true, null: false
      t.references :challenge, index: true, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
