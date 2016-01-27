# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  num_frames :integer          default(0)
#  num_rolls  :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ActiveRecord::Base
  has_many :frames
  has_many :rolls

  def scores
    self.frames.map do |f|
      f.score
    end
  end

  def current_frame
    frames.last
  end

  def bowl(options = {})
    raise 'Game Over' if over?
    self.num_rolls += 1
    if !current_frame || current_frame.complete?
      puts "making a new frame when on Frame Number #{num_frames}" if num_frames > 8
      self.num_frames += 1
      new_frame = Frame.new(
        game_id: id, 
        frame_number: num_frames, 
        pins_remaining: 10
      )
      self.frames << new_frame
    end
    self.save
    current_frame.bowl(options)
  end

  def over?
    num_frames == 10 && frames[9].complete?
  end
end
