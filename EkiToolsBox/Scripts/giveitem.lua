RegisterConsoleCommandHandler("giveitem", function(FullCommand, Parameters, Ar)
	GlobalAr = Ar
    if #Parameters < 1 then
		Log("Param missing !")
		Log("Usage : giveitem [Item CodeName] [Quantity]")
		return false
	end
    if #Parameters > 2 then
		Log(string.format("Too many Params ! ??? : %s", Parameters[3]))
		Log("Usage : giveitem [Item CodeName] [Quantity]")
		return false
	end

	if not GiveItem(Parameters[1],Parameters[2]) then
		return false
	end

	return true
end)

function GiveItem(ItemCodeName,Quantity)
	if not ItemCodeName or ItemCodeName == "" or ItemCodeName == " " then
        Log("No Item CodeName name supplied !")
        return false
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
	local InventoryItem = nil
	InventoryItem = PlayerInventory:FindItemByCodeName(FName(ItemCodeName))
	if not InventoryItem:IsValid() then
		local ItemCreated = ItemSystem:CreateItem(FName(ItemCodeName))
		if not ItemCreated:IsValid() then
			Log(string.format('Item could not created (CodeName "%s" is probably wrong)', ItemCodeName))
			return false
		end
		Log(string.format("[LiesofP EkiToolsBox] Item %s Created : %s", ItemCodeName, ItemCreated:GetFullName()))
		local ItemAdded = PlayerInventory:AddItem(ItemCreated)
		if not ItemAdded == true then
			Log("Couldn't add the item to player inventory !")
			return false
		end
		Quantity = Quantity-1
		InventoryItem = ItemCreated
	else
		Log(string.format("[LiesofP EkiToolsBox] Item %s found in Inventory : %s", ItemCodeName, InventoryItem:GetFullName()))
	end
	local ItemCount = InventoryItem:GetPropertyValue("ItemCount")
	InventoryItem:SetPropertyValue("ItemCount", ItemCount+Quantity)
    return true
end

print("[LiesofP EkiToolsBox] giveitem cmd setup\n")