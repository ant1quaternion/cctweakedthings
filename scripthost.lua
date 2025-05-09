local modem = peripheral.find("modem") or error("No modem attached", 0)
local UUID = modem.getNameLocal()
local process = nil
modem.open(1)
modem.transmit(1,1,{["from"]=UUID,["to"]="host",["data"]="connect"})
local kill = false
while true do
    event, side, frequency, replyFrequency, message, distance = os.pullEvent("modem_message")
    if process then
        kill = true
        coroutine.resume(process)
        process = nil
    end
    if message["to"]==UUID or message["to"]=="all" then
        kill = false
        process = coroutine.create(loadstring("if kill then return end "..message.data))
        coroutine.resume(process)
    end
end
