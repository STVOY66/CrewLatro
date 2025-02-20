SMODS.Atlas {
    key = "crew_TheQuarry",
    path = "TheQuarry.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_stonedigger',
    loc_txt = {
        name = 'The Quarry',
        text = {"When discarding a hand of only {C:attention}Stone Cards{},",
                "destroys them and gains {C:chips}+#1#{} Chips per card destroyed",
                "{C:inactive}(Currently{} {C:chips}+#2# {C:inactive}Chips)"}
    },

    config = { extra = { c_mod = 50, t_chips = 0, full_stone = false}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.c_mod, card.ability.extra.t_chips}}
    end,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 3,
    atlas = "crew_TheQuarry",
    pos = { x = 0, y = 0 },
    cost = 10,

    calculate = function(self, card, context)
        if not context.blueprint then
            if context.pre_discard then
                local full_stone = true
                for k, v in ipairs(context.full_hand) do
                    if v.config.center ~= G.P_CENTERS.m_stone then
                        full_stone = false
                        break;
                    end
                end
                
                print(full_stone)
                card.ability.extra.full_stone = full_stone
            end
    
            if context.discard then
                if card.ability.extra.full_stone then
                    card.ability.extra.t_chips = card.ability.extra.t_chips + card.ability.extra.c_mod
                    return { message = "Upgraded!", remove = true, card = card }
                end
            end
        end
        
        if context.joker_main then
            return {chips = card.ability.extra.t_chips}
        end
    end
}