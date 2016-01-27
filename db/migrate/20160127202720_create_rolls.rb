class CreateRolls < ActiveRecord::Migration
  def change
    create_table :rolls do |t|
      t.integer 'pins'
      t.integer 'roll_number', null: false
      t.integer 'game_id', null: false, index: true
      t.integer 'frame_id', null: false, index: true
      t.timestamps null: false
    end
  end
end
