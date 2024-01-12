_G.vector = require("libs/vector").vector

local move = require("turtle/move")
describe("Move", function()
  describe("Navigator", function()
    local test_cases = {
      {from=vector.new(0, 0, 0), to=vector.new(0, 0, 0), direction=Direction.FRONT, expect_route="",},

      {from=vector.new(0, 0, 0), to=vector.new(0, 1, 0), direction=Direction.FRONT, expect_route="^",},
      {from=vector.new(0, 0, 0), to=vector.new(0, 2, 0), direction=Direction.FRONT, expect_route="^,^",},
      {from=vector.new(0, 5, 0), to=vector.new(0, 15, 0), direction=Direction.FRONT, expect_route="^,^,^,^,^,^,^,^,^,^",},

      {from=vector.new(0, 1, 0), to=vector.new(0, 0, 0), direction=Direction.FRONT, expect_route="v",},
      {from=vector.new(0, 2, 0), to=vector.new(0, 0, 0), direction=Direction.FRONT, expect_route="v,v",},
      {from=vector.new(0, 340, 0), to=vector.new(0, 338, 0), direction=Direction.FRONT, expect_route="v,v",},

      {from=vector.new(0, 0, 0), to=vector.new(1, 0, 0), direction=Direction.FRONT, expect_route=">",},
      {from=vector.new(0, 0, 0), to=vector.new(2, 0, 0), direction=Direction.FRONT, expect_route=">,>",},
      {from=vector.new(303, 0, 0), to=vector.new(306, 0, 0), direction=Direction.FRONT, expect_route=">,>,>",},

      {from=vector.new(1, 0, 0), to=vector.new(0, 0, 0), direction=Direction.FRONT, expect_route="<",},
      {from=vector.new(3, 0, 0), to=vector.new(0, 0, 0), direction=Direction.FRONT, expect_route="<,<,<",},
      {from=vector.new(325, 0, 0), to=vector.new(320, 0, 0), direction=Direction.FRONT, expect_route="<,<,<,<,<",},
    }
    for i, test_case in pairs(test_cases) do
      it("should be"..test_case.expect_route.."when the positons are from ("..test_case.from.x..","..test_case.from.y..","..test_case.from.z..") to ("..test_case.to.x..","..test_case.to.y..","..test_case.to.z..") with "..test_case.direction, function()
        local navigator = Navigator.new()
        local route = navigator.create_route(test_case.from, test_case.to, test_case.direction)
        assert.is_equal(test_case.expect_route, route.route)
        assert.is_equal(",", route.delimiter)
      end)
    end
  end)
end)
