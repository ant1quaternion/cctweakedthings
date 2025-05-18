--https://github.com/ant1quaternion/cctweakedthings/blob/main/votv_startup.wav
local dfpwm = _G.require("cc.audio.dfpwm")
local modem = peripheral.find("modem") or error("No modem attached", 0)
local UUID = modem.getNameLocal()
local process = nil
local code = http.get("https://raw.githubusercontent.com/ant1quaternion/cctweakedthings/refs/heads/main/multivaulthost.lua").readAll()
modem.open(1)
co = coroutine.create(function()
    modem.transmit(1,1,{["from"]=UUID,["to"]="host",["data"]="connect"})
    while true do
        event, side, frequency, replyFrequency, message, distance = os.pullEvent("modem_message")
        if message.to == "host" then
            modem.transmit(1,1,{["from"]="host",["to"]=message.from,["data"]=code})
        end
    end
end)
coroutine.resume(co)
modem.transmit(1,1,{["from"]="host",["to"]="all",["data"]=code})
local speaker = peripheral.find("speaker") or print("Speaker must be attached for the funny")
local funny = http.get("https://raw.githubusercontent.com/ant1quaternion/cctweakedthings/refs/heads/main/votv_startup.txt").readAll()
-- display logo
local logo = [[
         @@@
  @@@   @   @
 @   @ @     @
@     @@     @
@     @ @   @ 
 @   @   @@@
  @@@ @@@
     @   @
    @     @
    @     @
     @   @
      @@@
    ]]
function floorDivision(a,b)
    return math.floor(a/b+0.5)
end
local logoheight = 12
local logowidth = 14
local monitor = peripheral.find("monitor")
local x,y = monitor.getSize()
monitor.clear()
monitor.setTextColor(colors.orange)
local i = math.floor(y/2-logoheight/2+0.5)
local squee = math.floor(x/2-logowidth/2+0.5)
for str in string.gmatch(logo, "([^".."\n".."]+)") do
    for b = 1,string.len(str) do
        monitor.setCursorPos(squee+b-1,i)
        if string.sub(str,b,b) == "@" then
            monitor.blit(" ",tostring(colors.orange),tostring(colors.orange))
        end
    end
    i=i+1
end
monitor.setCursorPos(squee,i)
monitor.setTextColor(colors.white)
monitor.write("meadowOS")
if speaker and funny ~= nil and funny ~= "" then
    local decoder = dfpwm.make_decoder()
    local maxlen = 16*1024
    local bufthing = ""
    local ml = string.len(funny)
    for i = 1,ml do
        bufthing = bufthing..string.sub(funny,i,i)
        if string.len(bufthing) == maxlen or i == ml then
            local buffer = decoder(bufthing)
            while not speaker.playAudio(buffer) do
                os.pullEvent("speaker_audio_empty")
            end 
            bufthing = ""
        end
    end
end
os.sleep(5)
monitor.clear()
