RegisterConsoleCommandHandler("giveweapon", function(FullCommand, Parameters, Ar)
    if #Parameters < 2 then
		Log("Param missing !")
		Log("Usage : giveweapon [Handle CodeName] [Blade CodeName] [Quantity]")
		return false
	end
    if #Parameters > 3 then
		Log(string.format("Too many Params ! err : %s", Parameters[4]))
		Log("Usage : giveweapon [Handle CodeName] [Blade CodeName] [Quantity]")
		return false
	end
	
	
    GlobalAr = Ar
    
    local HandleCodeName = Parameters[1]
	local BladeCodeName = Parameters[2]
    local Quantity = Parameters[3]

    if not HandleCodeName or HandleCodeName == "" or HandleCodeName == " " then
        Log("No Handle CodeName name supplied !")
        return true
    end
    
	if not BladeCodeName or BladeCodeName == "" or BladeCodeName == " " then
        Log("No Blade CodeName name supplied !")
        return true
    end

    if not Quantity or Quantity == "" or Quantity == " " then
        Quantity = 1
	elseif tonumber(Quantity) < 1 then
        Log("Quantity is too low !")
        return false
	else
		Quantity = tonumber(Quantity)
		end
	
    -- Get PlayerInventory
	local PlayerInventory = FindFirstOf("LPlayerInventory")
    if not PlayerInventory:IsValid() then
        Log("Couldn't get PlayerInventory instance !")
        return false
    end
	-- Get ItemSystem
	local ItemSystem = FindFirstOf("LItemSystem")
    if not ItemSystem:IsValid() then
        Log("Couldn't get ItemSystem instance !")
        return false
    end

	for i = 1, Quantity do
		local ItemCreated = ItemSystem:CreateWeaponItem(FName(HandleCodeName),FName(BladeCodeName))
		if not ItemCreated:IsValid() then
			Log("Couldn't create the Item !\nHandle or Blade CodeName is probably wrong.")
			return false
		end
		Log(string.format("[LiesofP EkiToolsBox] ItemCreated : %s\n", ItemCreated:GetFullName()))
		local ItemAdded = PlayerInventory:AddItem(ItemCreated)
		if not ItemAdded == true then
			Log("Couldn't add the weapon to player inventory !")
			return false
		end
	end
    return true
end)
print("[LiesofP EkiToolsBox] giveweapon cmd setup\n")