hook.Add( "PopulateToolMenu", "NPCItemDropListMenu", function()

	spawnmenu.AddToolMenuOption( "Options", "NPC Drops", "ItemDropList", "NPC Item Drops List", "", "", function( panel )
	panel:ClearControls()

	local SelectedNPC = ""

	local Text1 = vgui.Create("DLabel", frame)
	Text1:SetText("Current NPC: N/A")
	Text1:SetTextColor( Color(0, 0, 0) )

	local Text2 = vgui.Create("DTextEntry", frame)
	Text2:SetPlaceholderText("Entity Class here (e.g. item_battery)")

	local Text3 = vgui.Create("DLabel", frame)
	Text3:SetText("Aim at an NPC and press the above button to select them")
	Text3:SetTextColor( Color(0, 0, 0) )

	local ItemsList = vgui.Create("DListView", frame)
	ItemsList:AddColumn("Item")
	ItemsList:SetTall(500)
	ItemsList:SetMultiSelect(false)
	ItemsList:SetSortable(false)
	function ItemsList:DoDoubleClick( lineID, line )
		File = "npcitemdrops/" .. SelectedNPC .. ".txt"
		Table = util.JSONToTable(file.Read( File, "DATA" ))
		table.remove(Table, lineID)
		file.Write(File, util.TableToJSON(Table))
		ItemsList:RemoveLine(lineID)
		for num,_ in pairs(ItemsList:GetLines()) do
			ItemsList:RemoveLine(num)
		end
		for _,Item in pairs(Table) do
			if Item != "" then
			ItemsList:AddLine(tostring(Item))
			end
		end
		if table.IsEmpty(Table) and file.Exists(File, "DATA") then
			file.Delete(File, "DATA")
		end
	end

	local Text4 = vgui.Create("DTextEntry", frame)
	Text4:SetPlaceholderText("NPC Class here (e.g. npc_combine_s)")
	Text4:SetTextColor( Color(0, 0, 0) )
	function Text4:OnEnter()

	if Text4:GetText() == "" then
		Text1:SetText("Current NPC: N/A")
		SelectedNPC = nil
		for num,_ in ipairs(ItemsList:GetLines()) do
			ItemsList:RemoveLine(num)
		end
	end

	if !list.HasEntry("NPC", Text4:GetText()) and Text4:GetText() != "" then
		Text1:SetText("Current NPC: Invalid NPC")
		SelectedNPC = nil
		for num,_ in ipairs(ItemsList:GetLines()) do
			ItemsList:RemoveLine(num)
		end
	end

	if list.HasEntry("NPC", Text4:GetText()) then

		local File = "npcitemdrops/" .. Text4:GetText() .. ".txt"
		Text1:SetText("Current NPC: " .. Text4:GetText())
		SelectedNPC = Text4:GetText()
		local Table = {}

		for num,_ in ipairs(ItemsList:GetLines()) do
			ItemsList:RemoveLine(num)
		end

		if file.Exists(File, "DATA") then
			Table = util.JSONToTable(file.Read( File, "DATA" ))

			for _,Item in pairs(Table) do
				if Item != "" then
				ItemsList:AddLine(tostring(Item))
				end
			end
		end

	end
	end

	local Button = vgui.Create("DButton", frame)
	Button:SetText("Select NPC")
	Button.DoClick = function()

	if IsValid(EyeTrace) and EyeTrace:IsNPC() then

		local File = "npcitemdrops/" .. EyeTrace:GetClass() .. ".txt"
		Text1:SetText("Current NPC: " .. EyeTrace:GetClass())
		Text4:SetValue(EyeTrace:GetClass())
		SelectedNPC = EyeTrace:GetClass()
		local Table = {}

		for num,_ in ipairs(ItemsList:GetLines()) do
			ItemsList:RemoveLine(num)
		end

		if file.Exists(File, "DATA") then
			Table = util.JSONToTable(file.Read( File, "DATA" ))

			for _,Item in pairs(Table) do
				if Item != "" then
				ItemsList:AddLine(tostring(Item))
				end
			end
		end

	end
	end

	local Button2 = vgui.Create("DButton", frame)
	Button2:SetText("Add item to drop list")
	Button2.DoClick = function()

		if SelectedNPC == nil then return end

		File = "npcitemdrops/" .. SelectedNPC .. ".txt"

		if file.Exists(File, "DATA") then
			Table = util.JSONToTable(file.Read( File, "DATA" ))
		else
			Table = {}
		end

		if Text2:GetText() != "" and (!list.HasEntry("SpawnableEntities", Text2:GetText()) and !list.HasEntry("Weapon", Text2:GetText())) then
			Button2:SetText("Invalid Entity")
			surface.PlaySound("beep_error01.wav")
			timer.Simple(1.5, function() Button2:SetText("Add item to drop list") end)
		end

		if !table.HasValue(Table, Text2:GetText()) and (list.HasEntry("SpawnableEntities", Text2:GetText()) or list.HasEntry("Weapon", Text2:GetText())) then
			table.insert( Table, Text2:GetText() )
			ItemsList:AddLine(Text2:GetText())
			file.Write(File, util.TableToJSON(Table))
		end
	end

	local Text5 = vgui.Create("DLabel", frame)
	Text5:SetText("Double click an item on the list to remove it")
	Text5:SetTextColor( Color(0, 0, 0) )

	panel:AddItem(Text1)
	panel:AddItem(Button)
	panel:AddItem(Text3)
	panel:AddItem(Text4)
	panel:AddItem(Button2)
	panel:AddItem(Text2)
	panel:AddItem(ItemsList)
	panel:AddItem(Text5)

end)
end)