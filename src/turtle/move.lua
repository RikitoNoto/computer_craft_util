local TurtleMove = {
  forward= function ()
    if not turtle.forward() then
      print("Don't move forward...")
      return false
    end
    return true
  end,

  back = function()
    if not turtle.turnLeft() then
      print("Don't turn left")
      return false
    end

    if not turtle.turnLeft() then
      print("Don't turn left")
      return false
    end

    return TurtleMove.forward()
  end,

  left= function ()
    if not turtle.turnLeft() then
      print("Don't turn left")
      return false
    end

    return TurtleMove.forward()
  end,

  right= function ()
    if not turtle.turnRight() then
      print("Don't turn right")
      return false
    end

    return TurtleMove.forward()
  end,

  up= function ()
    if not turtle.up() then
      print("Don't move up...")
      return false
    end
    return true
  end,

  down= function ()
    if not turtle.down() then
      print("Don't move down...")
      return false
    end
    return true
  end,
}



if Navigator == nil then
  Navigator = require("navigator").Navigator
end

if Direction == nil then
  Direction = require("navigator").Direction
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

  new = function (route, move)
    local instance = Navigator.new(route)
    instance.direction_vector = vector.new(0, 0, 0)
    instance.direction =  TurtleDirection.new(Direction.UNKNOWN)
    instance.move_class = move

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

    instance.rotate_direction = function (current_direction_vector)
      if current_direction_vector.x > 0 then
        return turtle.turnLeft()
      elseif current_direction_vector.x < 0 then
        return turtle.turnRight()
      elseif current_direction_vector.y < 0 then
        return turtle.turnRight() and turtle.turnRight()
      end
    end

    instance.go_route = function(self, route, delimiter)
        local route_array = split(route, delimiter)
        if #route_array > turtle.getFuelLevel() then
          print("Not enough fuel...")
          return
        end
        local move = TurtleMove.new()
        for i, dest in pairs(route_array) do
          if dest == self.route.forward_str then
            if not self.direction.move(self.direction, Direction.FRONT) then
              return
            end
          elseif dest == self.route.back_str then
            if not self.direction.move(self.direction, Direction.BACK) then
              return
            end
          elseif dest == self.route.left_str then
            if not self.direction.move(self.direction, Direction.LEFT) then
              return
            end
          elseif dest == self.route.right_str then
            if not self.direction.move(self.direction, Direction.RIGHT) then
              return
            end
          elseif dest == self.route.up_str then
            if not move.up() then
              return
            end
          elseif dest == self.route.down_str then
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



      self:rotate_direction()
      self:go_route(route, self.route.delimiter)

    end



    return setmetatable(instance, {__index = Navigator})
  end,

}



return {
  TurtleNavigator = TurtleNavigator ,
  TurtleMove = TurtleMove,
}
