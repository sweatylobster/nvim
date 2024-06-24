-- can you see this
local test = [[2,2023-03-01,Mehrdad Shademan,Ana Cruz,09-15-1984,Charlotte Muscroft #018447,2]]
local header = [[invoice,dos,doctor,name,dob,interpreter,page]]

local function get_header(buffer)
  local header = vim.api.nvim_buf_get_lines(0,0,1,true)
  -- for k, v in pairs(r) do
  --   print(k,v)
  -- end
  return r
end

local function get_fields(csv_string)
  local a = {}
  for field in string.gmatch(csv_string, ",?([%a%-%s%#%w]+),?") do
    table.insert(a, field)
  end
  return a
end

local function label_fields(t, header)
  local b = {}
  assert (#t == #header, "gotta be same length mang")
  for i=1,#header do
    b[header[i]] = t[i]
  end
  return b
end

local row = get_fields(test)
local header = get_fields(header)
local result = label_fields(row, header)

for k, v in pairs(result) do
  print(k,v)
end
