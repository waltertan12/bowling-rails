json.extract!(
  frame,
  :num_rolls,
  :pins_remaining
)
json.rolls frame.rolls.map { |r| r.pins }
json.complete frame.complete?
