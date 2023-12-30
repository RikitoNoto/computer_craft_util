function dig(height)

  while true do
    if not turtle.detect() then
      break
    end
    turtle.dig()
  end

  turtle.forward()

  for i = 0, height do
    turtle.digUp()
  end

  while true do
    if turtle.detectDown() then
      break
    end
    turtle.down()
  end

end

radius = arg[1]
height = arg[2]

for i = 0, radius do
  dig_length = (i + 1) * 2 - 1

  dig()
  turtle.turnRight()
  for j = 0, math.floor(dig_length / 2) do
    dig()
  end

  turtle.turnRight()
  for j = 0, (dig_length - 1) do
    dig()
  end

  turtle.turnRight()
  for j = 0, (dig_length - 1) do
    dig()
  end

  turtle.turnRight()
  for j = 0, (dig_length - 1) do
    dig()
  end

  turtle.turnRight()
  for j = 0, math.ceil(dig_length / 2) do
    dig()
  end

  turtle.turnLeft()
end

