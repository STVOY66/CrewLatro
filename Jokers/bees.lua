SMODS.Atlas {
    key = 'crew_CompanyJoker',
    path = 'CompanyJoker.png',
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_bees',
    loc_txt = {
        name = 'Company Joker',
        text = {"{C:chips}#1#{} Chips.",
                "Increases by {C:chips}+#2#{} every hand played."}
    },

    config = { extra = {tot = -50,
                        mod = 15}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.tot, card.ability.extra.mod}}
    end,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 3,
    atlas = "crew_CompanyJoker",
    pos = { x = 0, y = 0 },
    cost = 10,

    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.tot = card.ability.extra.tot + card.ability.extra.mod
            return {
                message = 'Upgrade!'
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.tot
            }
        end
    end
}