wheat_slot = 13
seed_slot = 14

while true do
  sleep(0.1)
  wheat_count = turtle.getItemCount(wheat_slot)
  seed_count = turtle.getItemCount(seed_slot)

  if seed_count > 1 then
    turtle.drop(turtle.getItemCount(seed_slot) - 1)
  end

  if wheat_count > 1 then
    turtle.dropDown(turtle.getItemCount(wheat_slot) - 1)
  end
end
