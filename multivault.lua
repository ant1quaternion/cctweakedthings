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
local funny = http.get("https://raw.githubusercontent.com/ant1quaternion/cctweakedthings/refs/heads/main/votv_startup.wav").readAll()
if speaker and funny ~= nil and funny ~= "" then

    local decoder = dfpwm.make_decoder()
        local buffer = decoder(funny)

        while not speaker.playAudio(buffer) do
            os.pullEvent("speaker_audio_empty")
        end
end
