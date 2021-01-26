CreateConVar( "ChanceOfAmmo", "100", 128, "Chance of ammo drop 100 = 100%, 10 = 10% etc." )

hook.Add( "OnNPCKilled", "WeKilledThem", function( npc )

local PistolAmmo = ents.Create( "arccw_ammo_pistol" ) // replace "arccw_ammo_pistol" with your own entity, if you want, same for all the others
local RevolverAmmo = ents.Create( "arccw_ammo_357" )
local SmgAmmo = ents.Create( "arccw_ammo_smg1" )
local ArAmmo = ents.Create( "arccw_ammo_ar2" )
local ShotgunAmmo = ents.Create( "arccw_ammo_buckshot" )
local RocketAmmo = ents.Create( "item_rpg_round" )
local BowAmmo = ents.Create( "arccw_ammo_sniper" )
local AmmoChance = math.Rand( 1, 100 )

if AmmoChance > GetConVar( "ChanceOfAmmo" ):GetInt() then return end
if npc:GetActiveWeapon():IsWeapon() == false then return end
local Weapon = npc:GetActiveWeapon():GetClass()

if Weapon == "arccw_go_cz75" or Weapon == "arccw_go_fiveseven" or Weapon == "arccw_go_glock" or Weapon == "arccw_go_m9" or Weapon == "arccw_go_p2000" or Weapon == "arccw_go_p250" or Weapon == "arccw_go_tec9" or Weapon == "arccw_go_usp" then
PistolAmmo:SetPos( npc:GetPos() )  // Feel free to add your own weapons to the list. This one already features the GSO Weapons (+ the FN FAL.)
PistolAmmo:Spawn() // The format is simply; Weapon == "weaponnamehere". If you can't figure out the second one, go in game, right click on the weapon spawn icon and press "Copy to clipboard"
PistolAmmo:SetCollisionGroup( 2 ) // Then copy that name /\here/\ Eg; Weapon == "arccw_go_fiveseven"
end

if Weapon == "arccw_go_deagle" or Weapon == "arccw_go_r8" then
RevolverAmmo:SetPos( npc:GetPos() ) // Do note the ammo types. AR's, BR's and MG's all use AR ammo. SMG's all use SMG ammo (duh.)
RevolverAmmo:Spawn() // This is because it makes more sense than the default ammo types.
RevolverAmmo:SetCollisionGroup( 2 ) // I mean, SMG ammo in a 5.45 rifle? Although the 9mm conversions still use SMG ammo. I can't change that.
end

if Weapon == "arccw_go_mac10" or Weapon == "arccw_go_mp5" or Weapon == "arccw_go_bizon" or Weapon == "arccw_go_mac10" or Weapon == "arccw_go_mp5" or Weapon == "arccw_go_mp7" or Weapon == "arccw_go_mp9" or Weapon == "arccw_go_p90" or Weapon == "arccw_go_ump" then
SmgAmmo:SetPos( npc:GetPos() )
SmgAmmo:Spawn()
SmgAmmo:SetCollisionGroup( 2 )
end

if Weapon == "arccw_go_ace" or Weapon == "arccw_go_ak47" or Weapon == "arccw_go_ar15" or Weapon == "arccw_go_aug" or Weapon == "arccw_go_famas" or Weapon == "arccw_go_fnfal" or Weapon == "arccw_go_g3" or Weapon == "arccw_go_m4" or Weapon == "arccw_go_m249para" or Weapon == "arccw_go_negev" or Weapon == "arccw_go_sg556" or Weapon == "arccw_go_scar" then
ArAmmo:SetPos( npc:GetPos() )
ArAmmo:Spawn()
SmgAmmo:SetCollisionGroup( 2 )
end

if Weapon == "arccw_go_870" or Weapon == "arccw_go_m1014" or Weapon == "arccw_go_mag7" or Weapon == "arccw_go_nova" then
ShotgunAmmo:SetPos( npc:GetPos() )
ShotgunAmmo:Spawn()
ShotgunAmmo:SetCollisionGroup( 2 )
end

if Weapon == "weapon_rpg" then
RocketAmmo:SetPos( npc:GetPos() )
RocketAmmo:Spawn()
RocketAmmo:SetCollisionGroup( 2 )
end

if Weapon == "arccw_go_awp" or Weapon == "arccw_go_ssg08" then
BowAmmo:SetPos( npc:GetPos() )
BowAmmo:Spawn()
BowAmmo:SetCollisionGroup( 2 )
end
end)