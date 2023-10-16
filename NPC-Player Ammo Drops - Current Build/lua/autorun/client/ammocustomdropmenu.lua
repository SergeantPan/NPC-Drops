hook.Add( "PopulateToolMenu", "CustomAmmoDropSettings", function()

	spawnmenu.AddToolMenuOption( "Options", "NPC Drops", "CustomAmmoMenu", "Ammo Drop Settings", "", "", function( panel )
	panel:ClearControls()
	panel:Help( "Choose the type of ammo that should drop based on the type of ammo the NPC/Player's weapon is using." )
	panel:Help( "E.g: If a weapon uses pistol ammo, then it will drop ammo based on the 'Pistol Ammo Drops' option." )
	panel:Help( "Rince and repeat for each type of ammo." )

if ConVarExists("arccw_ammo_replace") then
	panel:CheckBox( "Use ArcCW Ammo", "UseArcCWAmmo" )
	panel:Help( "Use ArcCW ammo entities instead of HL2 ammo." )
end

	panel:CheckBox( "Disable Pistol Ammo Drops", "DisablePistolDrops" )

	local PistolAmmoBox = panel:ComboBox("Pistol Ammo Drops", "PistolAmmoDrop")
	PistolAmmoBox:SetSortItems(false)
	PistolAmmoBox:AddChoice( "Pistol Ammo", "1" )
	PistolAmmoBox:AddChoice( "Revolver Ammo", "2" )
	PistolAmmoBox:AddChoice( "SMG Ammo", "3" )
	PistolAmmoBox:AddChoice( "AR2 Ammo", "4" )
	PistolAmmoBox:AddChoice( "Shotgun Ammo", "5" )
	PistolAmmoBox:AddChoice( "Crossbow Ammo", "6" )
	PistolAmmoBox:AddChoice( "Rockets", "7" )
	PistolAmmoBox:AddChoice( "Custom Entity", "8" )
	PistolAmmoBox:AddChoice( "Random", "9" )
	panel:AddControl("TextBox", {
	Label = "Custom entity",
	Command = "CustomPistolAmmoDrop", })
	panel:Help( "Only one entity at a time. Use the 'Custom Entity' option for this to function." )

	panel:CheckBox( "Disable Revolver Ammo Drops", "DisableRevolverDrops" )

	local RevolverAmmoBox = panel:ComboBox("Revolver Ammo Drops", "RevolverAmmoDrop")
	RevolverAmmoBox:SetSortItems(false)
	RevolverAmmoBox:AddChoice( "Pistol Ammo", "1" )
	RevolverAmmoBox:AddChoice( "Revolver Ammo", "2" )
	RevolverAmmoBox:AddChoice( "SMG Ammo", "3" )
	RevolverAmmoBox:AddChoice( "AR2 Ammo", "4" )
	RevolverAmmoBox:AddChoice( "Shotgun Ammo", "5" )
	RevolverAmmoBox:AddChoice( "Crossbow Ammo", "6" )
	RevolverAmmoBox:AddChoice( "Rockets", "7" )
	RevolverAmmoBox:AddChoice( "Custom Entity", "8" )
	RevolverAmmoBox:AddChoice( "Random", "9" )
	panel:AddControl("TextBox", {
	Label = "Custom entity",
	Command = "CustomRevolverAmmoDrop", })

	panel:CheckBox( "Disable SMG1 Ammo Drops", "DisableSMGDrops" )

	local SMGAmmoBox = panel:ComboBox("SMG1 Ammo Drops", "SMGAmmoDrop")
	SMGAmmoBox:SetSortItems(false)
	SMGAmmoBox:AddChoice( "Pistol Ammo", "1" )
	SMGAmmoBox:AddChoice( "Revolver Ammo", "2" )
	SMGAmmoBox:AddChoice( "SMG Ammo", "3" )
	SMGAmmoBox:AddChoice( "AR2 Ammo", "4" )
	SMGAmmoBox:AddChoice( "Shotgun Ammo", "5" )
	SMGAmmoBox:AddChoice( "Crossbow Ammo", "6" )
	SMGAmmoBox:AddChoice( "Rockets", "7" )
	SMGAmmoBox:AddChoice( "Custom Entity", "8" )
	SMGAmmoBox:AddChoice( "Random", "9" )
	panel:AddControl("TextBox", {
	Label = "Custom entity",
	Command = "CustomSMGAmmoDrop", })

	panel:CheckBox( "Disable SMG1 Grenade Drops", "DisableSMGGrenadeDrops" )

	local SMGGrenadeAmmoBox = panel:ComboBox("SMG1 Grenade Drops", "SMGGrenadeDrop")
	SMGGrenadeAmmoBox:SetSortItems(false)
	SMGGrenadeAmmoBox:AddChoice( "SMG1 Grenade", "1" )
	SMGGrenadeAmmoBox:AddChoice( "AR2 Orb", "2" )
	SMGGrenadeAmmoBox:AddChoice( "Frag Grenade", "3" )
	SMGGrenadeAmmoBox:AddChoice( "Custom Entity", "4" )
	panel:AddControl("TextBox", {
	Label = "Custom entity",
	Command = "CustomSMGGrenadeDrop", })

	panel:CheckBox( "Disable AR2 Ammo Drops", "DisableArDrops" )

	local AR2AmmoBox = panel:ComboBox("AR2 Ammo Drops", "ArAmmoDrop")
	AR2AmmoBox:SetSortItems(false)
	AR2AmmoBox:AddChoice( "Pistol Ammo", "1" )
	AR2AmmoBox:AddChoice( "Revolver Ammo", "2" )
	AR2AmmoBox:AddChoice( "SMG Ammo", "3" )
	AR2AmmoBox:AddChoice( "AR2 Ammo", "4" )
	AR2AmmoBox:AddChoice( "Shotgun Ammo", "5" )
	AR2AmmoBox:AddChoice( "Crossbow Ammo", "6" )
	AR2AmmoBox:AddChoice( "Rockets", "7" )
	AR2AmmoBox:AddChoice( "Custom Entity", "8" )
	AR2AmmoBox:AddChoice( "Random", "9" )
	panel:AddControl("TextBox", {
	Label = "Custom entity",
	Command = "CustomArAmmoDrop", })

	panel:CheckBox( "Disable AR2 Orb Drops", "DisableArAltDrops" )

	local ArAltAmmoBox = panel:ComboBox("AR2 Orb Drops", "ArAltDrop")
	ArAltAmmoBox:SetSortItems(false)
	ArAltAmmoBox:AddChoice( "SMG1 Grenade", "1" )
	ArAltAmmoBox:AddChoice( "AR2 Orb", "2" )
	ArAltAmmoBox:AddChoice( "Frag Grenade", "3" )
	ArAltAmmoBox:AddChoice( "Custom Entity", "4" )
	panel:AddControl("TextBox", {
	Label = "Custom entity",
	Command = "CustomArAltDrop", })

	panel:CheckBox( "Disable Shotgun Ammo Drops", "DisableShotgunDrops" )

	local ShotgunAmmoBox = panel:ComboBox("Shotgun Ammo Drops", "ShotgunAmmoDrop")
	ShotgunAmmoBox:SetSortItems(false)
	ShotgunAmmoBox:AddChoice( "Pistol Ammo", "1" )
	ShotgunAmmoBox:AddChoice( "Revolver Ammo", "2" )
	ShotgunAmmoBox:AddChoice( "SMG Ammo", "3" )
	ShotgunAmmoBox:AddChoice( "AR2 Ammo", "4" )
	ShotgunAmmoBox:AddChoice( "Shotgun Ammo", "5" )
	ShotgunAmmoBox:AddChoice( "Crossbow Ammo", "6" )
	ShotgunAmmoBox:AddChoice( "Rockets", "7" )
	ShotgunAmmoBox:AddChoice( "Custom Entity", "8" )
	ShotgunAmmoBox:AddChoice( "Random", "9" )
	panel:AddControl("TextBox", {
	Label = "Custom entity",
	Command = "CustomShotgunAmmoDrop", })

	panel:CheckBox( "Disable Crossbow Ammo Drops", "DisableCBowDrops" )

	local CBowAmmoBox = panel:ComboBox("Crossbow Ammo Drops", "CBowAmmoDrop")
	CBowAmmoBox:SetSortItems(false)
	CBowAmmoBox:AddChoice( "Pistol Ammo", "1" )
	CBowAmmoBox:AddChoice( "Revolver Ammo", "2" )
	CBowAmmoBox:AddChoice( "SMG Ammo", "3" )
	CBowAmmoBox:AddChoice( "AR2 Ammo", "4" )
	CBowAmmoBox:AddChoice( "Shotgun Ammo", "5" )
	CBowAmmoBox:AddChoice( "Crossbow Ammo", "6" )
	CBowAmmoBox:AddChoice( "Rockets", "7" )
	CBowAmmoBox:AddChoice( "Custom Entity", "8" )
	CBowAmmoBox:AddChoice( "Random", "9" )
	panel:AddControl("TextBox", {
	Label = "Custom entity",
	Command = "CustomCBowAmmoDrop", })

	panel:CheckBox( "Disable RPG Ammo Drops", "DisableRPGDrops" )

	local RPGAmmoBox = panel:ComboBox("RPG Ammo Drops", "RPGAmmoDrop")
	RPGAmmoBox:SetSortItems(false)
	RPGAmmoBox:AddChoice( "Pistol Ammo", "1" )
	RPGAmmoBox:AddChoice( "Revolver Ammo", "2" )
	RPGAmmoBox:AddChoice( "SMG Ammo", "3" )
	RPGAmmoBox:AddChoice( "AR2 Ammo", "4" )
	RPGAmmoBox:AddChoice( "Shotgun Ammo", "5" )
	RPGAmmoBox:AddChoice( "Crossbow Ammo", "6" )
	RPGAmmoBox:AddChoice( "Rockets", "7" )
	RPGAmmoBox:AddChoice( "Custom Entity", "8" )
	RPGAmmoBox:AddChoice( "Random", "9" )
	panel:AddControl("TextBox", {
	Label = "Custom entity",
	Command = "CustomRPGAmmoDrop", })
end)
end)