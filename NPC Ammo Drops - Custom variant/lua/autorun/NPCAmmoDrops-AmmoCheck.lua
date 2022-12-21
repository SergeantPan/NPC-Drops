// If your weapon(s) use custom ammo, then you will want to use this command
// It will write the ID-type of the ammo your weapon uses, and ALSO the underbarrel ammo
// If it is valid, of course

concommand.Add("WhatsMyAmmo", function(ply)
print("Your weapon uses " .. ply:GetActiveWeapon():GetPrimaryAmmoType() .. " ammo")
if ply:GetActiveWeapon():GetSecondaryAmmoType() == -1 then
print("You have no underbarrel attached")
else
print("Your underbarrel has " .. ply:GetActiveWeapon():GetSecondaryAmmoType() .. " ammo")
end
end)