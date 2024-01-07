function dig(height)

  while true do
    if not turtle.detect() then
      break
    end
    turtle.dig()
  end

  turtle.forward()

  for i = 0, (height-1) do
    turtle.digUp()
    turtle.up()
  end

  while true do
    if turtle.detectDown() then
      break
    end
    turtle.down()
  end

end

function go_straight(length, height)
  for i = 0, (length - 1) do
    dig(height)
  end
end

radius = arg[1]
height = arg[2]

for i = 1, radius do
  -- go ahead one block
  go_straight(1, height)
  turtle.turnRight()


  dig_length = (i + 1) * 2 - 1

  -- go to the first corner
  go_straight(math.floor(dig_length / 2), height)
  turtle.turnRight()

  go_straight((dig_length - 1), height)
  turtle.turnRight()

  go_straight((dig_length - 1), height)
  turtle.turnRight()

  go_straight((dig_length - 1), height)
  turtle.turnRight()

  go_straight(math.floor(dig_length / 2), height)
  turtle.turnLeft()
end

