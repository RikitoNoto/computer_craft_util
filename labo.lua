local Class = {

}

function Class.new()
  local instance={}

  instance.func = function (self, count)
    print(self)
    print(count)
  end

  return instance
end


Class.new():func(1)
