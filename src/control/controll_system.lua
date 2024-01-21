if TurtleNavigator == nil then
  TurtleNavigator = require("move").TurtleNavigator
end

local Point = {}
function Point.new(position, action)
  return {
    position = position,
    action = action,
  }
end

local PositionController = {

}

function PositionController.new(points)
  local navigator = TurtleNavigator.new()
  return {
    points = points,
    navigator = navigator,
    get_current_position = function (self)
      return vector.new(gps.locate())
    end,
    run_one_way = function (self)
      local initial_position = points[1].position
      if initial_position ~= self:get_current_position() then
        self.navigator:move(self:get_current_position(), initial_position)
      end

      for i, point in pairs(points) do
        self.navigator:move(self:get_current_position(), point.position)
        point.action()
      end
    end,
    run = function (self, loop)
      repeat
        self:run_one_way()
      until loop
    end
  }
end

return {
  PositionController = PositionController,
  Point = Point,
}
