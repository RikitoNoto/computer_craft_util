
while true do
  sleep(0.1)
  redstone.setOutput("back", true)
  turtle.select(1)
  wheat_count = turtle.getItemCount(wheat_slot)
  if wheat_count <= 3 then
    goto continue
  end
  turtle.transferTo(2, math.floor(wheat_count / 3))
  turtle.transferTo(3, math.floor(wheat_count / 3))

  turtle.craft()

  turtle.select(1)
  turtle.dropDown()

  turtle.select(2)
  turtle.dropDown()

  turtle.select(3)
  turtle.dropDown()
  redstone.setOutput("back", false)
	::continue::
end
