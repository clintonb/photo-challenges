class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :description, :null => false
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
