RegisterConsoleCommandHandler("deleteitem", function(FullCommand, Parameters, Ar)
	GlobalAr = Ar
    if #Parameters < 1 then
		Log("Param missing !")
		Log("Usage : deleteitem [Item CodeName] [Quantity]")
		return false
	end
    if #Parameters > 2 then
		Log(string.format("Too many Params ! ??? : %s", Parameters[3]))
		Log("Usage : deleteitem [Item CodeName] [Quantity]")
		return false
	end

	if not DeleteItem(Parameters[1],Parameters[2]) then
		return false
	end

	return true
end)

function DeleteItem(ItemCodeName,Quantity)
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
	local InventoryItem = nil
	InventoryItem = PlayerInventory:FindItemByCodeName(FName(ItemCodeName))
	if not InventoryItem:IsValid() then
		Log(string.format("[LiesofP EkiToolsBox] Item %s NOT found in Inventory !", ItemCodeName))
		return false
	else
		Log(string.format("[LiesofP EkiToolsBox] Item %s found in Inventory : %s", ItemCodeName, InventoryItem:GetFullName()))
	end
	local ItemCount = InventoryItem:GetPropertyValue("ItemCount")
	if (ItemCount-Quantity) > 0 then
		InventoryItem:SetPropertyValue("ItemCount", ItemCount-Quantity)
		Log(string.format("[LiesofP EkiToolsBox] Item %s count is now : %i", ItemCodeName, ItemCount-Quantity))
	else
		InventoryItem:SetPropertyValue("ItemCount", 0)
		PlayerInventory:RemoveItem(InventoryItem)
		Log(string.format("[LiesofP EkiToolsBox] Item %s has been deleted !", ItemCodeName))
	end
    return true
end

print("[LiesofP EkiToolsBox] deleteitem cmd setup\n")