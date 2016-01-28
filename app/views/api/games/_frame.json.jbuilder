json.extract!(
  frame,
  :num_rolls,
  :pins_remaining
)

json.complete frame.complete?