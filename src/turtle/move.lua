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
  UNKNOWN = 0,
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
  FORWARD_STR_DEFAULT = "^",
  BACK_STR_DEFAULT = "v",
  LEFT_STR_DEFAULT = "<",
  RIGHT_STR_DEFAULT = ">",
  UP_STR_DEFAULT = "*",
  DOWN_STR_DEFAULT = "@",
  CALLBACK_STR = "(.*)",
}

function Route.new(route, delimiter)
  return {
    route = route,
    delimiter = delimiter,
    direction = Direction.new(Direction.FRONT),
    move = function(self, callback)
      local route_array = split(route, delimiter)
      if #route_array > turtle.getFuelLevel() then
        print("Not enough fuel...")
        return false
      end

      for i, dest in pairs(route_array) do
        if dest == Route.FORWARD_STR then
          if not self.direction.move(self.direction, Direction.FRONT) then
            return false
          end
        elseif dest == Route.BACK_STR then
          if not self.direction.move(self.direction, Direction.BACK) then
            return false
          end
        elseif dest == Route.LEFT_STR then
          if not self.direction.move(self.direction, Direction.LEFT) then
            return false
          end
        elseif dest == Route.RIGHT_STR then
          if not self.direction.move(self.direction, Direction.RIGHT) then
            return false
          end
        elseif dest == Route.UP_STR then
          if not up() then
            return false
          end
        elseif dest == Route.DOWN_STR then
          if not down() then
            return false
          end
        elseif string.match(dest, "%((.*)%)") ~= nil then
          if callback ~= nil then
            if not callback(string.match(dest, "%((.*)%)")) then
              print("fail callback")
              return false
            end
          end
        else
          print("invalid string: ", dest)
        end
      end
      return true
    end,
  }
end

Navigator = {

}

function Navigator.new()
  return {
    direction_vector = vector.new(0, 0, 0),
    direction = Direction.UNKNOWN,

    -- check this turtles direction.
    check_direction = function(self)
      initial_locate = gps.locate()
      if not turtle.forward() then
        print("Didn't go front")
        return {}
      end

      current_locate = gps.locate()

      if not turtle.back() then
        print("Didn't go back")
        return {}
      end

      if initial_locate == nil or current_locate == nil then
        print("Didn't get location")
        return {}
      end

      self.direction_vector = vector.new(current_locate[1], current_locate[2], current_locate[3]) -
          vector.new(initial_locate[1], initial_locate[2], initial_locate[3])

      if direction_vector.y > 0 then
        self.direction = Direction.FRONT
      elseif direction_vector.y < 0 then
        self.direction = Direction.BACK
      elseif direction_vector.x > 0 then
        self.direction = Direction.RIGHT
      elseif direction_vector.x > 0 then
        self.direction = Direction.LEFT
      else
        self.direction = Direction.UNKNOWN
      end

      return self.direction
    end,

    -- create the route from [from] to [to]
    create_route = function(from, to, initial_direction)
      local route_vector = to - from

      local route_str = ""
      local write_route = function (route_str, sign, length, delimiter)
        for i=1, length do
          route_str = route_str..sign
          if i == length then
            break
          end
          route_str = route_str..delimiter
        end
        return route_str
      end

      if route_vector.y > 0 then
        route_str = write_route(route_str, "^", route_vector.y, ",")
      end

      if route_vector.y < 0 then
        route_str = write_route(route_str, "v", route_vector.y * -1, ",")
      end

      if route_vector.x > 0 then
        route_str = write_route(route_str, ">", route_vector.x, ",")
      end

      if route_vector.x < 0 then
        route_str = write_route(route_str, "<", route_vector.x * -1, ",")
      end

      return Route.new(route_str, ",")
    end,
  }
end

return {
  Route = Route,
}
