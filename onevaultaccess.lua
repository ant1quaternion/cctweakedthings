local vault = peripheral.find("inventory",function(a,b)
    print(peripheral.getName(b))
    return peripheral.getName(b) == "back"
end)
local output = peripheral.find("inventory",function(a,b)
    return peripheral.getName(b) ~= "back"
end)
local monitor = peripheral.find("monitor")
local x,y = monitor.getSize()
--y=y*4
local maxdisplay = y
local displaylineat = 1
local list = vault.list()
function  monitorrender()
    monitor.clear()
    for i = 0,y-1,1 do
        local ib = i+displaylineat
        monitor.setCursorPos(1,i)
        pcall(function ()
            local item = list[ib]
            monitor.write("x"..tostring(item.count).." "..tostring(vault.getItemDetail(ib).displayName))
        end)
    end
    monitor.setCursorPos(x,1)
    monitor.write("^")
    monitor.setCursorPos(x,y)
    monitor.write("v")
    monitor.setCursorPos(x-2,y)
    monitor.write("r")
end
function  floorDivision(a,b)
    return math.floor(a/b+0.5)
end
function itemSelected(slot,amount)
    amount = amount or 64
    if amount > 64 then
        amount = 64
    end
    if amount < 1 then
        amount = 1
    end
    monitor.clear()
    local yh = floorDivision((y-1),2)+1
    local updist = (yh-1)
    local downdist = (y-yh)
    monitor.setCursorPos((floorDivision((x-1),2))+1,(floorDivision((y-1),2))+1)
    monitor.write("x"..tostring(amount))
    for i = 1,updist do
    monitor.setCursorPos(floorDivision((x-1),2)+1,yh-i)
    if not (amount+i>64) then
        monitor.write(amount+i)
    end
    end
    for i = 1,downdist do
        monitor.setCursorPos(floorDivision((x-1),2)+1,yh+i)
        if not (amount-i<0) then
            monitor.write(amount-i)
        end
    end
    monitor.setCursorPos(1,1)
    monitor.write("x")
    monitor.setCursorPos(x,1)
    monitor.write("Y")
    local event, side, xa, ya = os.pullEvent("monitor_touch")
    if xa == 1 and ya == 1 then
    elseif xa==x and ya == 1 then
        output.pullItems("back",slot,amount)
    else
        local addifier = yh-ya
        itemSelected(slot,amount+addifier)
    end
end
monitorrender()
while true do
    local event, side, xa, ya = os.pullEvent("monitor_touch")
    if xa == x and ya == y then
        displaylineat=displaylineat+1
    elseif xa == x-2 and ya == y then
        list = vault.list()
    elseif xa == x and ya == 1 then
        displaylineat=displaylineat-1
    else
        local slot = ya-displaylineat+2
        itemSelected(slot)
    end
    if displaylineat<1 then
        displaylineat = 1
    end
    monitorrender()
end
