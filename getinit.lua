return function(scripttoload)
local a = http.get(scripttoload)
if a then
  print("gone through load 1")
  local b = a.readAll()
  if b then
    print("gone through load 2 new")
    print(string.sub(b,1,10).."...")
    local c = loadstring(b)
    c()
  else
    print("unable to read file?")
  end
else
  print("file link not valid?")
end
end
