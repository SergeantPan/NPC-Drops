CreateConVar( "ChanceOfAmmo", "100", 128, "Chance of ammo drop 100 = 100%, 10 = 10% etc." )
CreateConVar( "NPCDropAmmo", "1", 128, "Enable NPCs dropping ammo 1 = Enabled, 0 = Disabled" )
CreateConVar( "NPCDropAltAmmo", "1", 128, "Enable NPCs with weapons that have secondary ammo (SMG1 Grenades/AR2 orbs) to drop secondary ammo 1 = Enabled, 0 = Disabled" )
CreateConVar( "PlayerDropAmmo", "1", 128, "Enable Players dropping ammo 1 = Enabled, 0 = Disabled" )
CreateConVar( "PlayerDropAltAmmo", "1", 128, "Enable players with weapons that have secondary ammo (SMG1 Grenades/AR2 orbs) to drop secondary ammo 1 = Enabled, 0 = Disabled" )
CreateConVar( "DisableNPCWeaponDrop", "0", 128, "Prevent NPC's from dropping weapons 1 = Enabled, 0 = Disabled" )

if ConVarExists("arccw_ammo_replace") then
CreateConVar( "UseArcCWAmmo", "0", 128, "Use ArcCW Ammo entities in place of default HL2 ones." )
end

CreateConVar( "PistolAmmoDrop", "1", 128, "NPC's/Players with weapons that use pistol ammo will drop this type of ammo." )
CreateConVar( "CustomPistolAmmoDrop", "", 128, "Custom Pistol ammo drop." )
CreateConVar( "DisablePistolDrops", "0", 128, "Disable Pistol ammo drops entirely. 0 = No, 1 = Yes" )

CreateConVar( "RevolverAmmoDrop", "2", 128, "NPC's/Players with weapons that use revolver ammo will drop this type of ammo" )
CreateConVar( "CustomRevolverAmmoDrop", "", 128, "Custom Revolver ammo drop." )
CreateConVar( "DisableRevolverDrops", "0", 128, "Disable Revolver ammo drops entirely. 0 = No, 1 = Yes" )

CreateConVar( "SMGAmmoDrop", "3", 128, "NPC's/Players with weapons that use SMG ammo will drop this type of ammo" )
CreateConVar( "CustomSMGAmmoDrop", "", 128, "Custom SMG ammo drop." )
CreateConVar( "DisableSMGDrops", "0", 128, "Disable SMG ammo drops entirely. 0 = No, 1 = Yes" )

CreateConVar( "SMGGrenadeDrop", "1", 128, "NPC's/Players with weapons that have underbarrel SMG1 grenades will drop this type of ammo" )
CreateConVar( "CustomSMGGrenadeDrop", "", 128, "Custom SMG Grenade ammo drop." )
CreateConVar( "DisableSMGGrenadeDrops", "0", 128, "Disable SMG Grenade drops entirely. 0 = No, 1 = Yes" )

CreateConVar( "ArAmmoDrop", "2", 128, "NPC's/Players with weapons that use AR2 ammo will drop this type of ammo" )
CreateConVar( "CustomArAmmoDrop", "", 128, "Custom AR ammo drop." )
CreateConVar( "DisableArDrops", "0", 128, "Disable AR2 ammo drops entirely. 0 = No, 1 = Yes" )

CreateConVar( "ArAltDrop", "2", 128, "NPC's/Players with weapons that have AR2 Alt Fire will drop this type of ammo" )
CreateConVar( "CustomArAltDrop", "", 128, "Custom AR2 Orb ammo drop." )
CreateConVar( "DisableArAltDrops", "0", 128, "Disable AR2 Orb drops entirely. 0 = No, 1 = Yes" )
CreateConVar( "RestoreArAltDropBehavior", "0", 128, "Only Combine units equipped with the AR2 will drop AR2 Orbs" )

CreateConVar( "ShotgunAmmoDrop", "5", 128, "NPC's/Players with weapons that use shotgun ammo will drop this type of ammo" )
CreateConVar( "CustomShotgunAmmoDrop", "", 128, "Custom Shotgun ammo drop." )
CreateConVar( "DisableShotgunDrops", "0", 128, "Disable Shotgun ammo drops entirely. 0 = No, 1 = Yes" )

