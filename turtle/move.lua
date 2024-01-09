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
    return false
  end

  if not turtle.turnLeft() then
    print("Don't turn left")
    return false
  end

  return forward()
end

local function left()
  if not turtle.turnLeft() then
    print("Don't turn left")
    return false
  end

  return forward()
end

local function right()
  if not turtle.turnRight() then
    print("Don't turn right")
    return false
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

Direction = {
  FRONT = 1,
  LEFT = 2,
  BACK = 3,
  RIGHT = 4,
}

function Direction.new(direction)
  return {
    direction = direction,
    move_func = { forward, left, back, right, },
    move = function(self, dest)
      local current = self.direction
      local move_direction = dest
      if current == Direction.FRONT then
        move_direction = dest
      elseif current == Direction.LEFT then
        move_direction = dest - 1
      elseif current == Direction.BACK then
        move_direction = dest - 2
      elseif current == Direction.RIGHT then
        move_direction = dest - 3
      end

      if move_direction <= 0 then
        move_direction = 4 + move_direction
      end

      if not self.move_func[move_direction]() then
        return false
      end

      self.direction = dest
      return true
    end
  }
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

    direction = Direction.new(Direction.FRONT),

    move = function(self, route, delimiter)
      local route_array = split(route, delimiter)
      if #route_array > turtle.getFuelLevel() then
        print("Not enough fuel...")
        return
      end

      for i, dest in pairs(route_array) do
        if dest == self.forward_str then
          if not self.direction.move(self.direction, Direction.FRONT) then
            return
          end
        elseif dest == self.back_str then
          if not self.direction.move(self.direction, Direction.BACK) then
            return
          end
        elseif dest == self.left_str then
          if not self.direction.move(self.direction, Direction.LEFT) then
            return
          end
        elseif dest == self.right_str then
          if not self.direction.move(self.direction, Direction.RIGHT) then
            return
          end
        elseif dest == self.up_str then
          if not up() then
            return
          end
        elseif dest == self.down_str then
          if not down() then
            return
          end
        else
          print("invalid string: ", dest)
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
