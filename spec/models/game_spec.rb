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

require 'rails_helper'

RSpec.describe Game, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
