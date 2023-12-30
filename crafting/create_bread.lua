
while true do
  sleep(0.1)
  redstone.setOutput("back", true)
  turtle.select(1)
  wheat_count = turtle.getItemCount(wheat_slot)
  turtle.transferTo(2, math.floor(wheat_count / 3))
  turtle.transferTo(3, math.floor(wheat_count / 3))

  turtle.craft()
  turtle.dropDown()
  redstone.setOutput("back", false)
end
