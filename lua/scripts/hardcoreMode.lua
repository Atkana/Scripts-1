-- hardcoreMode.lua -*-lua-*-
-- "THE BEER-WARE LICENSE" (Revision 42):
-- <mail@michael-fitzmayer.de> wrote this file.  As long as you retain
-- this notice you can do whatever you want with this stuff. If we meet
-- some day, and you think this stuff is worth it, you can buy me a beer
-- in return.  Michael Fitzmayer


require("color")
userConfig = require("userConfig")


Methods = {}


-- Add [ hardcoreMode = require("hardcoreMode") ] to the top of myMod.lua
-- Find "Players[pid]:ProcessDeath()" inside myMod.lua and add:
-- [ hardcoreMode.Check(pid) ]
-- directly above it.

-- Add [ hardcoreMode = require("hardcoreMode") ] to the top of server.lua
-- Find "elseif cmd[1] == "difficulty" and admin then" inside server.lua and insert:
-- [ elseif cmd[1] == "hardcore" then hardcoreMode.Toggle(pid) ]
-- directly above it.


local playerFilePath = "/path/to/data/player/"
local configKeyword  = "hardcore"


Methods.Check = function(pid)
    if userConfig.GetValue(pid, configKeyword) == "true" then
        local message = color.Crimson .. "You have passed away. Rest in peace." .. color.Default
        os.remove(playerFilePath .. tes3mp.GetName(pid) .. ".json")
        tes3mp.SendMessage(pid, message, false)
        tes3mp.SendMessage(pid, color.Crimson .. tes3mp.GetName(pid) .. " is dead and gone for good. Press F to pay respects." .. color.Default, true)
        while true do end
    end
end


Methods.Toggle = function(pid)
    local message = ""

    if userConfig.GetValue(pid, configKeyword) == "true" then
        message = message .. color.MediumSpringGreen .. "Hardcore mode disabled.\n"
        userConfig.SetValue(pid, configKeyword, "false")
    else
        message = message .. color.Crimson .. "Hardcore mode enabled. Be careful, death is now permanent!\n"
        userConfig.SetValue(pid, configKeyword, "true")
    end

    tes3mp.SendMessage(pid, message, false)
end


return Methods
