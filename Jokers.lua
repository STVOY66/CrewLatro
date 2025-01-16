SMODS.Atlas {
    key = "CrewLatroAtlas",
    path = "CrewLatroAtlas.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'fahrenheit',
    loc_txt = {
        name = 'Burn the Books',
        text = {"If first discard is a {C:attention}4{}, {C:attention}5{}, or an {C:attention}Ace{},", "destroy card and gain {C:money}$#1#{}."}
    },

    config = { extra = { payout = 3 }},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.payout}}
    end,

    rarity = 1,
    atlas = "CrewLatroAtlas",
    pos = { x = 0, y = 0 },
    cost = 6,

    calculate = function(self, card, context)
        if context.discard and not context.other_card.debuff and (context.other_card:get_id() == 4 or context.other_card:get_id() == 5 or context.other_card:get_id() == 14) then
            return { dollars = card.ability.extra.payout }
        end
    end
}