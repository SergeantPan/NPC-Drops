hook.Add( "AddToolMenuCategories", "NpcDropCategory", function()
	spawnmenu.AddToolCategory( "Options", "NPC Drops", "#NPC Drops" )
end )

hook.Add( "PopulateToolMenu", "NpcAmmoDropSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "NPC Drops", "ItsTheAmmoMenu", "NPC/Player Ammo Drops", "", "", function( panel )
	panel:ClearControls()
	panel:NumSlider( "Ammo Drop Chance", "ChanceOfAmmo", 0, 100, 0 )
	panel:Help( "Chance for NPCs to drop ammo" )
	panel:CheckBox( "NPC Ammo Drops", "NPCDropAmmo" )
	panel:Help( "Allow NPC ammo drops" )
	panel:CheckBox( "NPC Secondary Ammo Drops", "NPCDropAltAmmo" )
	panel:Help( "Allow NPCs to drop Secondary Ammo" )

	local AR2Orb = panel:ComboBox("AR2 Orb Drop", "RestoreArAltDropBehavior")
	AR2Orb:SetSortItems(false)
	AR2Orb:AddChoice( "All", "0" )
	AR2Orb:AddChoice( "Combine Only", "1" )
	AR2Orb:AddChoice( "Combine Elite Only", "2" )
	panel:Help( "Determine which NPCs can drop AR2 Orb ammo when using the AR2.")

	local NPCWepDrop = panel:ComboBox("NPC Weapon Drops", "DisableNPCWeaponDrop")
	NPCWepDrop:SetSortItems(false)
	NPCWepDrop:AddChoice( "Enabled", "0" )
	NPCWepDrop:AddChoice( "Disabled", "1" )
	NPCWepDrop:AddChoice( "Chance based", "2" )
	panel:Help( "Determine if NPCs should drop their weapon on death" )
	panel:NumSlider( "Weapon Drop Chance", "NPCWeaponDropChance", 0, 100, 0 )
	panel:Help( 'Chance for NPC to drop their weapon on death. Requires "NPC Weapon Drops" to be set to Chance Based' )
	panel:CheckBox( "Player Ammo Drops", "PlayerDropAmmo" )
	panel:Help( "Allow Player ammo drops" )
	panel:CheckBox( "Player Secondary Ammo Drops", "PlayerDropAltAmmo" )
	panel:Help( "Allow Players to drop Secondary Ammo" )
end)
end)