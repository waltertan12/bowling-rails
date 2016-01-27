class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer 'num_frames', default: 0
      t.integer 'num_rolls', default: 0
      t.timestamps null: false
    end
  end
end
