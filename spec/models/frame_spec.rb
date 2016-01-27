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

require 'rails_helper'

RSpec.describe Frame, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
