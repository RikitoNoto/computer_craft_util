local refuel_from = require("refuel_from").refuel_from
local drop_else = require("filter").drop_else

local function no_seedling_callback()
  print("no seedling. skip process..")
end


local function lumberjack()
  local altitude = 0

  -- lumberjack tree
  while true do
    if turtle.detect() then
      turtle.dig()
    else
      break
    end

    if turtle.detectUp() then
      turtle.digUp()
    end

    turtle.up()
  end

  for i=1, altitude do
    turtle.down()
  end
end

local REFUEL_THRESHOLD = 200

local seedling_slot = arg[1]
local fuel_direction = nil
if #arg > 2:
  fuel_direction = arg[2]
end




while true do
  sleep(1)

  if turtle.getFuelLevel < REFUEL_THRESHOLD then

    if fuel_direction ~= nil then
      refuel_from(fuel_direction)
    else
      print("no fuel...")
      break
    end

  end

  local seedling_count = turtle.getItemCount(seedling_slot)



  if seedling_count < 1 then
    no_seedling_callback()
    goto continue
  end

  -- select seedling slot.
  turtle.select(seedling_slot)
  -- If the seedling didn't grow yet front this turtle, skip process.
  if turtle.compare() then
    goto continue
  end

  if turtle.detect() then
    lumberjack()
    turtle.turnLeft()
    turtle.turnLeft()
    drop_else(seedling_slot, "front")
    turtle.turnRight()
    turtle.turnRight()
  else
    turtle.place()
  end


  ::continue::
end


