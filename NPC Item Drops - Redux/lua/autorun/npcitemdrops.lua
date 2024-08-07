CreateConVar( "ChanceOfItems", "100", 128, "Chance of item drop 100 = 100%, 10 = 10% etc." )
CreateConVar( "NPCDropItems", "1", 128, "Enable NPCs dropping items 1 = Enabled, 0 = Disabled" )
CreateConVar( "DisableNPCVials", "0", 128, "Remove the 'Drop health vial on death' function from NPCs." )
CreateConVar( "IncompatibilityWarnings", "1", 128, "Enables/Disables the incompatibility warnings." )

local CombatStim = {}
local CombatStimRand = table.Random(CombatStim)

hook.Add("InitPostEntity", "FirstTimeCreation", function()

if !file.Exists("npcitemdrops", "DATA") then
	file.CreateDir("npcitemdrops")
	file.Write("npcitemdrops/npc_combine_s.txt", '["item_healthvial","item_healthkit","item_battery"]')
	file.Write("npcitemdrops/npc_citizen.txt", '["item_healthvial","item_healthkit"]')
	file.Write("npcitemdrops/npc_metropolice.txt", '["item_healthvial","item_healthkit","item_battery"]')
end

if ConVarExists("arc_medshot_replacevial") then
for i=0,18 do
CurItem = "arc_medshot_" .. i

if IsValid(CurItem) then
	table.Insert(CombatStim, CurItem)
end
end
end

if CLIENT then

if GetConVar("IncompatibilityWarnings"):GetInt() != 0 and ConVarExists("sv_armorplates_replacebattery") then
	LocalPlayer():ChatPrint("NPC Item Drops:")
	LocalPlayer():ChatPrint('You have the "Armor Plates" addon installed.')
	LocalPlayer():ChatPrint("If the replacement setting is enabled, any NPC that drops the Armor Battery will now instead drop the Armor Plate entity.")
	LocalPlayer():ChatPrint("This message can be disabled in the settings menu.\n")
end

if GetConVar("IncompatibilityWarnings"):GetInt() != 0 and ConVarExists("arc_medshot_replacevial") then
	LocalPlayer():ChatPrint("NPC Item Drops:")
	LocalPlayer():ChatPrint('You have the "ArcCW Combat Stims" addon installed.')
	LocalPlayer():ChatPrint("If the replacement setting is enabled, any NPC that drops the Health Vial will now drop a random Combat Stim entity instead.")
	LocalPlayer():ChatPrint("This message can be disabled in the settings menu.\n")
end

end

end)


hook.Add( "OnNPCKilled", "NPCItemDropFileTable", function( npc, attacker )

local NPCClass = npc:GetClass()
local File = "npcitemdrops/" .. NPCClass .. ".txt"
local ItemChance = math.Rand( 1, 100 )

if file.Exists( File, "DATA" ) then
	ItemTable = util.JSONToTable(file.Read( File, "DATA" ))
	Random = table.Random(ItemTable)
	Create = ents.Create(Random)

if !IsValid(Create) then
if game.SinglePlayer() then
	Entity(1):ChatPrint("NPC Item Drops:")
	Entity(1):ChatPrint("The NPC " .. npc:GetClass() .. " attempted to drop an invalid entity: " .. Random)
	Entity(1):ChatPrint("Please check the NPC Item Drop list for this NPC and remove the invalid entity.")
	Create = nil
end
if !game.SinglePlayer() and attacker:IsPlayer() then
	attacker:ChatPrint("NPC Item Drops:")
	attacker:ChatPrint("The NPC " .. npc:GetClass() .. " attempted to drop an invalid entity: " .. Random)
	attacker:ChatPrint("Please check the NPC Item Drop list for this NPC and remove the invalid entity.")
	Create = nil
end
if !game.SinglePlayer() and !attacker:IsPlayer() then
for _, ply in ipairs(player.GetAll()) do
	ply:ChatPrint("NPC Item Drops:")
	ply:ChatPrint("The NPC: " .. npc:GetClass() .. " attempted to drop an invalid entity: " .. Random)
	ply:ChatPrint("Please check the NPC Item Drop list for this NPC and remove the invalid entity.")
	Create = nil
end
end
end

if Create != nil then
if npc:HasSpawnFlags(8) and GetConVar( "DisableNPCVials" ):GetInt() == 1 then
npc:SetKeyValue( "spawnflags", bit.bor(npc:GetSpawnFlags() - 8) )
end
end

if Create == "item_battery" and ConVarExists("sv_armorplates_replacebattery") and GetConVar("sv_armorplates_replacebattery"):GetInt() == 1 then
	Create = "armorplate_pickup"
end

if Create == "item_healthvial" and ConVarExists("arc_medshot_replacevial") and GetConVar("arc_medshot_replacevial"):GetInt() == 1 then
	Create = ents.Create(CombatStimRand)
end

if ItemChance < GetConVar("ChanceOfItems"):GetInt() and Create != nil then
Create:SetPos( npc:WorldSpaceCenter() )
Create:Spawn()
Create:SetCollisionGroup( 2 )
end

end

end)