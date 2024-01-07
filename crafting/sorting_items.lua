item1_slot = tonumber(arg[1])
item2_slot = tonumber(arg[2])

while true do
  sleep(0.1)
  item1_count = turtle.getItemCount(item1_slot)
  item2_count = turtle.getItemCount(item2_slot)

  if item1_count > 1 then
    turtle.select(item1_slot)
    turtle.drop(turtle.getItemCount(item1_slot) - 1)
  end

  if item2_count > 1 then
    turtle.select(item2_slot)
    turtle.dropDown(turtle.getItemCount(item2_slot) - 1)
  end
end
