
-- return the empty slot that find first
-- if there is no an empty slot, return 0
local function select_empty_slot()
  for i=1, 16 do
    turtle.select(i)

    -- getItemSpace return 64, if it's slot is empty.
    if turtle.getItemSpace() == 64 then
      return i
    end
  end
  
  return 0
end

local function turn_direction(direction)

  local turn_direction_table = {
    "left": [turtle.turnLeft],
    "right": [turtle.turnRight],
    "back": [turtle.turnLeft, turtle.turnLeft],
    "front": [],
    "top": [],
    "bottom": [],
  }
  
  -- turn the direction
  for turn_func in pairs(turn_direction_table[direction]) do
    turn_func()
  end
end

local function turn_direction_reverse(direction)

  local turn_direction_table = {
    "left": "right",
    "right": "left",
    "back": "back",
    "front": "front",
    "top": "top",
    "bottom": "bottom",
  }
  return turn_direction(turn_direction_table[direction])
end

local function suck_from(direction)
  local suck_function_table = {
    "left": turtle.suck,
    "right": turtle.suck,
    "back": turtle.suck,
    "front": turtle.suck,
    "top": turtle.suckUp,
    "bottom": turtle.suckDown,
  }

  return suck_function_table[direction]()
end

-- Refuel from the chest to the direction.
-- The direction is allowed below.
-- [top, bottom, front, back, left, right]
-- If the direction is in back, left, right,
-- The turtle is turn the direction.
--
-- This function return a integer value refueled supply value.
local function refuel_from(direction)
  if select_empty_slot() == 0 then
    print("No empty slot...")
    return 0
  end

  turn_diretion(direction)

  if not suck_from(direction) then
    return 0
  end

  turn_direction_reverse(direction)
  
  remain = turtle.getFuelLevel()
  turtle.refuel()
  return turtle.getFuelLevel() - remain
end

return {
  refuel_from = refuel_from,
}
