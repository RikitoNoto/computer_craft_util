local function split(str, delimiter)
  local result = {}
  local from = 1
  local delim_from, delim_to = string.find(str, delimiter, from)

  while delim_from do
    table.insert(result, string.sub(str, from, delim_from - 1))
    from = delim_to + 1
    delim_from, delim_to = string.find(str, delimiter, from)
  end

  table.insert(result, string.sub(str, from))

  return result
end

local function forward()
  if not turtle.forward() then
    print("Don't move forward...")
    return false
  end
  return true
end

local function back()
  if not turtle.turnLeft() then
    print("Don't turn left")
  end

  if not turtle.turnLeft() then
    print("Don't turn left")
  end

  return forward()
end

local function left()
  if not turtle.turnLeft() then
    print("Don't turn left")
  end

  return forward()
end

local function right()
  if not turtle.turnRight() then
    print("Don't turn right")
  end

  return forward()
end

local function up()
  if not turtle.up() then
    print("Don't move up...")
    return false
  end
  return true
end


local function down()
  if not turtle.down() then
    print("Don't move down...")
    return false
  end
  return true
end

Route = {

}

function Route.new(forward_str, back_str, left_str, right_str, up_str, down_str)
  return {
    forward_str = forward_str,
    back_str = back_str,
    left_str = left_str,
    right_str = right_str,
    up_str = up_str,
    down_str = down_str,

    move = function(self, route, delimiter)
      local route_array = split(route, delimiter)
      if #route_array > turtle.getFuelLevel() then
        print("Not enough fuel...")
        return
      end

      for i, direction in pairs(route_array) do
        if direction == self.forward_str then
          if not forward() then
            return
          end
        elseif direction == self.back_str then
          if not back() then
            return
          end
        elseif direction == self.left_str then
          if not left() then
            return
          end
        elseif direction == self.right_str then
          if not right() then
            return
          end
        elseif direction == self.up_str then
          if not up() then
            return
          end
        elseif direction == self.down_str then
          if not down() then
            return
          end
        else
          print("invalid string: ", direction)
        end
      end
    end,
  }
end

local function create_route()
  return Route.new("^", "v", "<", ">", "*", "@")
end

return {
  create_route = create_route,
}
