CreateConVar( "ChanceOfAmmo", "100", 128, "Chance of ammo drop 100 = 100%, 10 = 10% etc." )
CreateConVar( "NPCDropAmmo", "1", 128, "Enable NPCs dropping ammo 1 = Enabled, 0 = Disabled" )
CreateConVar( "PlayerDropAmmo", "1", 128, "Enable Players dropping ammo 1 = Enabled, 0 = Disabled" )
CreateConVar( "DropGrenadeAmmo", "1", 128, "Enable players/NPC's with weapons that use SMG1 Alt-Fire to drop SMG1 grenades 1 = Enabled, 0 = Disabled" )
CreateConVar( "DropAR2AltAmmo", "1", 128, "Enable players with weapons that use AR2 Alt-Fire to drop Energy balls 1 = Enabled, 0 = Disabled" )

hook.Add( "OnNPCKilled", "TheyDied", function( npc )

local RocketAmmo = ents.Create( "item_rpg_round" )
local PistolAmmo = {}
local RevolverAmmo = {}
local SmgAmmo = {}
local ArAmmo = {}
local ShotgunAmmo = {}
local BowAmmo = {}
local Grenadez = {}

if ConVarExists("arccw_ammo_replace") and GetConVar("arccw_ammo_replace"):GetInt() == 1 then
PistolAmmo = ents.Create( "arccw_ammo_pistol" )
RevolverAmmo = ents.Create( "arccw_ammo_357" )
SmgAmmo = ents.Create( "arccw_ammo_smg1" )
ArAmmo = ents.Create( "arccw_ammo_ar2" )
ShotgunAmmo = ents.Create( "arccw_ammo_buckshot" )
BowAmmo = ents.Create( "arccw_ammo_sniper" )
Grenadez = ents.Create( "arccw_ammo_smg1_grenade" )
else
PistolAmmo = ents.Create( "item_ammo_pistol" )
RevolverAmmo = ents.Create( "item_ammo_357" )
SmgAmmo = ents.Create( "item_ammo_smg1" )
ArAmmo = ents.Create( "item_ammo_ar2" )
ShotgunAmmo = ents.Create( "item_box_buckshot" )
BowAmmo = ents.Create( "item_ammo_crossbow" )
Grenadez = ents.Create( "item_ammo_smg1_grenade" )
end

local AmmoChance = math.Rand( 1, 100 ) // Create this stuff

if GetConVar( "NPCDropAmmo" ):GetInt() == 0 then return end // Do we allow drops?

if npc:GetActiveWeapon():IsWeapon() == false then return end // Does the NPC even have a weapon? DO NOT DELETE! Otherwise antlions and such will cause errors.

if AmmoChance > GetConVar( "ChanceOfAmmo" ):GetInt() then return end // Do we get lucky and get ammo?

if npc:GetActiveWeapon():GetSecondaryAmmoType() == 9 and GetConVar( "DropGrenadeAmmo" ):GetInt() == 1 then
Grenadez:SetPos( npc:GetPos() )
Grenadez:Spawn()
Grenadez:SetCollisionGroup( 1 ) // If you are using VManip's Manual Pickup addon, change this value to 2. This will allow you to actually pick up the ammo.
end

if npc:GetActiveWeapon():GetPrimaryAmmoType() == 3 then // Being the massive dumbass I am, I didn't do this until now Rather than using the weapon as the basis, we look for the ammo type
PistolAmmo:SetPos( npc:GetPos() )  // This makes it spawn at their feet // Fucking kill me This makes it much better and universal, rather than restricting it to weapon types
PistolAmmo:Spawn() 
PistolAmmo:SetCollisionGroup( 1 ) // Disable collision with the NPC so the ammo doesn't go flying
end

if npc:GetActiveWeapon():GetPrimaryAmmoType() == 5 then // Rince and repeat, again
RevolverAmmo:SetPos( npc:GetPos() )
RevolverAmmo:Spawn()
RevolverAmmo:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetPrimaryAmmoType() == 4 then
SmgAmmo:SetPos( npc:GetPos() )
SmgAmmo:Spawn()
SmgAmmo:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetPrimaryAmmoType() == 1 then
ArAmmo:SetPos( npc:GetPos() )
ArAmmo:Spawn()
ArAmmo:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetPrimaryAmmoType() == 7 then
ShotgunAmmo:SetPos( npc:GetPos() )
ShotgunAmmo:Spawn()
ShotgunAmmo:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetPrimaryAmmoType() == 8 then
RocketAmmo:SetPos( npc:GetPos() )
RocketAmmo:Spawn()
RocketAmmo:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetPrimaryAmmoType() == 6 then
BowAmmo:SetPos( npc:GetPos() )
BowAmmo:Spawn()
BowAmmo:SetCollisionGroup( 1 )
end
end)

