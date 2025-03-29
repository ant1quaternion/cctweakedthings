print("RUNNING")
local monitor = peripheral.wrap("left")
local energystorage = peripheral.wrap("back")
local oldFE = energystorage.getEnergy()
while true do
    sleep(1)
    local newFE = energystorage.getEnergy()
    local FEdiff = newFE-oldFE
    print(FEdiff)
    monitor.setCursorPos(1,1)
    monitor.write(tostring(FEdiff) .. "FE/s energy production")
    monitor.setCursorPos(1,2)
    monitor.write(tostring(newFE) .. "FE energy storage")
    monitor.clear()
    oldFE = newFE
end
