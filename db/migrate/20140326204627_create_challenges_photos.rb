class CreateChallengesPhotos < ActiveRecord::Migration
  def change
    create_table :challenges_photos do |t|
      t.references :challenge, index: true
      t.references :photo, index: true
    end

    add_index :challenges_photos, [:challenge_id, :photo_id], unique: true
  end
end
