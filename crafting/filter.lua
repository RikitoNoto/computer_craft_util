filter_range = arg[1]

while true do
  sleep(0.1)

  for i = 2, 16 do
    for j=1, filter_range do
      turtle.select(i)
      if turtle.compareTo(j) then
        turtle.dropDown()
      else
        turtle.dropUp()
      end
    end
  end
end
