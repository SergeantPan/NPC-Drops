hook.Add( "HUDPaint", "CustomIcon", function() // Feel free to replace CustomIcon with your own identifier
// Do not use these identifiers;
// ArmorIcon, ArcCWArmorIcon, GrenadeWarning, HealthIcon, ArcCWHealthIcon, WeaponIcon and RocketIcon 

local itemdistance = GetConVar("ItemIconDistance"):GetInt() // Player-Chosen distance

local OutlineEnabled = GetConVar("IconOutlines"):GetBool() // Outlines for icons

local XRayVision = GetConVar("SeeThruWalls"):GetBool() // If icons appear through walls

local sizeoficon = GetConVar("IconSize"):GetInt() // Size, as chosen by player
local outlineicon = sizeoficon + 0.75 // Outline is always slightly bigger
// You can modify this value if you want the outline icon to be bigger or smaller

local p = LocalPlayer() // This is you

// local customcolor = {}
// Presumably, you're going to use an icon with color
// But if you do want to use a color, format it as such:
// local customcolor = Color(0,0,0,0) In order: Red, Green, Blue and Alpha value
// Look up color indexes online for a better explanation

local customicon = Material("customicon.png") // Icon and stuff
local customoutline = Material("customoutline.png")
// You can (and should) modify these

for k, v in pairs (ents.FindByClass("customentity")) do // This is where we look for the entity
// Use * for wildcards, eg. "item_*"

local custompos = v:WorldSpaceCenter() // Get the center of the items collision model
local distance = p:GetPos():Distance(v:WorldSpaceCenter()) // Distance between entity and player

local customtrace = {}
customtrace.start = v:WorldSpaceCenter()
customtrace.endpos = p:EyePos()
customtrace.mask = 1
local customtracefinished = util.TraceLine(customtrace)
// Only modify the names, leave everything else as is
// This is how we find out if the item is behind a wall or not

// if GetConVar("CustomIcon"):GetBool() then // Presumably you do not want to have your icon dictated by a console command
// But if you do, place this at the top of the file
// CreateConVar("CustomIcon", "1", 128, "Enable custom icon.")
// And place an extra end at line 58

cam.Start3D()
								
if OutlineEnabled and distance < itemdistance and (XRayVision or !tracedammo.HitWorld) then // This is the outline
	render.SetMaterial( customoutline ) // It's literally just another image, behind the actual icon
	render.DrawSprite( custompos, outlineicon, outlineicon, color_black ) // color_black makes the icon black
end
if distance < itemdistance and (XRayVision or !tracedammo.HitWorld) then // Check the distance, and whether or not we can see the icon through walls
	render.SetMaterial( customicon ) // If we cannot see through walls, then the icon will not render through walls
	render.DrawSprite( custompos, sizeoficon, sizeoficon, ammocolor ) // Create the sprite itself, with our custom color
end
cam.End3D()
end
// end											
end)
