class CreateDailyChallenges < ActiveRecord::Migration
  def change
    create_table :daily_challenges do |t|
      t.references :challenge, index: true, null: false

      t.timestamps
    end

    add_index :daily_challenges, :challenge_id, :unique => true, :name => :uq_challenge_id
    add_index :daily_challenges, :created_at, :unique => true
  end
end
