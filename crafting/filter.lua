filter_range = tonumber(arg[1])

while true do
  sleep(0.1)

  for i = 1 , 16 do
    for j=1, filter_range do
      turtle.select(i)
      if i <= filter_range then
        turtle.dropUp(turtle.getItemCount()-1)
      else
        if turtle.compareTo(j) then
          turtle.dropUp()
        else
          turtle.dropDown()
        end
      end
    end
  end
end
