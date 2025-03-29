print("RUNNING")
local monitor = peripheral.wrap("left")
local energystorage = peripheral.wrap("back")
local oldFE = energystorage.getEnergy()
while sleep(1) do
    local newFE = energystorage.getEnergy()
    local FEdiff = newFE-oldFE
    monitor.setCursorPos(1,1)
    monitor.write(tostring(FEdiff) .. "FE/s energy production")
    oldFE = newFE
end
