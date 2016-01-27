class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer 'game_id', null: false, index: true
      t.integer 'frame_number', null: false
      t.integer 'num_rolls', default: 0
      t.integer 'pins_remaining'
      t.string  'history', array: true, default: []
      t.timestamps null: false
    end
  end
end
