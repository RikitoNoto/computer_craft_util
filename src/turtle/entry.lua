local function read_trim_lf(path)
  local file = fs.open(path, "r")
  local result = ""
  while true do
    local line = file.readLine()
    if line == nil then
      return result
    end

    result = result .. line
  end
end

return {
  read_trim_lf = read_trim_lf,
}
