CreateConVar( "ChanceOfAmmo", "100", 128, "Chance of ammo drop 100 = 100%, 10 = 10% etc." )
CreateConVar( "NPCDropAmmo", "1", 128, "Enable NPCs dropping ammo 1 = Enabled, 0 = Disabled" )
CreateConVar( "PlayerDropAmmo", "1", 128, "Enable Players dropping ammo 1 = Enabled, 0 = Disabled" )

hook.Add( "OnNPCKilled", "FuckIt", function( npc )

local PistolShit = ents.Create( "item_ammo_pistol" ) // replace "item_ammo_pistol" with your own entity, if you want, same for all the others
local RevolverShit = ents.Create( "item_ammo_357" )
local SmgShit = ents.Create( "item_ammo_smg1" )
local ArShit = ents.Create( "item_ammo_ar2" )
local ShotgunShit = ents.Create( "item_box_buckshot" )
local RocketShit = ents.Create( "item_rpg_round" )
local BowShit = ents.Create( "item_ammo_crossbow" )
local AmmoChance = math.Rand( 1, 100 )

if GetConVar( "NPCDropAmmo" ):GetInt() == 0 then return end

if npc:GetActiveWeapon():IsWeapon() == false then return end

if AmmoChance > GetConVar( "ChanceOfAmmo" ):GetInt() then return end

if npc:GetActiveWeapon():GetClass() == "weapon_pistol" then // i don't know why i'm putting this here
PistolShit:SetPos( npc:GetPos() )  // but if you decide to snoop around may aswell tell you how to work it
PistolShit:Spawn() // replace the "weapon_pistol" with whatever weapon your npc has
PistolShit:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetClass() == "weapon_357" then
RevolverShit:SetPos( npc:GetPos() )
RevolverShit:Spawn()
RevolverShit:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetClass() == "weapon_smg1" then
SmgShit:SetPos( npc:GetPos() )
SmgShit:Spawn()
SmgShit:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetClass() == "weapon_ar2" then
ArShit:SetPos( npc:GetPos() )
ArShit:Spawn()
end

if npc:GetActiveWeapon():GetClass() == "weapon_shotgun" then
ShotgunShit:SetPos( npc:GetPos() )
ShotgunShit:Spawn()
ShotgunShit:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetClass() == "weapon_rpg" then
RocketShit:SetPos( npc:GetPos() )
RocketShit:Spawn()
RocketShit:SetCollisionGroup( 1 )
end

if npc:GetActiveWeapon():GetClass() == "weapon_crossbow" then
BowShit:SetPos( npc:GetPos() )
BowShit:Spawn()
BowShit:SetCollisionGroup( 1 )
end
end)

function DoPlayerDeath( ply, attacker, dmg )

local PistolShit = ents.Create( "item_ammo_pistol" )
local RevolverShit = ents.Create( "item_ammo_357" )
local SmgShit = ents.Create( "item_ammo_smg1" )
local ArShit = ents.Create( "item_ammo_ar2" )
local ShotgunShit = ents.Create( "item_box_buckshot" )
local RocketShit = ents.Create( "item_rpg_round" )
local BowShit = ents.Create( "item_ammo_crossbow" )
local AmmoChance = math.Rand( 1, 100 )

if GetConVar( "PlayerDropAmmo" ):GetInt() == 0 then return end

if ply:GetActiveWeapon():IsWeapon() == false then return end

if AmmoChance > GetConVar( "ChanceOfAmmo" ):GetInt() then return end

if ply:GetActiveWeapon():GetClass() == "weapon_pistol" then
PistolShit:SetPos( ply:GetPos() )
PistolShit:Spawn()
PistolShit:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetClass() == "weapon_357" then
RevolverShit:SetPos( ply:GetPos() )
RevolverShit:Spawn()
RevolverShit:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetClass() == "weapon_smg1" then
SmgShit:SetPos( ply:GetPos() )
SmgShit:Spawn()
SmgShit:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetClass() == "weapon_ar2" then
ArShit:SetPos( ply:GetPos() )
ArShit:Spawn()
end

if ply:GetActiveWeapon():GetClass() == "weapon_shotgun" then
ShotgunShit:SetPos( ply:GetPos() )
ShotgunShit:Spawn()
ShotgunShit:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetClass() == "weapon_rpg" then
RocketShit:SetPos( ply:GetPos() )
RocketShit:Spawn()
RocketShit:SetCollisionGroup( 1 )
end

if ply:GetActiveWeapon():GetClass() == "weapon_crossbow" then
BowShit:SetPos( ply:GetPos() )
BowShit:Spawn()
BowShit:SetCollisionGroup( 1 )
end
end

hook.Add("DoPlayerDeath", "Youshithead", DoPlayerDeath )