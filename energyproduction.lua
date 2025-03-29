print("RUNNING")
local monitor = peripheral.wrap("left")
local energystorage = peripheral.wrap("back")
local oldFE = energystorage.getEnergy()
local FElist = {}
while true do
    sleep(1)
    local newFE = energystorage.getEnergy()
    local FEdiff = newFE-oldFE
    print(FEdiff)
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write(tostring(FEdiff) .. "FE/s energy production")
    monitor.setCursorPos(1,2)
    table.insert(FElist,FEdiff)
    if #FElist>10 then
        table.remove(FElist,1)
    end
    local FEavg = 0
    for _, p in pairs(FElist) do
        FEavg=FEavg+p
    end
    FEavg=FEavg/#FElist
    monitor.write(tostring(FEavg) .. "FE/s energy production avg")
    monitor.setCursorPos(1,3)
    monitor.write(tostring(newFE) .. "FE energy storage")
    oldFE = newFE
end
