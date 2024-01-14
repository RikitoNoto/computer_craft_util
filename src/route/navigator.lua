local Direction = {
  UNKNOWN = 0,
  FRONT = 1,
  LEFT = 2,
  BACK = 3,
  RIGHT = 4,
}

function Direction.new(direction)
  return {
    direction = direction,
    move_func = { TurtleMove.forward, TurtleMove.left, TurtleMove.back, TurtleMove.right, },
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

local Navigator = {

}

function Navigator.new(route)
  return {
    route = route,
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
    create_route = function(self, from, to)
      local route_vector = to - from

      if route_vector.y > 0 then
        self.route:forward(route_vector.y)
      end

      if route_vector.y < 0 then
        self.route:back(route_vector.y * -1)
      end

      if route_vector.x > 0 then
        self.route:right(route_vector.x)
      end

      if route_vector.x < 0 then
        self.route:left(route_vector.x * -1)
      end

      if route_vector.z > 0 then
        self.route:up(route_vector.z)
      end

      if route_vector.z < 0 then
        self.route:down(route_vector.z * -1)
      end

      return route
    end,
  }
end

return {
  Navigator = Navigator,
  Direction = Direction,
}
