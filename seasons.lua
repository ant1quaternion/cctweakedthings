print("awake")
local monitor = peripheral.find("monitor")
function getUnmodifiedSeason(day)
  local h = day
  h=h-1
  h=h/8
  h=h%(3*4)
  h=math.floor(h)
  local subs = ""
  local season = ""
  if h%3==0 then
    subs = "early"
  elseif h%3 == 1 then
    subs = "mid"
  elseif h%3 == 2 then
    subs = "late"
  end
  if math.floor((h)/3)==0 then
    season = "spring"
  elseif math.floor((h)/3)==1 then
    season = "summer"
  elseif math.floor((h)/3)==2 then
    season = "autumn"
  elseif math.floor((h)/3)==3 then
    season = "winter"
  end
  return subs.." "..season
end
function getSubSeasonDate(day)
  return (day-1)%8+1
end
while true do
  monitor.clear()
  monitor.setCursorPos(1,1)
  monitor.write(tostring(os.day("ingame")).." day(s) elapsed")
  monitor.setCursorPos(1,2)
  monitor.write(getUnmodifiedSeason(os.day("ingame")) .. " ("..tostring(getSubSeasonDate(os.day("ingame"))).."/8)")
  sleep(10)
end
