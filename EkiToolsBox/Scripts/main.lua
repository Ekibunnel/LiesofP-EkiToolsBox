GlobalAr = nil

function Log(Message)
    print(Message .. "\n")
    if type(GlobalAr) == "userdata" and GlobalAr:type() == "FOutputDevice" then
        GlobalAr:Log(Message)
    end
end

require("giveitem")
require("giveweapon")
require("dumpitemscodename")
require("giveallitems")