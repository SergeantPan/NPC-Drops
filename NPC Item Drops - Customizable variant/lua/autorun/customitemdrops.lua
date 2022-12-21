CreateConVar( "ChanceOfItems", "100", 128, "Chance of item drop 100 = 100%, 10 = 10% etc." )
CreateConVar( "NPCDropItems", "1", 128, "Enable NPCs dropping items 1 = Enabled, 0 = Disabled" )

// These are entirely optional
// If you want to remove these, do so
// Just make sure you remove the pieces of code that utilize these commands

hook.Add( "OnNPCKilled", "MakeYourOwnExperience", function( npc )

local ItemChance = math.Rand( 1, 100 ) // Create this stuff

local ItemTable = {
	"item_healthvial",
	"item_healthkit",
	"item_battery"
}

// This is a table It determines which items can drop
// You can edit this to your hearts content, or create another one if you feel so inclined
// Just make sure to use a unique identifier

local AnotherItemTable = {}

// This is an empty table, which you can edit as you wish
// Use the above example to avoid issues

if GetConVar( "NPCDropItems" ):GetInt() == 0 then return end

// Do we allow drops?
// If you delete the NPCDropItems console command, remove this aswell

if ItemChance > GetConVar( "ChanceOfItems" ):GetInt() then return end

// ItemChance is a random number between 1 and 100
// ChanceOfItems is the number determined by the console command
// For Ex. If ItemChance = 82 and ChanceOfItems = 65 then no item drops
// Delete this if the console command is also deleted

local RandomItem = ents.Create(table.Random(ItemTable))
// local AnotherRandomItem = ents.Create(table.Random(ItemTable))

// This simplifies item creation. It also applies the randomness when choosing an item
// You can create multiple of these, for specific NPC's if you so choose

// Here comes the part where we determine if it should drop, and specify the NPC aswell

if (npc:GetClass() == "npc_citizen" or npc:GetClass() == "npc_combine_s" or npc:GetClass() == "npc_metropolice") and not npc:HasSpawnFlags(8) then
RandomItem:SetPos( npc:WorldSpaceCenter() ) // Set the position to be the NPC's center mass
RandomItem:SetCollisionGroup( 2 ) // Modify the collision group so it no longer collides with the NPC
RandomItem:Spawn() // Create the entity itself
end

// The item is now created. To break down what is happening in the first line;
// npc:GetClass() determines the NPC. In this case, npc_citizen is the ordinary citizen/rebel, npc_combine_s is the generic Combine Soldier (and all variants)
// npc_metropolice is the metrocop (obviously)

// not npc:SpawnFlags(8) checks if the NPC has this specific setting enabled. Metropolice may have this option enabled, meaning they drop a health vial upon death
// If this is the case, the addon will refuse to drop an item from a dead metropolice

// There is a workaround, using the code below

// Note that this code has to be applied BEFORE the code that checks for spawnflags
// Otherwise it does nothing of value
// Like this:

// if npc:HasSpawnFlags(8) then
// npc:SetKeyValue( "spawnflags", bit.bor(npc:GetSpawnFlags() - 8) )
// end
//
// if (npc:GetClass() == "npc_citizen" or npc:GetClass() == "npc_combine_s" or npc:GetClass() == "npc_metropolice") and not npc:HasSpawnFlags(8) then
// RandomItem:SetPos( npc:GetPos() ) // Set the position to be on the NPC
// RandomItem:SetCollisionGroup( 2 ) // Modify the collision group so it no longer collides with the NPC
// RandomItem:Spawn() // Create the entity itself
// end

// You can also leave it out, or completely ignore the spawnflag mechanic
// Do note that not having the spawnflag check means Metropolice can/will drop the healthvial, in addition to another item from this addon

end)
