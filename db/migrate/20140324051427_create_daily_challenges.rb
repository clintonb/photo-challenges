class CreateDailyChallenges < ActiveRecord::Migration
  def change
    create_table :daily_challenges do |t|
      t.references :challenge, index: true

      t.timestamps
    end
  end
end
