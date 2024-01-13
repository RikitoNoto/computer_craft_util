local Route = require("route/route").Route

describe("route", function()
  describe("Route", function()
    describe("initialize", function()
      local test_cases = {
        {route="", delimiter="", expect_route="", expect_delimiter="",},
        {route="^", delimiter=",", expect_route="^", expect_delimiter=",",},
      }

      for i, test_case in pairs(test_cases) do
        it("should be the route: "..test_case.expect_route.." delimiter: "..test_case.expect_delimiter..
          " when route: "..test_case.expect_route..", delimiter: "..test_case.delimiter,
          function()
            local route = Route.new(test_case.route, test_case.delimiter)
            assert.is_equal(test_case.expect_route, route.route)
            assert.is_equal(test_case.expect_delimiter, route.delimiter)
          end
        )
      end
    end)


    describe("forward", function()
      local test_cases = {
        {route="", delimiter="", count=0, expect_route="", expect_delimiter="",},
        {route="^", delimiter=",", count=0, expect_route="^", expect_delimiter=",",},
        {route="", delimiter=",", count=1, expect_route="^", expect_delimiter=",",},
        {route="^", delimiter=",", count=1, expect_route="^,^", expect_delimiter=",",},
        {route="^,^", delimiter=",", count=3, expect_route="^,^,^,^,^", expect_delimiter=",",},
      }

      for i, test_case in pairs(test_cases) do
        it("should be the route: "..test_case.expect_route.." delimiter: "..test_case.expect_delimiter..
          " when route: "..test_case.expect_route..", delimiter: "..test_case.delimiter.." with forward "..test_case.count.." times",
          function()
            local route = Route.new(test_case.route, test_case.delimiter)
            route:forward(test_case.count)
            assert.is_equal(test_case.expect_route, route.route)
            assert.is_equal(test_case.expect_delimiter, route.delimiter)
          end
        )
      end
    end)


    describe("back", function()
      local test_cases = {
        {route="", delimiter="", count=0, expect_route="", expect_delimiter="",},
        {route="v", delimiter=",", count=0, expect_route="v", expect_delimiter=",",},
        {route="", delimiter=",", count=1, expect_route="v", expect_delimiter=",",},
        {route="v", delimiter=",", count=1, expect_route="v,v", expect_delimiter=",",},
        {route="v,v", delimiter=",", count=3, expect_route="v,v,v,v,v", expect_delimiter=",",},
      }

      for i, test_case in pairs(test_cases) do
        it("should be the route: "..test_case.expect_route.." delimiter: "..test_case.expect_delimiter..
          " when route: "..test_case.expect_route..", delimiter: "..test_case.delimiter.." with back "..test_case.count.." times",
          function()
            local route = Route.new(test_case.route, test_case.delimiter)
            route:back(test_case.count)
            assert.is_equal(test_case.expect_route, route.route)
            assert.is_equal(test_case.expect_delimiter, route.delimiter)
          end
        )
      end
    end)


    describe("left", function()
      local test_cases = {
        {route="", delimiter="", count=0, expect_route="", expect_delimiter="",},
        {route="<", delimiter=",", count=0, expect_route="<", expect_delimiter=",",},
        {route="", delimiter=",", count=1, expect_route="<", expect_delimiter=",",},
        {route="<", delimiter=",", count=1, expect_route="<,<", expect_delimiter=",",},
        {route="<,<", delimiter=",", count=3, expect_route="<,<,<,<,<", expect_delimiter=",",},
      }

      for i, test_case in pairs(test_cases) do
        it("should be the route: "..test_case.expect_route.." delimiter: "..test_case.expect_delimiter..
          " when route: "..test_case.expect_route..", delimiter: "..test_case.delimiter.." with left "..test_case.count.." times",
          function()
            local route = Route.new(test_case.route, test_case.delimiter)
            route:left(test_case.count)
            assert.is_equal(test_case.expect_route, route.route)
            assert.is_equal(test_case.expect_delimiter, route.delimiter)
          end
        )
      end
    end)


    describe("right", function()
      local test_cases = {
        {route="", delimiter="", count=0, expect_route="", expect_delimiter="",},
        {route=">", delimiter=",", count=0, expect_route=">", expect_delimiter=",",},
        {route="", delimiter=",", count=1, expect_route=">", expect_delimiter=",",},
        {route=">", delimiter=",", count=1, expect_route=">,>", expect_delimiter=",",},
        {route=">,>", delimiter=",", count=3, expect_route=">,>,>,>,>", expect_delimiter=",",},
      }

      for i, test_case in pairs(test_cases) do
        it("should be the route: "..test_case.expect_route.." delimiter: "..test_case.expect_delimiter..
          " when route: "..test_case.expect_route..", delimiter: "..test_case.delimiter.." with right "..test_case.count.." times",
          function()
            local route = Route.new(test_case.route, test_case.delimiter)
            route:right(test_case.count)
            assert.is_equal(test_case.expect_route, route.route)
            assert.is_equal(test_case.expect_delimiter, route.delimiter)
          end
        )
      end
    end)


    describe("up", function()
      local test_cases = {
        {route="", delimiter="", count=0, expect_route="", expect_delimiter="",},
        {route="*", delimiter=",", count=0, expect_route="*", expect_delimiter=",",},
        {route="", delimiter=",", count=1, expect_route="*", expect_delimiter=",",},
        {route="*", delimiter=",", count=1, expect_route="*,*", expect_delimiter=",",},
        {route="*,*", delimiter=",", count=3, expect_route="*,*,*,*,*", expect_delimiter=",",},
      }

      for i, test_case in pairs(test_cases) do
        it("should be the route: "..test_case.expect_route.." delimiter: "..test_case.expect_delimiter..
          " when route: "..test_case.expect_route..", delimiter: "..test_case.delimiter.." with up "..test_case.count.." times",
          function()
            local route = Route.new(test_case.route, test_case.delimiter)
            route:up(test_case.count)
            assert.is_equal(test_case.expect_route, route.route)
            assert.is_equal(test_case.expect_delimiter, route.delimiter)
          end
        )
      end
    end)


    describe("down", function()
      local test_cases = {
        {route="", delimiter="", count=0, expect_route="", expect_delimiter="",},
        {route="@", delimiter=",", count=0, expect_route="@", expect_delimiter=",",},
        {route="", delimiter=",", count=1, expect_route="@", expect_delimiter=",",},
        {route="@", delimiter=",", count=1, expect_route="@,@", expect_delimiter=",",},
        {route="@,@", delimiter=",", count=3, expect_route="@,@,@,@,@", expect_delimiter=",",},
      }

      for i, test_case in pairs(test_cases) do
        it("should be the route: "..test_case.expect_route.." delimiter: "..test_case.expect_delimiter..
          " when route: "..test_case.expect_route..", delimiter: "..test_case.delimiter.." with down "..test_case.count.." times",
          function()
            local route = Route.new(test_case.route, test_case.delimiter)
            route:down(test_case.count)
            assert.is_equal(test_case.expect_route, route.route)
            assert.is_equal(test_case.expect_delimiter, route.delimiter)
          end
        )
      end
    end)
  end)
end)
