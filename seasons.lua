print("awake")
local monitor = peripheral.find("monitor")
local inv = peripheral.find("minecraft:chest")
while true do
  monitor.clear()
  monitor.setCursorPos(1,1)
  monitor.write(tostring(os.day("ingame")).." day(s) elapsed")
  monitor.setCursorPos(1,2)
  local slot1 = inv.getItemDetail(1)
  print(textutils.serialize(slot1))
  sleep(10)
end