CreateConVar( "CBowAmmoDrop", "6", 128, "NPC's/Players with weapons that use crossbow bolts will drop this type of ammo" )
CreateConVar( "CustomCBowAmmoDrop", "", 128, "Custom Crossbow ammo drop." )
CreateConVar( "DisableCBowDrops", "0", 128, "Disable Crossbow ammo drops entirely. 0 = No, 1 = Yes" )

CreateConVar( "RPGAmmoDrop", "7", 128, "NPC's/Players with weapons that use RPG rockets will drop this type of ammo" )
CreateConVar( "CustomRPGAmmoDrop", "", 128, "Custom RPG ammo drop." )
CreateConVar( "DisableRPGDrops", "0", 128, "Disable RPG ammo drops entirely. 0 = No, 1 = Yes" )

// Console variables created for the sake of customization

// Basic function to prevent Combine Soldiers from dropping AR2 Energy Ball ammo on death

function AR2BallRemover()
for k, combine in pairs( ents.FindByClass( "npc_combine_s" ) ) do
if !combine:HasSpawnFlags(262144) then
	combine:SetKeyValue( "spawnflags", bit.bor(combine:GetSpawnFlags() + 262144) )
end
end
end
hook.Add( "Think", "AddTheSpawnflag", AR2BallRemover )

