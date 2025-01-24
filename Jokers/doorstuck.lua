SMODS.Atlas {
    key = "crew_Ocupado",
    path = "Ocupado.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_occupied',
    loc_txt = {
        name = 'Ocupado',
        text = {"Does nothing"}
    },

    config = {},
    loc_vars = function(self, info_queue, card)
        return {}
    end,

    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    rarity = 1,
    atlas = "crew_Ocupado",
    pos = { x = 0, y = 0 },
    cost = 0,

    -- add_to_deck = function(self, card, from_debuff)
    --     self.ability.eternal = true
    -- end,

    in_pool = function(self, args)
        -- if G.GAME.stake > 3 then return true end
        return false
    end
}