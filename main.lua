SMODS.Atlas {
    key = "CrewLatroAtlas",
    path = "CrewLatroAtlas.png",
    px = 71, py = 95
}

local path = SMODS.current_mod.path..'Jokers/'
for _,v in pairs(NFS.getDirectoryItems(path)) do
    assert(SMODS.load_file('Jokers/'..v))()
end