function DoPlayerDeath( ply ) // Now we do it for players

local RocketAmmo = ents.Create( "item_rpg_round" )
local ArBallz = ents.Create( "item_ammo_ar2_altfire" )
local PistolAmmo = {}
local RevolverAmmo = {}
local SmgAmmo = {}
local ArAmmo = {}
local ShotgunAmmo = {}
local BowAmmo = {}
local Grenadez = {}

if ConVarExists("arccw_ammo_replace") and GetConVar("arccw_ammo_replace"):GetInt() == 1 then
PistolAmmo = ents.Create( "arccw_ammo_pistol" )
RevolverAmmo = ents.Create( "arccw_ammo_357" )
SmgAmmo = ents.Create( "arccw_ammo_smg1" )
ArAmmo = ents.Create( "arccw_ammo_ar2" )
ShotgunAmmo = ents.Create( "arccw_ammo_buckshot" )
BowAmmo = ents.Create( "arccw_ammo_sniper" )
Grenadez = ents.Create( "arccw_ammo_smg1_grenade" )
else
PistolAmmo = ents.Create( "item_ammo_pistol" )
RevolverAmmo = ents.Create( "item_ammo_357" )
SmgAmmo = ents.Create( "item_ammo_smg1" )
ArAmmo = ents.Create( "item_ammo_ar2" )
ShotgunAmmo = ents.Create( "item_box_buckshot" )
BowAmmo = ents.Create( "item_ammo_crossbow" )
Grenadez = ents.Create( "item_ammo_smg1_grenade" )
end

local AmmoChance = math.Rand( 1, 100 )

if GetConVar( "PlayerDropAmmo" ):GetInt() == 0 then return end

if ply:GetActiveWeapon():IsWeapon() == false then return end

if AmmoChance > GetConVar( "ChanceOfAmmo" ):GetInt() then return end

if ply:GetActiveWeapon():GetSecondaryAmmoType() == 9 and GetConVar( "DropGrenadeAmmo" ):GetInt() == 1 then
Grenadez:SetPos( npc:GetPos() )
Grenadez:Spawn()
Grenadez:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetPrimaryAmmoType() == 2 and GetConVar( "DropAR2AltAmmo" ):GetInt() == 1 then
ArBallz:SetPos( ply:GetPos() )
ArBallz:Spawn()
ArBallz:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetPrimaryAmmoType() == 3 then // You get the point
PistolAmmo:SetPos( ply:GetPos() )
PistolAmmo:Spawn()
PistolAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetPrimaryAmmoType() == 5 then
RevolverAmmo:SetPos( ply:GetPos() )
RevolverAmmo:Spawn()
RevolverAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetPrimaryAmmoType() == 4 then
SmgAmmo:SetPos( ply:GetPos() )
SmgAmmo:Spawn()
SmgAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetPrimaryAmmoType() == 1 then
ArAmmo:SetPos( ply:GetPos() )
ArAmmo:Spawn()
ArAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetPrimaryAmmoType() == 7 then
ShotgunAmmo:SetPos( ply:GetPos() )
ShotgunAmmo:Spawn()
ShotgunAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetPrimaryAmmoType() == 8 then
RocketAmmo:SetPos( ply:GetPos() )
RocketAmmo:Spawn()
RocketAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetPrimaryAmmoType() == 6 then
BowAmmo:SetPos( ply:GetPos() )
BowAmmo:Spawn()
BowAmmo:SetCollisionGroup( 1 )
end
end

hook.Add("DoPlayerDeath", "YouHaveDied", DoPlayerDeath )
