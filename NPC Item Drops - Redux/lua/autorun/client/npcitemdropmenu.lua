hook.Add( "PopulateToolMenu", "NPCItemDropSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "NPC Drops", "ItemDropSettings", "NPC Item Drops Settings", "", "", function( panel )
	panel:ClearControls()
	panel:NumSlider( "NPC Item Drop Chance", "ChanceOfItems", 0, 100, 0 )
	panel:Help( "Chance for NPCs to drop an item" )

	panel:CheckBox( "Disable NPC Vial Drops", "DisableNPCVials" )
	panel:Help( "Should the 'Drop Health Vial on death' mechanic be disabled" )

	panel:CheckBox( "External Addon Warnings", "IncompatibilityWarnings" )
	panel:Help( "Enable/Disable the warnings for external addons that interact with this addon" )

end)
end)