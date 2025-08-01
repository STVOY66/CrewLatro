SMODS.Booster:take_ownership_by_kind("Spectral", {
    create_card = function(self, card, i)
        local card_to_create = {set = "Spectral", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "spe"}
        if G.GAME.moai_time then
            card_to_create.soulable = false
            card_to_create.key = "c_crew_dumdum"
            if pseudorandom("bombtime") < (1/40) then card_to_create.key = "c_crew_500kg" end
        end
        return card_to_create
    end
}, true)