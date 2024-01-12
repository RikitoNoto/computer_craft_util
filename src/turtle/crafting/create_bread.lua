local function create_bread(wheat_slot)
  local wheat_count = turtle.getItemCount(wheat_slot)
  if wheat_count >= 3 then
    turtle.transferTo(2, math.floor(wheat_count / 3))
    turtle.transferTo(3, math.floor(wheat_count / 3))

    if turtle.craft() then
      if wheat_count % 3 ~= 0 then
        return 2
      end
      return 1
    end
  end
  return 0
end

return {
  create_bread = create_bread,
}
