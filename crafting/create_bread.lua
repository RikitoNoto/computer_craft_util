wheat_slot = 13
seed_slot = 14

while true do
  wheat_count = turtle.getItemCount(wheat_slot)
  seed_count = turtle.getItemCount(seed_slot)

  if seed_count > 1 then
    turtle.drop(turtle.getItemCount(slot) - 1)
  end

  if wheat_count > 3 then
    turtle.select(wheat_slot)
    turtle.transferTo(5, 1)
    turtle.transferTo(6, 1)
    turtle.transferTo(7, 1)

    if turtle.craft() then
      turtle.select(1)
      turtle.dropDown()
    end
  end
end
