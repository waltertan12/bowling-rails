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

require 'rails_helper'

RSpec.describe Roll, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
