json.extract!(
  game,
  :id,
  :num_frames
)

scores = game.scores
aggregate = 0

total_score = scores.map do |score|
  aggregate += score if score
end

pins_removed = game.rolls.map do |roll|
  roll.pins
end
 
json.frames game.frames, partial: 'frame', as: :frame 
# json.pins_removed  game.rolls, partial: 'roll', as: :roll
json.pins_removed  pins_removed
json.scores game.scores
json.total_score total_score
