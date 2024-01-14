_G.vector = require("libs/vector").vector
local Route = require("route/route").Route
local navigator = require("route/navigator")
local Navigator = navigator.Navigator
local Direction = navigator.Direction

describe("Move", function()
  describe("Navigator", function()
    local test_cases = {
      {from=vector.new(0, 0, 0), to=vector.new(0, 0, 0), expect_route="",},

      {from=vector.new(0, 0, 0), to=vector.new(0, 1, 0), expect_route="^",},
      {from=vector.new(0, 0, 0), to=vector.new(0, 2, 0), expect_route="^,^",},
      {from=vector.new(0, 5, 0), to=vector.new(0, 15, 0), expect_route="^,^,^,^,^,^,^,^,^,^",},

      {from=vector.new(0, 1, 0), to=vector.new(0, 0, 0), expect_route="v",},
      {from=vector.new(0, 2, 0), to=vector.new(0, 0, 0), expect_route="v,v",},
      {from=vector.new(0, 340, 0), to=vector.new(0, 338, 0), expect_route="v,v",},

      {from=vector.new(0, 0, 0), to=vector.new(1, 0, 0), expect_route=">",},
      {from=vector.new(0, 0, 0), to=vector.new(2, 0, 0), expect_route=">,>",},
      {from=vector.new(303, 0, 0), to=vector.new(306, 0, 0), expect_route=">,>,>",},

      {from=vector.new(1, 0, 0), to=vector.new(0, 0, 0), expect_route="<",},
      {from=vector.new(3, 0, 0), to=vector.new(0, 0, 0), expect_route="<,<,<",},
      {from=vector.new(325, 0, 0), to=vector.new(320, 0, 0), expect_route="<,<,<,<,<",},

      {from=vector.new(0, 0, 0), to=vector.new(0, 0, 1), expect_route="*",},
      {from=vector.new(0, 0, 0), to=vector.new(0, 0, 3), expect_route="*,*,*",},
      {from=vector.new(0, 0, 559), to=vector.new(0, 0, 563), expect_route="*,*,*,*",},

      {from=vector.new(0, 0, 1), to=vector.new(0, 0, 0), expect_route="@",},
      {from=vector.new(0, 0, 3), to=vector.new(0, 0, 0), expect_route="@,@,@",},
      {from=vector.new(0, 0, 999), to=vector.new(0, 0, 996), expect_route="@,@,@",},

      {from=vector.new(0, 0, 0), to=vector.new(1, 1, 1), expect_route="^,>,*",},
      {from=vector.new(1, 1, 1), to=vector.new(0, 0, 0), expect_route="v,<,@",},
    }
    for i, test_case in pairs(test_cases) do
      it("should be"..test_case.expect_route.."when the positons are from ("..test_case.from.x..","..test_case.from.y..","..test_case.from.z..") to ("..test_case.to.x..","..test_case.to.y..","..test_case.to.z..")", function()
        local navigator = Navigator.new(Route.new("", ","))
        local route = navigator:create_route(test_case.from, test_case.to)
        assert.is_equal(test_case.expect_route, route.route)
        assert.is_equal(",", route.delimiter)
      end)
    end
  end)
end)
