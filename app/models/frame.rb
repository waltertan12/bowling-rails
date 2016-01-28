# == Schema Information
#
# Table name: frames
#
#  id             :integer          not null, primary key
#  game_id        :integer          not null
#  frame_number   :integer          not null
#  num_rolls      :integer          default(0)
#  pins_remaining :integer
#  history        :string           default([]), is an Array
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Frame < ActiveRecord::Base
  belongs_to :game
  has_many   :rolls
  validates  :frame_number,   inclusion: { in: 1..10 }, allow_nil: true
  validates  :pins_remaining, inclusion: { in: 0..10 }, allow_nil: true
  validates  :num_rolls,      inclusion: { in: 0..3 }
  validates  :game_id,        presence:  true

  def bowl(options = {})
    self.num_rolls += 1
    self.save
    if frame_number < 10
      bowl_normal(options) 
    else
      bowl_final(options)
    end
  end

  def strike?
    rolls.length == 1 &&
    rolls.first.pins == 10
  end

  def spare?
    !strike? &&  
    rolls.length == 2 &&
    (rolls[0].pins + rolls[1].pins == 10)
  end

  def score
    return score_final if frame_number == 10
    score_normal
  end

  def complete?
    if frame_number < 10
      strike? || spare? || num_rolls == 2
    else
      (num_rolls == 2 && !can_bowl_extra_frame?) ||
      (num_rolls == 3)
    end
  end

  private
  def bowl_normal(options)
    roll = Roll.create(roll_number: game.num_rolls)
    self.game.rolls << roll
    self.rolls << roll
    self.pins_remaining -= roll.bowl(pins_remaining, options)
    self.save
  end

  def bowl_final(options)
    reset_pins if can_bowl_extra_frame?
    bowl_normal(options)
  end

  def score_normal
    return nil unless complete?

    if strike?
      next_rolls = get_next_rolls(2)
      10 + get_next_rolls(2).reduce(:+) if next_rolls.length == 2
    elsif spare?
      next_rolls = get_next_rolls(1)
      10 + get_next_rolls(1).first if next_rolls.length == 1
    else
      rolls[0].pins + rolls[1].pins
    end
  end

  def score_final
    rolls.reduce(0) do |accum, elem|
      accum += elem.pins
    end
  end

  def reset_pins
    self.pins_remaining = 10
    self.save
  end

  def get_next_rolls(num)
    self.game.rolls.select do |roll|
      roll.roll_number > last_roll_number &&
      roll.roll_number <= (last_roll_number + num)
    end.map { |r| r.pins }
  end

  def last_roll_number
    last_roll = rolls.last
    last_roll.roll_number if last_roll
  end

  def can_bowl_extra_frame?
    frame_number == 10 && (
      strike? ||
      spare? ||
      (rolls.length == 2 && rolls[0].pins + rolls[1].pins >= 10)
    )
  end
end
