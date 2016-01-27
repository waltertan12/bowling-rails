# == Schema Information
#
# Table name: rolls
#
#  id          :integer          not null, primary key
#  pins        :integer
#  roll_number :integer          not null
#  game_id     :integer          not null
#  frame_id    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Roll < ActiveRecord::Base
  belongs_to :game
  belongs_to :frame

  validates :pins, inclusion: { in: 0..10 }, allow_nil: true
  validates :roll_number, inclusion: { in: 1..21 }
  validates :game_id, :frame_id, presence: true

  def bowl(pins_remaining, options)
    puts 'Roll#bowl'
    case options[:bowling]
    when nil
      puts 'Nil case'
      self.pins = rand(pins_remaining + 1)
    when :strike
      puts 'Strike case'
      self.pins = pins_remaining
    when :custom
      puts 'Custom case'
      if options[:to_remove] > pins_remaining
        self.pins = pins_remaining
      else
        self.pins = options[:to_remove]
      end
    end
    self.save
    
    self.pins
  end
end
