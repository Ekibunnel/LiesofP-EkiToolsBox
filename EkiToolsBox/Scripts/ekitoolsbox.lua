local version = "0.0.4"

function Usage()
	Log("Usage : ekitoolsbox [option]\n  option :  [-v | version] [-cmd | command]")
end

function CustomCmd()
	Log("Commands:\n   dumpitemscodename\n   deleteitem\n   giveallitems\n   giveitem\n   giveweapon")
end

function EkiToolsBoxVersion()
	Log("EkiToolsBox version "..version)
end

RegisterConsoleCommandHandler("ekitoolsbox", function(FullCommand, Parameters, Ar)
	GlobalAr = Ar
    if #Parameters > 1 then
		Log(string.format("Too many Params ! err : %s", Parameters[2]))
		Usage()
		return false
	end

    local option = Parameters[1]

	if option == "-v" or option == "version" then
		EkiToolsBoxVersion()
	elseif option == "-cmd" or option == "command" then
		CustomCmd()
	else
		EkiToolsBoxVersion()
		Usage()
		CustomCmd()
    end
    return true
end)
print("[LiesofP EkiToolsBox] ekitoolsbox cmd setup\n")