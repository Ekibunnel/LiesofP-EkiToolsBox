RegisterConsoleCommandHandler("dumpitemscodename", function(FullCommand, Parameters, Ar)
	GlobalAr = Ar

	local ItemInfoObject = FindObject(nil, nil, "/Game/ContentInfo/InfoAsset/ItemInfo.ItemInfo", false)
	local ContentInfoDBObject = ItemInfoObject["ContentInfoDB"]
	local dumpString = ""
	dumpString = dumpString..'{\n	"ItemsCodeName":\n	{'
	ContentInfoDBObject:ForEachProperty(function(Property)
		if Property:IsA(PropertyTypes.ArrayProperty) then
			local PropertyName = Property:GetFName():ToString()
			local PropertyObject = ContentInfoDBObject[PropertyName]
			if PropertyObject:GetArrayNum() > 1 then
				dumpString = dumpString..'\n		"'..PropertyName..'"'..': [\n'
				PropertyObject:ForEach(function(index, elem)
					local element = elem:get()
					dumpString = dumpString..'			"'..element["_code_name"]:ToString()..'"'
					if index ~= PropertyObject:GetArrayNum() then
						dumpString = dumpString..','
					end
					dumpString = dumpString..'\n'
				end)
				dumpString = dumpString..'		],'
			end
		end
	end)
	dumpString = string.sub(dumpString, 1, -2)..'\n	}\n}'
	--Log(dumpString)
	local DumpFileName = "Dump_ItemsCodeName.json"
	local File = io.open(DumpFileName, "w+")
	File:write(dumpString)
	File:close()
	local WorkingDirHandle = io.popen("cd")
	local WorkingDir = WorkingDirHandle:read('*l')
	WorkingDirHandle:close()
	Log(string.format('[LiesofP EkiToolsBox] Dump saved as %s in "%s"', DumpFileName, WorkingDir))
    return true
end)
print("[LiesofP EkiToolsBox] dumpitems cmd setup\n")