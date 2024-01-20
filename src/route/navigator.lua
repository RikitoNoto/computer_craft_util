if Route ~= nil then
  Route = require("route").Route
end

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
  }
end

local Navigator = {

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
    create_route = function(self, from, to)
      local route_vector = to - from
      local route = Route.new("", ",")

      if route_vector.y > 0 then
        route:forward(route_vector.y)
      end

      if route_vector.y < 0 then
        route:back(route_vector.y * -1)
      end

      if route_vector.x > 0 then
        route:right(route_vector.x)
      end

      if route_vector.x < 0 then
        route:left(route_vector.x * -1)
      end

      if route_vector.z > 0 then
        route:up(route_vector.z)
      end

      if route_vector.z < 0 then
        route:down(route_vector.z * -1)
      end

      return route
    end,
  }
end

return {
  Navigator = Navigator,
  Direction = Direction,
}
