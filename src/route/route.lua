
local Route = {
  FORWARD_STR = "^",
  BACK_STR = "v",
  LEFT_STR = "<",
  RIGHT_STR = ">",
  UP_STR = "*",
  DOWN_STR = "@",
  CALLBACK_STR = "(.*)",
}

local function write_route(route, sign, length, delimiter)
  local new_route = route.route
  if length ~= 0 and #(route.route) > 0 then
    new_route = route.route..delimiter
  end

  for i=1, length do
    new_route = new_route..sign
    if i == length then
      break
    end

    new_route = new_route..delimiter
  end

  return new_route
end

function Route.new(route, delimiter)
  return {
    route = route,
    delimiter = delimiter,


    forward = function (self, count)
      self.route = write_route(self, Route.FORWARD_STR, count, self.delimiter)
    end,
    back = function (self, count)
      self.route = write_route(self, Route.BACK_STR, count, self.delimiter)
    end,
    left = function (self, count)
      self.route = write_route(self, Route.LEFT_STR, count, self.delimiter)
    end,
    right = function (self, count)
      self.route = write_route(self, Route.RIGHT_STR, count, self.delimiter)
    end,
    up = function (self, count)
      self.route = write_route(self, Route.UP_STR, count, self.delimiter)
    end,
    down = function (self, count)
      self.route = write_route(self, Route.DOWN_STR, count, self.delimiter)
    end,
  }
end

return {
  Route = Route,
}
