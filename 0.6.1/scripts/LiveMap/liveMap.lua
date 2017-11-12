-- liveMap.lua -*-lua-*-
-- "THE BEER-WARE LICENSE" (Revision 42):
-- <mail@michael-fitzmayer.de> wrote this file.  As long as you retain
-- this notice you can do whatever you want with this stuff. If we meet
-- some day, and you think this stuff is worth it, you can buy me a beer
-- in return.  Michael Fitzmayer


JsonInterface = require("jsonInterface")


Methods = {}


local path = "/path/to/assets/json/"
local updateInterval = 5

local timer = tes3mp.CreateTimerEx("TimerExpired", time.seconds(updateInterval), "i", 0)
local Info = {}


tes3mp.StartTimer(timer)


Methods.Update = function()
    Info = {}
    for pid, player in pairs(Players) do
        if player:IsLoggedIn() then
            Info[pid] = {}
            Info[pid].name = Players[pid].name
            Info[pid].x = math.floor( tes3mp.GetPosX(pid) + 0.5 )
            Info[pid].y = math.floor( tes3mp.GetPosY(pid) + 0.5 )
            Info[pid].rot = math.floor( math.deg( tes3mp.GetRotZ(pid) ) + 0.5 ) % 360
            Info[pid].isOutside = tes3mp.IsInExterior(pid)
        end
    end
    JsonInterface.save(path .. "LiveMap.json", Info)
    tes3mp.StartTimer(timer);
end


function TimerExpired()
    Methods.Update()
end


return Methods

