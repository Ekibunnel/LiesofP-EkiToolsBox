require("giveitem")

RegisterConsoleCommandHandler("giveallitems", function(FullCommand, Parameters, Ar)
	GlobalAr = Ar

    if #Parameters > 1 then
		Log(string.format("Too many Params ! ??? : %s", Parameters[2]))
		Log("Usage : giveallitems [Quantity]")
		return false
	end

	local ItemInfoObject = FindObject(nil, nil, "/Game/ContentInfo/InfoAsset/ItemInfo.ItemInfo", false)
	local ContentInfoDBObject = ItemInfoObject["ContentInfoDB"]

	ContentInfoDBObject:ForEachProperty(function(Property)
		if Property:IsA(PropertyTypes.ArrayProperty) then
			local PropertyName = Property:GetFName():ToString()
			local PropertyObject = ContentInfoDBObject[PropertyName]
			if PropertyObject:GetArrayNum() > 1 and PropertyName == "_ItemCommon_array" then
				PropertyObject:ForEach(function(index, elem)
					local element = elem:get()
					local ItemCodeName = element["_code_name"]:ToString()
					GiveItem(ItemCodeName,Parameters[1])
				end)
			end
		end
	end)

    return true
end)
print("[LiesofP EkiToolsBox] giveallitems cmd setup\n")