CreateConVar( "ChanceOfAmmo", "100", 128, "Chance of ammo drop 100 = 100%, 10 = 10% etc." )
CreateConVar( "NPCDropAmmo", "1", 128, "Enable NPCs dropping ammo 1 = Enabled, 0 = Disabled" )
CreateConVar( "PlayerDropAmmo", "1", 128, "Enable Players dropping ammo 1 = Enabled, 0 = Disabled" )

hook.Add( "OnNPCKilled", "TheyDied", function( npc )

local PistolAmmo = ents.Create( "item_ammo_pistol" ) // Replace "item_ammo_pistol" with your own entity, if you want.
local RevolverAmmo = ents.Create( "item_ammo_357" ) // Each one can be replaced as you wish
local SmgAmmo = ents.Create( "item_ammo_smg1" ) // If you want a new one just use one of the existing ones as template
local ArAmmo = ents.Create( "item_ammo_ar2" )
local ShotgunAmmo = ents.Create( "item_box_buckshot" )
local RocketAmmo = ents.Create( "item_rpg_round" )
local BowAmmo = ents.Create( "item_ammo_crossbow" )
local AmmoChance = math.Rand( 1, 100 ) // Create this stuff

if GetConVar( "NPCDropAmmo" ):GetInt() == 0 then return end // Do we allow drops?

if npc:GetActiveWeapon():IsWeapon() == false then return end // Does the NPC even have a weapon? DO NOT DELETE! Otherwise antlions and such will cause errors.

if AmmoChance > GetConVar( "ChanceOfAmmo" ):GetInt() then return end // Do we get lucky and get ammo?

if npc:GetActiveWeapon():GetClass() == "weapon_pistol" then // Replace the "weapon_pistol" with whatever weapon your npc has
PistolAmmo:SetPos( npc:GetPos() )  // This makes it spawn at their feet
PistolAmmo:Spawn() 
PistolAmmo:SetCollisionGroup( 1 ) // Disable collision with the NPC so the ammo doesn't go flying.
end

if npc:GetActiveWeapon():GetClass() == "weapon_357" then // Rince and repeat
RevolverAmmo:SetPos( npc:GetPos() )
RevolverAmmo:Spawn()
RevolverAmmo:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetClass() == "weapon_smg1" then
SmgAmmo:SetPos( npc:GetPos() )
SmgAmmo:Spawn()
SmgAmmo:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetClass() == "weapon_ar2" then
ArAmmo:SetPos( npc:GetPos() )
ArAmmo:Spawn()
end

if npc:GetActiveWeapon():GetClass() == "weapon_shotgun" then
ShotgunAmmo:SetPos( npc:GetPos() )
ShotgunAmmo:Spawn()
ShotgunAmmo:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetClass() == "weapon_rpg" then
RocketAmmo:SetPos( npc:GetPos() )
RocketAmmo:Spawn()
RocketAmmo:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetClass() == "weapon_crossbow" then
BowAmmo:SetPos( npc:GetPos() )
BowAmmo:Spawn()
BowAmmo:SetCollisionGroup( 1 )
end
end)

function DoPlayerDeath( ply ) // Now we do it for players

local PistolAmmo = ents.Create( "item_ammo_pistol" )
local RevolverAmmo = ents.Create( "item_ammo_357" )
local SmgAmmo = ents.Create( "item_ammo_smg1" )
local ArAmmo = ents.Create( "item_ammo_ar2" )
local ShotgunAmmo = ents.Create( "item_box_buckshot" )
local RocketAmmo = ents.Create( "item_rpg_round" )
local BowAmmo = ents.Create( "item_ammo_crossbow" )
local AmmoChance = math.Rand( 1, 100 )

if GetConVar( "PlayerDropAmmo" ):GetInt() == 0 then return end

if ply:GetActiveWeapon():IsWeapon() == false then return end

if AmmoChance > GetConVar( "ChanceOfAmmo" ):GetInt() then return end

if ply:GetActiveWeapon():GetClass() == "weapon_pistol" then // You get the point
PistolAmmo:SetPos( ply:GetPos() )
PistolAmmo:Spawn()
PistolAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetClass() == "weapon_357" then
RevolverAmmo:SetPos( ply:GetPos() )
RevolverAmmo:Spawn()
RevolverAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetClass() == "weapon_smg1" then
SmgAmmo:SetPos( ply:GetPos() )
SmgAmmo:Spawn()
SmgAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetClass() == "weapon_ar2" then
ArAmmo:SetPos( ply:GetPos() )
ArAmmo:Spawn()
end

if ply:GetActiveWeapon():GetClass() == "weapon_shotgun" then
ShotgunAmmo:SetPos( ply:GetPos() )
ShotgunAmmo:Spawn()
ShotgunAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetClass() == "weapon_rpg" then
RocketAmmo:SetPos( ply:GetPos() )
RocketAmmo:Spawn()
RocketAmmo:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetClass() == "weapon_crossbow" then
BowAmmo:SetPos( ply:GetPos() )
BowAmmo:Spawn()
BowAmmo:SetCollisionGroup( 1 )
end
end

hook.Add("DoPlayerDeath", "YouHaveDied", DoPlayerDeath )