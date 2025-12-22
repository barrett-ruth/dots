function preview(filepath, width)
  local file = io.open(filepath, "r")
  if not file then
    return
  end

  width = tonumber(width) or 80
  local lines_shown = 0
  local max_lines = 500

  for line in file:lines() do
    if #line > width then
      line = line:sub(1, width - 3) .. "..."
    end
    io.write(line .. '\n')
    lines_shown = lines_shown + 1
    if lines_shown >= max_lines then break end
  end

  file:close()
end
