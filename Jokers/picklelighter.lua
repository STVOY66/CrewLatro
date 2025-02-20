SMODS.Atlas {
    key = 'crew_Pickle',
    path = 'Pickle.png',
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_picklelighter',
    loc_txt = {
        name = 'pickle',
        text = {"pickle either good ({C:mult}+#1#{} Mult)", "or no good ({C:mult}-#1#{} Mult)", "{C:green}1 in 2"}
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult_mod}}
    end,

    config = { extra = {mult_mod = 15, weight = 3}},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    atlas = "crew_Pickle",
    pos = { x = 0, y = 0 },
    cost = 3,

    calculate = function(self, card, context)
        if context.joker_main then
            local mul = card.ability.extra.mult_mod * -1
            local mess = "pickle no good D:"
            local ogg = "crew_pickle_no_good"
            if pseudorandom('pickl') < (G.GAME.probabilities.normal/card.ability.extra.weight) then
                mul = mul * -1
                mess = "pickle good! :D"
                ogg = "crew_picklesound"
            end
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = mess, colour = G.C.MULT, sound = ogg})
            return { mult = mul }
        end
    end
}