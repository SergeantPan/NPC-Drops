CreateConVar( "ChanceOfAmmo", "100", 128, "Chance of ammo drop 100 = 100%, 10 = 10% etc." )
CreateConVar( "NPCDropAmmo", "1", 128, "Enable NPCs dropping ammo 1 = Enabled, 0 = Disabled" )
CreateConVar( "NPCDropAltAmmo", "1", 128, "Enable NPCs with weapons that have secondary ammo (SMG1 Grenades/AR2 orbs) to drop secondary ammo 1 = Enabled, 0 = Disabled" )
CreateConVar( "DisableNPCWeaponDrop", "0", 128, "Prevent NPC's from dropping weapons 1 = Enabled, 0 = Disabled" )

// These are basic convars for functionality purposes
// Delete these if you so see fit

hook.Add( "OnNPCKilled", "NPCAmmoDropCustom", function( npc, attacker )

if npc:IsNextBot() then return end

// NextBots have dodgy GetActiveWeapon behaviour, so we ignore them completely.

if npc:GetActiveWeapon():IsWeapon() == false then return end

// Does the NPC even have a weapon? DO NOT DELETE! Otherwise antlions and such will cause errors.

local Pistol = ents.Create("item_ammo_pistol")
local Revolver = ents.Create("item_ammo_357")
local SMG = ents.Create("item_ammo_smg1")
local SMGGrenade = ents.Create("item_ammo_smg1_grenade")
local Ar = ents.Create("item_ammo_ar2")
local Shotgun = ents.Create("item_box_buckshot")
local CBow = ents.Create("item_ammo_crossbow")
local RPG = ents.Create("item_rpg_round")
//local Custom = ents.Create("Custom Ammo Entity goes here")

// These are default ammo entities
// Edit these as you wish

local AmmoChance = math.Rand( 1, 100 )

// This is the chance for drop
// It's a value between 1 and 100
// Basically a percentage value, picked at random

if AmmoChance > GetConVar("ChanceOfAmmo"):GetInt() then return end

// This is where the randomization happens
// If the random value picked by AmmoChance is higher than the player-defined ChanceOfAmmo then
// No item will drop
// Feel free to delete this if you wish to not use the RNG feature

if npc:GetActiveWeapon():GetSecondaryAmmoType() == 9 and GetConVar("NPCDropAltAmmo"):GetBool() then
// GetSecondaryAmmoType() == 9 means SMG1 grenades. Also, if you've deleted the NPCDropAltAmmo ConVar
// Then remove " and GetConVar("NPCDropAltAmmo"):GetBool()"
SMGGrenade:SetPos( npc:WorldSpaceCenter() ) // Make the grenade spawn at the NPC's center mass
SMGGrenade:Spawn() // Spawn it in
SMGGrenade:SetCollisionGroup(2) // Make it nocollide with the ragdoll
end

if GetConVar("NPCDropAmmo"):GetBool() then
// If NPCDropAmmo == 1 then ammo drops can happen
// If you've deleted the ConVar, delete this line aswell

if npc:GetActiveWeapon():GetPrimaryAmmoType() == 3 then

// GetPrimaryAmmoType() determines the type of ammo the weapon uses
// In this case, 3 = Pistol ammo
// Use this link to see all default ammo types and their number values;
// https://wiki.facepunch.com/gmod/Default_Ammo_Types

Pistol:SetPos( npc:WorldSpaceCenter() ) // Make the ammo spawn at the NPC's center mass
Pistol:Spawn() // Spawn it in
Pistol:SetCollisionGroup(2) // Make it nocollide with the ragdoll
end

// And it's done, that easy
// You can copy-paste the code, just make sure to replace Pistol with whatever ammo you want to drop
// For simplicitys sake, here's a ready-to-copy set with the Custom placeholder that you can easily replace

if npc:GetActiveWeapon():GetPrimaryAmmoType() == 3 then
Custom:SetPos( npc:WorldSpaceCenter() ) // Make the ammo spawn at the NPC's center mass
Custom:Spawn() // Spawn it in
Custom:SetCollisionGroup(2) // Make it nocollide with the ragdoll
end
end // This 2nd end is for the GetConVar("NPCDropAmmo"):GetBool() line
// If you've deleted that line, then delete this end as well

end)

// And it's done
// No, really, that's all you have to do
// There's literally nothing else to it