hook.Add( "OnNPCKilled", "TheyDied", function( npc, attacker )
// This function triggers every time an NPC dies

// Variables necessary for spawning the right type of ammo

local Prefix = {}
local PrefixShotgun = {}
local CBowSuffix = {}

// Basic function to disable NPC weapon drops

if GetConVar( "DisableNPCWeaponDrop" ):GetInt() == 1 and !npc:HasSpawnFlags(8192) then
npc:SetKeyValue( "spawnflags", bit.bor(npc:GetSpawnFlags() + 8192) )
end

// ArcCW ammo compatibility

if ConVarExists("arccw_ammo_replace") and (GetConVar("arccw_ammo_replace"):GetBool() or GetConVar("UseArcCWAmmo"):GetBool()) then
Prefix = "arccw"
PrefixShotgun = "arccw_ammo_"
CBowSuffix = "sniper"
else
Prefix = "item"
PrefixShotgun = "item_box_"
CBowSuffix = "crossbow"
end

if npc:IsNextBot() then return end // NextBots have dodgy GetActiveWeapon behaviour, so we ignore them completely.

if npc:GetActiveWeapon():IsWeapon() == false then return end // Does the NPC even have a weapon? DO NOT DELETE! Otherwise antlions and such will cause errors.

// Blank variable for getting the weapon type

local NPCWeapon = {}

// Get the weapon type based on the ammo used

if npc:GetActiveWeapon():GetPrimaryAmmoType() == 3 then
NPCWeapon = "Pistol"
elseif npc:GetActiveWeapon():GetPrimaryAmmoType() == 5 then
NPCWeapon = "Revolver"
elseif npc:GetActiveWeapon():GetPrimaryAmmoType() == 4 then
NPCWeapon = "SMG"
elseif npc:GetActiveWeapon():GetPrimaryAmmoType() == 1 then
NPCWeapon = "Ar"
elseif npc:GetActiveWeapon():GetPrimaryAmmoType() == 7 then
NPCWeapon = "Shotgun"
elseif (npc:GetActiveWeapon():GetPrimaryAmmoType() == 6 or npc:GetActiveWeapon():GetPrimaryAmmoType() == 14) then
NPCWeapon = "CBow"
elseif npc:GetActiveWeapon():GetPrimaryAmmoType() == 8 then
NPCWeapon = "RPG"
else
NPCWeapon = ""
end

// Variables for creating the ammo type we want to spawn

local Pistol = ents.Create(Prefix .. "_ammo_pistol")
local Revolver = ents.Create(Prefix .. "_ammo_357")
local SMG = ents.Create(Prefix .. "_ammo_smg1")
local SMGGrenade = {}
local Ar = ents.Create(Prefix .. "_ammo_ar2")
local Ar2Alt = {}
local Shotgun = ents.Create(PrefixShotgun .. "buckshot")
local CBow = ents.Create(Prefix .. "_ammo_" .. CBowSuffix)
local RPG = ents.Create("item_rpg_round")

// Make sure the weapon is actually a thing

if NPCWeapon != "" then
Custom = GetConVar("Custom" .. NPCWeapon .. "AmmoDrop"):GetString()
AmmoChoice = GetConVar(NPCWeapon .. "AmmoDrop"):GetInt()
end

// Simplified functionality

local EverythingAmmo = {}
local AmmoTable = {Pistol, Revolver, SMG, Ar, Shotgun, CBow, RPG}
local RandomAmmo = AmmoTable[math.random(1, #AmmoTable)]

// AmmoChoice is the type of ammo the player wants the game to spawn
// EverythingAmmo is the entity that will then be created by the game

if AmmoChoice == 1 then
EverythingAmmo = Pistol
elseif AmmoChoice == 2 then
EverythingAmmo = Revolver
elseif AmmoChoice == 3 then
EverythingAmmo = SMG
elseif AmmoChoice == 4 then
EverythingAmmo = Ar
elseif AmmoChoice == 5 then
EverythingAmmo = Shotgun
elseif AmmoChoice == 6 then
EverythingAmmo = CBow
elseif AmmoChoice == 7 then
EverythingAmmo = RPG
elseif AmmoChoice == 8 then
EverythingAmmo = ents.Create(Custom)
elseif AmmoChoice == 9 then
EverythingAmmo = RandomAmmo
else return
end

// Player has chosen 'Custom Entity' as the item they want to drop
// But they either have left the option blank, or have chosen an invalid (non-existent) entity

if AmmoChoice == 8 and attacker:IsPlayer() and Custom == "" or nil then
attacker:ChatPrint("You have chosen custom entity as your drop item, but have not actually selected an entity")
attacker:ChatPrint("Use the 'Custom Entity' textbox to choose a valid entity.")
EverythingAmmo = {}
elseif AmmoChoice == 8 and attacker:IsPlayer() and !IsValid(EverythingAmmo) then
attacker:ChatPrint("The entity " ..  Custom .. " is not a valid entity.")
attacker:ChatPrint("Either the entity does not exist, or you've made a typo.")
EverythingAmmo = {}
end

// Create entities for underbarrel grenades

if GetConVar("SMGGrenadeDrop"):GetInt() == 1 then // Check which option the player has chosen
SMGGrenade = ents.Create(Prefix .. "_ammo_smg1_grenade") // Then change the entity based on the choice
elseif GetConVar("SMGGrenadeDrop"):GetInt() == 2 then
SMGGrenade = ents.Create("item_ammo_ar2_altfire")
elseif GetConVar("SMGGrenadeDrop"):GetInt() == 3 then
SMGGrenade = ents.Create("weapon_frag")
elseif GetConVar("SMGGrenadeDrop"):GetInt() == 4 and IsValid(GetConVar("CustomSMGGrenadeDrop"):GetString()) then
SMGGrenade = ents.Create(GetConVar("CustomSMGGrenadeDrop"):GetString())
end

// Same as above, but for AR2 energy balls

if GetConVar("ArAltDrop"):GetInt() == 1 then // Rince and repeat, but for a different entity
Ar2Alt = ents.Create(Prefix .. "_ammo_smg1_grenade")
elseif GetConVar("ArAltDrop"):GetInt() == 2 then
Ar2Alt = ents.Create("item_ammo_ar2_altfire")
elseif GetConVar("ArAltDrop"):GetInt() == 3 then
Ar2Alt = ents.Create("weapon_frag")
elseif GetConVar("ArAltDrop"):GetInt() == 4 and IsValid(GetConVar("CustomArAltDrop"):GetString()) then
Ar2Alt = ents.Create(GetConVar("CustomArAltDrop"):GetString())
end

// Player has chosen 'Custom Entity' but field is blank/entity does not exist

if GetConVar("SMGGrenadeDrop"):GetInt() == 4 and attacker:IsPlayer() and GetConVar("CustomSMGGrenadeDrop"):GetString() == "" or nil then // Player has chosen custom entity
attacker:ChatPrint("You have chosen custom entity as your drop item, but have not actually selected an entity") // But the text field is blank or nil
attacker:ChatPrint("Use the 'Custom Entity' textbox to choose a valid entity.")
SMGGrenade = {} // Blank the entity, because otherwise spawning it will create errors
elseif GetConVar("SMGGrenadeDrop"):GetInt() == 4 and attacker:IsPlayer() and !IsValid(GetConVar("CustomSMGGrenadeDrop"):GetString()) then // Same as above, but the entity in the field does not exist
attacker:ChatPrint("The entity " ..  GetConVar("CustomSMGGrenadeDrop"):GetString() .. " is not a valid entity.")
attacker:ChatPrint("Either the entity does not exist, or you've made a typo.")
SMGGrenade = {}
end

// Same as above, but for AR2 Energy Balls

if GetConVar("ArAltDrop"):GetInt() == 4 and attacker:IsPlayer() and GetConVar("CustomArAltDrop"):GetString() == "" or nil then
attacker:ChatPrint("You have chosen custom entity as your drop item, but have not actually selected an entity")
attacker:ChatPrint("Use the 'Custom Entity' textbox to choose a valid entity.")
Ar2Alt = {}
elseif GetConVar("ArAltDrop"):GetInt() == 4 and attacker:IsPlayer() and !IsValid(GetConVar("CustomArAltDrop"):GetString()) then
attacker:ChatPrint("The entity " ..  GetConVar("CustomArAltDrop"):GetString() .. " is not a valid entity.")
attacker:ChatPrint("Either the entity does not exist, or you've made a typo.")
Ar2Alt = {}
end

local AmmoChance = math.Rand( 1, 100 ) // Create this stuff

if AmmoChance > GetConVar("ChanceOfAmmo"):GetInt() then return end // Do we get lucky and get ammo?

if GetConVar("NPCDropAltAmmo"):GetBool() then // Can NPC's drop alt-fire ammo (Underbarrel grenades, AR2 energy balls)
if npc:GetActiveWeapon():GetSecondaryAmmoType() == 9 and !GetConVar("DisableSMGGrenadeDrops"):GetBool() and IsValid(SMGGrenade) then // If yes, then: if secondary ammo is SMG grenades, drops are allowed and the entity is valid then
SMGGrenade:SetPos( npc:WorldSpaceCenter() ) // Set position as the NPC's center mass
SMGGrenade:Spawn() // Spawn the entity
SMGGrenade:SetCollisionGroup(2) // Alter collision to prevent dodgy physics
end

if npc:GetActiveWeapon():GetSecondaryAmmoType() == 2 and !GetConVar("DisableArAltDrops"):GetBool() and IsValid(Ar2Alt) then // Same as above, but for the AR2 Energy Balls
if (GetConVar("RestoreArAltDropBehavior"):GetInt() == 1 and npc:GetClass() == "npc_combine_s") or GetConVar("RestoreArAltDropBehavior"):GetInt() == 0 then // Rince and repeat
Ar2Alt:SetPos( npc:WorldSpaceCenter() )
Ar2Alt:Spawn()
Ar2Alt:SetCollisionGroup(2)
end
end
end

if GetConVar( "NPCDropAmmo" ):GetBool() then // Same as above, but for primary ammo instead
if NPCWeapon != "" then // Make sure the weapon we are checking supports the ammo type
if !GetConVar("Disable" .. NPCWeapon .. "Drops"):GetBool() and IsValid(EverythingAmmo) then // Check if the Console Variable is enabled, and the ammo entity exists
EverythingAmmo:SetPos( npc:WorldSpaceCenter() ) // Center mass
EverythingAmmo:Spawn() // Spawn
EverythingAmmo:SetCollisionGroup(2) // Alter collision
end
end
end
end)

function DoPlayerDeath(ply, attacker) // Now we do it for players
// Past this point, the code remains much the same
// The only exception here is that the function triggers for players, instead of NPC's
// As such, the repetition is necessary, as we can't react to player deaths in the code above

local Prefix = {}
local PrefixShotgun = {}
local CBowSuffix = {}

if ConVarExists("arccw_ammo_replace") and (GetConVar("arccw_ammo_replace"):GetBool() or GetConVar("UseArcCWAmmo"):GetBool()) then
Prefix = "arccw"
PrefixShotgun = "arccw_ammo_"
CBowSuffix = "sniper"
else
Prefix = "item"
PrefixShotgun = "item_box_"
CBowSuffix = "crossbow"
end

if ply:GetActiveWeapon():IsWeapon() == false then return end

local plyWeapon = {}

if ply:GetActiveWeapon():GetPrimaryAmmoType() == 3 then
plyWeapon = "Pistol"
elseif ply:GetActiveWeapon():GetPrimaryAmmoType() == 5 then
plyWeapon = "Revolver"
elseif ply:GetActiveWeapon():GetPrimaryAmmoType() == 4 then
plyWeapon = "SMG"
elseif ply:GetActiveWeapon():GetPrimaryAmmoType() == 1 then
plyWeapon = "Ar"
elseif ply:GetActiveWeapon():GetPrimaryAmmoType() == 7 then
plyWeapon = "Shotgun"
elseif (ply:GetActiveWeapon():GetPrimaryAmmoType() == 6 or ply:GetActiveWeapon():GetPrimaryAmmoType() == 14) then
plyWeapon = "CBow"
elseif ply:GetActiveWeapon():GetPrimaryAmmoType() == 8 then
plyWeapon = "RPG"
else
plyWeapon = ""
end

local Pistol = ents.Create(Prefix .. "_ammo_pistol")
local Revolver = ents.Create(Prefix .. "_ammo_357")
local SMG = ents.Create(Prefix .. "_ammo_smg1")
local SMGGrenade = {}
local Frag = ents.Create("weapon_frag")
local Ar = ents.Create(Prefix .. "_ammo_ar2")
local Ar2Alt = {}
local Shotgun = ents.Create(PrefixShotgun .. "buckshot")
local CBow = ents.Create(Prefix .. "_ammo_" .. CBowSuffix)
local RPG = ents.Create("item_rpg_round")

if plyWeapon != "" then
Custom = GetConVar("Custom" .. plyWeapon .. "AmmoDrop"):GetString()
AmmoChoice = GetConVar(plyWeapon .. "AmmoDrop"):GetInt()
end

local EverythingAmmo = {}
local AmmoTable = {Pistol, Revolver, SMG, Ar, Shotgun, CBow, RPG}
local RandomAmmo = AmmoTable[math.random(1, #AmmoTable)]

if AmmoChoice == 1 then
EverythingAmmo = Pistol
elseif AmmoChoice == 2 then
EverythingAmmo = Revolver
elseif AmmoChoice == 3 then
EverythingAmmo = SMG
elseif AmmoChoice == 4 then
EverythingAmmo = Ar
elseif AmmoChoice == 5 then
EverythingAmmo = Shotgun
elseif AmmoChoice == 6 then
EverythingAmmo = CBow
elseif AmmoChoice == 7 then
EverythingAmmo = RPG
elseif AmmoChoice == 8 then
EverythingAmmo = ents.Create(Custom)
elseif AmmoChoice == 9 then
EverythingAmmo = RandomAmmo
else return
end

if AmmoChoice == 8 and attacker:IsPlayer() and Custom == "" or nil then
attacker:ChatPrint("You have chosen custom entity as your drop item, but have not actually selected an entity")
attacker:ChatPrint("Use the 'Custom Entity' textbox to choose a valid entity.")
EverythingAmmo = {}
elseif AmmoChoice == 8 and attacker:IsPlayer() and !IsValid(EverythingAmmo) then
attacker:ChatPrint("The entity " ..  Custom .. " is not a valid entity.")
attacker:ChatPrint("Either the entity does not exist, or you've made a typo.")
EverythingAmmo = {}
end

if GetConVar("SMGGrenadeDrop"):GetInt() == 1 then
SMGGrenade = ents.Create(Prefix .. "_ammo_smg1_grenade")
elseif GetConVar("SMGGrenadeDrop"):GetInt() == 2 then
SMGGrenade = ents.Create("item_ammo_ar2_altfire")
elseif GetConVar("SMGGrenadeDrop"):GetInt() == 3 then
SMGGrenade = ents.Create("weapon_frag")
elseif GetConVar("SMGGrenadeDrop"):GetInt() == 4 and IsValid(GetConVar("CustomSMGGrenadeDrop"):GetString()) then
SMGGrenade = ents.Create(GetConVar("CustomSMGGrenadeDrop"):GetString())
end

if GetConVar("ArAltDrop"):GetInt() == 1 then
Ar2Alt = ents.Create(Prefix .. "_ammo_smg1_grenade")
elseif GetConVar("ArAltDrop"):GetInt() == 2 then
Ar2Alt = ents.Create("item_ammo_ar2_altfire")
elseif GetConVar("ArAltDrop"):GetInt() == 3 then
Ar2Alt = ents.Create("weapon_frag")
elseif GetConVar("ArAltDrop"):GetInt() == 4 and IsValid(GetConVar("CustomArAltDrop"):GetString()) then
Ar2Alt = ents.Create(GetConVar("CustomArAltDrop"):GetString())
end

if GetConVar("SMGGrenadeDrop"):GetInt() == 3 and attacker:IsPlayer() and GetConVar("CustomSMGGrenadeDrop"):GetString() == "" or nil then
attacker:ChatPrint("You have chosen custom entity as your drop item, but have not actually selected an entity")
attacker:ChatPrint("Use the 'Custom Entity' textbox to choose a valid entity.")
SMGGrenade = {}
elseif GetConVar("SMGGrenadeDrop"):GetInt() == 3 and attacker:IsPlayer() and !IsValid(GetConVar("CustomSMGGrenadeDrop"):GetString()) then
attacker:ChatPrint("The entity " ..  GetConVar("CustomSMGGrenadeDrop"):GetString() .. " is not a valid entity.")
attacker:ChatPrint("Either the entity does not exist, or you've made a typo.")
SMGGrenade = {}
end

if GetConVar("ArAltDrop"):GetInt() == 4 and attacker:IsPlayer() and GetConVar("CustomArAltDrop"):GetString() == "" or nil then
attacker:ChatPrint("You have chosen custom entity as your drop item, but have not actually selected an entity")
attacker:ChatPrint("Use the 'Custom Entity' textbox to choose a valid entity.")
Ar2Alt = {}
elseif GetConVar("ArAltDrop"):GetInt() == 4 and attacker:IsPlayer() and !IsValid(GetConVar("CustomArAltDrop"):GetString()) then
attacker:ChatPrint("The entity " ..  GetConVar("CustomArAltDrop"):GetString() .. " is not a valid entity.")
attacker:ChatPrint("Either the entity does not exist, or you've made a typo.")
Ar2Alt = {}
end

local AmmoChance = math.Rand(1, 100)

if AmmoChance > GetConVar( "ChanceOfAmmo" ):GetInt() then return end

if GetConVar("PlayerDropAltAmmo"):GetBool() then
if ply:GetActiveWeapon():GetSecondaryAmmoType() == 9 and !GetConVar("DisableSMGGrenadeDrops"):GetBool() and IsValid(SMGGrenade) then
SMGGrenade:SetPos( ply:WorldSpaceCenter() )
SMGGrenade:Spawn()
SMGGrenade:SetCollisionGroup(2)
end

if ply:GetActiveWeapon():GetSecondaryAmmoType() == 2 and !GetConVar("DisableArAltDrops"):GetBool() and IsValid(Ar2Alt) then
Ar2Alt:SetPos( ply:WorldSpaceCenter() )
Ar2Alt:Spawn()
Ar2Alt:SetCollisionGroup(2)
end
end

if GetConVar("PlayerDropAmmo"):GetBool() then

if plyWeapon != "" then
if !GetConVar("Disable" .. plyWeapon .. "Drops"):GetBool() and IsValid(EverythingAmmo) then
EverythingAmmo:SetPos( ply:WorldSpaceCenter() )
EverythingAmmo:Spawn()
EverythingAmmo:SetCollisionGroup(2)
end
end
end
end

hook.Add("DoPlayerDeath", "YouHaveDied", DoPlayerDeath )