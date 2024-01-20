
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

local TurtleMove = {
  forward = forward,
  back = back,
  left = left,
  right = right,
  up = up,
  down = down,
}

if Navigator == nil then
  Navigator = require("navigator").Navigator
end

if Direction == nil then
  Direction = require("navigator").Direction
end

if Route == nil then
  Route = require("route").Route
end

if split == nil then
  split = require("string_util").split
end

local TurtleDirection = {
  new = function (self, direction)
    local instance = Direction.new(direction)
    instance.move = function(self, dest)
      local move_func = {
        TurtleMove.forward,
        TurtleMove.left,
        TurtleMove.back,
        TurtleMove.right,
      }
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

      if not move_func[move_direction]() then
        return false
      end

      self.direction = dest
      return true
    end
    return setmetatable(instance, Direction)
  end
}

local TurtleNavigator = {

  new = function ()
    local instance = Navigator.new()
    instance.direction_vector = vector.new(0, 0, 0)
    instance.direction =  TurtleDirection.new(Direction.UNKNOWN)

    -- check this turtles direction.
    instance.check_direction = function(self)
      local initial_locate = gps.locate()
      if not turtle.forward() then
        print("Didn't go front")
        return {}
      end

      local current_locate = gps.locate()

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
      local direction = Direction.UNKNOWN
      if self.direction_vector.y > 0 then
        direction = Direction.FRONT
      elseif self.direction_vector.y < 0 then
        direction = Direction.BACK
      elseif self.direction_vector.x > 0 then
        direction = Direction.RIGHT
      elseif self.direction_vector.x < 0 then
        direction = Direction.LEFT
      else
        direction = Direction.UNKNOWN
      end
      self.direction = TurtleDirection.new(direction)

      return self.direction
    end

    instance.rotate_direction = function (self, current_direction_vector)
      if current_direction_vector.x > 0 then
        return turtle.turnLeft()
      elseif current_direction_vector.x < 0 then
        return turtle.turnRight()
      elseif current_direction_vector.y < 0 then
        return turtle.turnRight() and turtle.turnRight()
      end
    end

    instance.go_route = function(self, route, delimiter)
        local route_array = split(route.route, delimiter)
        if #route_array > turtle.getFuelLevel() then
          print("Not enough fuel...")
          return
        end
        local move = TurtleMove
        for i, dest in pairs(route_array) do
          if dest == Route.FORWARD_STR then
            if not self.direction.move(self.direction, Direction.FRONT) then
              return
            end
          elseif dest == Route.BACK_STR then
            if not self.direction.move(self.direction, Direction.BACK) then
              return
            end
          elseif dest == Route.LEFT_STR then
            if not self.direction.move(self.direction, Direction.LEFT) then
              return
            end
          elseif dest == Route.RIGHT_STR then
            if not self.direction.move(self.direction, Direction.RIGHT) then
              return
            end
          elseif dest == Route.UP_STR then
            if not move.up() then
              return
            end
          elseif dest == Route.DOWN_STR then
            if not move.down() then
              return
            end
          else
            print("invalid string: ", dest)
          end
        end

    end


    instance.move = function (self, from, to)
      local route = self:create_route(from, to)
      if self.direction == Direction.UNKNOWN then
        self:check_direction()
      end



      self:rotate_direction(self.direction_vector)
      self:go_route(route, route.delimiter)

    end



    return setmetatable(instance, {__index = Navigator})
  end,

}



return {
  TurtleNavigator = TurtleNavigator,
  TurtleMove = TurtleMove,
}
