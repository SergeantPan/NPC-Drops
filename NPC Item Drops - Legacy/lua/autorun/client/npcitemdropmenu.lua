hook.Add( "PopulateToolMenu", "NpcItemDropSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "NPC Drops", "ItsTheItemMenu", "NPC Item Drops", "", "", function( panel )
	panel:ClearControls()
	panel:NumSlider( "NPC Item Drop Chance", "ChanceOfItems", 0, 100, 0 )
	panel:Help( "Chance for NPCs to drop an item" )
	panel:CheckBox( "Disable NPC Vial Drops", "DisableNPCVials" )
	panel:Help( "Should the 'Drop Health Vial on death' mechanic be disabled" )
	panel:CheckBox( "NPC Item Drops", "NPCDropItems" )
	panel:Help( "Allow NPC Item drops" )
	panel:CheckBox( "Everything Item Drops", "EnableEverythingDrops" )
	panel:Help( "Allow ANY NPC to drop items" )
	panel:CheckBox( "Allow Vial Drops", "NPCCanDropVial" )
	panel:Help( "Allow NPCs to drop Health Vials" )
	panel:CheckBox( "Allow MedKit Drops", "NPCCanDropKit" )
	panel:Help( "Allow NPCs to drop Medical Kits" )
	panel:CheckBox( "Allow Battery Drops", "NPCCanDropBattery" )
	panel:Help( "Allow NPCs to drop Armor Batteries" )
	panel:AddControl("TextBox", {
	Label = "Health Vial Drop list",
	Command = "VialDropList", })
	panel:Help( "List of NPCs that can drop Health Vials. Separate with spaces" )
	panel:AddControl("TextBox", {
	Label = "Health Kit Drop list",
	Command = "MedKitDropList", })
	panel:Help( "List of NPCs that can drop Medical Kits" )
	panel:AddControl("TextBox", {
	Label = "Battery Drop list",
	Command = "BatteryDropList", })
	panel:Help( "List of NPCs that can drop Armor Batteries" )
end)
end)