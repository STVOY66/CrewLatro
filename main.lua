CREWLIB = CREWLIB or {}

CREWLIB.tern = function(b, t, f)
    if b then return t else return f end
end

CREWLIB.inc = function(v)
    return v + 1
end

CREWLIB.id_rank = {'A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'}

SMODS.Atlas {
    key = "crew_PlaceJoke",
    path = "PlaceJoke.png",
    px = 71, py = 95
}

SMODS.Atlas {
    key = "modicon",
    path = "angry-stare-gif-atlas.png",
    px = 128, py = 128,
}

assert(SMODS.load_file('sounds.lua'))()

local jpath = SMODS.current_mod.path..'Jokers/'
for _,v in pairs(NFS.getDirectoryItems(jpath)) do
    assert(SMODS.load_file('Jokers/'..v))()
end

local cpath = SMODS.current_mod.path..'Consumables/'
for _,v in pairs(NFS.getDirectoryItems(cpath)) do
    assert(SMODS.load_file('Consumables/'..v))()
end