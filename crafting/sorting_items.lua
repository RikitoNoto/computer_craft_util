item1_slot = arg[1]
item2_slot = arg[2]

while true do
  sleep(0.1)
  item1_count = turtle.getItemCount(item1_slot)
  item2_count = turtle.getItemCount(item2_slot)

  if item1_count > 1 then
    turtle.drop(turtle.getItemCount(item1_slot) - 1)
    redstone.setOutput("front", true)
    redstone.setOutput("front", false)
  end

  if item2_count > 1 then
    turtle.dropDown(turtle.getItemCount(item2_slot) - 1)
  end
end
