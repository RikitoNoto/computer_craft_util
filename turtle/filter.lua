local function filter(filter_range)
  while true do
    sleep(0.1)

    for i = 1, 16 do
      for j = 1, filter_range do
        turtle.select(i)
        if i <= filter_range then
          turtle.dropUp(turtle.getItemCount() - 1)
        else
          if turtle.compareTo(j) then
            turtle.dropUp()
          else
            turtle.dropDown()
          end
        end
      end
    end
  end
end

local function has_value (val, array)
  for value in pairs(array) do
      if value == val then
          return true
      end
  end

  return false
end

local function drop_else(slots, direction)
  local drop_func = nil
  if direction == "top" then
    drop_func = turtle.dropUp
  else if direction == "bottom" then
    drop_func = turtle.dropDown
  else if direction == "front" then
    drop_func = turtle.drop
  else
    print("invalid direction.")
    return
  end

  for i=1, 16 do
    if not has_value(i, slots) then
      turtle.select(i)
      drop_func()
    end
  end
end


return {
  filter = filter,
  drop_else = drop_else,
}
