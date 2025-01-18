function tern(b, t, f)
    if b then return t else return f end
end

SMODS.Atlas {
    key = "PlaceJoke",
    path = "PlaceJoke.png",
    px = 71, py = 95
}

local jpath = SMODS.current_mod.path..'Jokers/'
for _,v in pairs(NFS.getDirectoryItems(jpath)) do
    assert(SMODS.load_file('Jokers/'..v))()
end

local cpath = SMODS.current_mod.path..'Consumables/'
for _,v in pairs(NFS.getDirectoryItems(cpath)) do
    assert(SMODS.load_file('Consumables/'..v))()
end