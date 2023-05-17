CreateConVar( "ChanceOfItems", "100", 128, "Chance of item drop 100 = 100%, 10 = 10% etc." )
CreateConVar( "NPCDropItems", "1", 128, "Enable NPCs dropping items 1 = Enabled, 0 = Disabled" )
CreateConVar( "NPCCanDropVial", "1", 128, "Enable NPCs dropping health vials 1 = Enabled, 0 = Disabled" )
CreateConVar( "NPCCanDropKit", "1", 128, "Enable NPCs dropping health kits 1 = Enabled, 0 = Disabled" )
CreateConVar( "NPCCanDropBattery", "1", 128, "Enable NPCs dropping armor batteries 1 = Enabled, 0 = Disabled" )
CreateConVar( "DisableNPCVials", "0", 128, "Remove the 'Drop health vial on death' function from NPCs. Allows said NPCs to drop items from this addon instead." )
CreateConVar( "EnableEverythingDrops", "0", 128, "Allow ALL NPCs to drop items, regardless of how much sense it makes." )

// We create the ConVars, because customization over form
// It's not like the user can see any of this anyway

if !ConVarExists("VialDropList") then // Create the drop lists and add defaults.
   CreateConVar("VialDropList", "npc_citizen npc_combine_s npc_metropolice", 128, "List of NPCs that can drop Health Vials")
end
// Granted, I could just set the values as default, but I feel this is better form
if !ConVarExists("MedKitDropList") then
   CreateConVar("MedKitDropList", "npc_citizen npc_combine_s npc_metropolice", 128, "List of NPCs that can drop Health Kits")
end
if !ConVarExists("BatteryDropList") then
   CreateConVar("BatteryDropList", "npc_combine_s npc_metropolice", 128, "List of NPCs that can drop Armor Batteries")
end

hook.Add( "OnNPCKilled", "TheyDiedAgain", function( npc ) // The function that triggers when an NPC is killed

// Holy mother of local variables
// Unfortunately, all very necessary considering what the code does

local vial = {}
local kit = ents.Create("item_healthkit")
local batt = {}
// The basic tables, modified dpeending on certain variables

local VialNPCList = string.Split( GetConVar("VialDropList"):GetString(), " " )
local MedKitNPCList = string.Split( GetConVar("MedKitDropList"):GetString(), " " )
local BatteryNPCList = string.Split( GetConVar("BatteryDropList"):GetString(), " " )
// Convert the console variables into a format that the code can read as a table

local NPCClass = npc:GetClass()
local ItemChance = math.Rand( 1, 100 ) // Create this stuff
local EverythingCanDrop = GetConVar("EnableEverythingDrops"):GetInt() == 1
// Formality functions, to make certain functions easier to copy/paste

local NumbersTable = { 1, 2, 3 }
// Totally necessary, believe me

local CombatStimEverything = {"arc_medshot_0", "arc_medshot_1", "arc_medshot_2", "arc_medshot_3", "arc_medshot_4", "arc_medshot_5", "arc_medshot_6", "arc_medshot_7", "arc_medshot_8", "arc_medshot_9", "arc_medshot_10", "arc_medshot_11", "arc_medshot_12", "arc_medshot_13", "arc_medshot_14", "arc_medshot_15", "arc_medshot_16", "arc_medshot_17", "arc_medshot_18"}
local CombatStimRand = table.Random(CombatStimEverything)

local CombatStimLimited = {"arc_medshot_0", "arc_medshot_1", "arc_medshot_2", "arc_medshot_3", "arc_medshot_4", "arc_medshot_6", "arc_medshot_7", "arc_medshot_17"}
local CombatStimLimitedRand = table.Random(CombatStimLimited)
// Necessary for the "Combat Stims" addon, because otherwise stuff breaks

if ConVarExists("sv_armorplates_replacebattery") and GetConVar("sv_armorplates_replacebattery"):GetInt() == 1 then
batt = ents.Create("armorplate_pickup")
else
batt = ents.Create("item_battery")
end
// "Armor Plates" addon, because broken tables are not fun

if ConVarExists("arc_medshot_replacevial") and GetConVar("arc_medshot_replacevial"):GetInt() == 1 then
if IsValid("arc_medshot_18") then
vial = ents.Create(CombatStimRand)
else
vial = ents.Create(CombatStimLimitedRand)
end
end

if (!ConVarExists("arc_medshot_replacevial") or GetConVar("arc_medshot_replacevial"):GetInt() == 0) then
vial = ents.Create("item_healthvial")	
end
// Rince and repeat for "Combat Stims"

if GetConVar( "NPCCanDropVial" ):GetInt() == 0 then
table.RemoveByValue( NumbersTable, 1 )
end
if GetConVar( "NPCCanDropKit" ):GetInt() == 0 then
table.RemoveByValue( NumbersTable, 2 )
end
if GetConVar( "NPCCanDropBattery" ):GetInt() == 0 then
table.RemoveByValue( NumbersTable, 3 )
end
// A rather poor implementation of a "Force an item to drop" function
// I really should improve this stuff

if !table.HasValue(VialNPCList, NPCClass) and !EverythingCanDrop then
table.RemoveByValue( NumbersTable, 1 )
end
if !table.HasValue(MedKitNPCList, NPCClass) and !EverythingCanDrop then
table.RemoveByValue( NumbersTable, 2 )
end
if !table.HasValue(BatteryNPCList, NPCClass) and !EverythingCanDrop then
table.RemoveByValue( NumbersTable, 3 )
end

local RandomNumber = table.Random( NumbersTable )

if GetConVar( "NPCDropItems" ):GetInt() == 0 then return end // Do we allow drops?

if ItemChance > GetConVar( "ChanceOfItems" ):GetInt() then return end // Chance variable

if npc:HasSpawnFlags(8) and GetConVar( "DisableNPCVials" ):GetInt() == 1 then
npc:SetKeyValue( "spawnflags", bit.bor(npc:GetSpawnFlags() - 8) )
end
// Edit NPC spawnflags to remove the "Drop health vial on death" mechanic

if RandomNumber == 1 and (table.HasValue(VialNPCList, NPCClass) or (EverythingCanDrop and npc:IsNPC())) and not npc:HasSpawnFlags(8) then
vial:SetPos( npc:WorldSpaceCenter() )
vial:Spawn()
vial:SetCollisionGroup( 2 )
elseif RandomNumber == 2 and (table.HasValue(MedKitNPCList, NPCClass) or (EverythingCanDrop and npc:IsNPC())) and not npc:HasSpawnFlags(8) then
kit:SetPos( npc:WorldSpaceCenter() )
kit:Spawn()
kit:SetCollisionGroup( 2 )
elseif RandomNumber == 3 and (table.HasValue(BatteryNPCList, NPCClass) or (EverythingCanDrop and npc:IsNPC())) and not npc:HasSpawnFlags(8) then
batt:SetPos( npc:WorldSpaceCenter() )
batt:Spawn()
batt:SetCollisionGroup( 2 )
end
// Then we create the stuff
end)