SMODS.Atlas {
    key = "crew_Gamblecore",
    path = "Gamblecore.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_gamble',
    loc_txt = {
        name = 'Gamblecore',
        text = {"{C:green}#1# in #2#{} chance to trigger when a {C:attention}7{} is played.",
                "Pays out {C:money}$#3#{} when triggered.",
                "{C:red,E:2}self destructs{}"}
    },

    config = { extra = {
        numer = (G.GAME and G.GAME.probabilities.normal or 1),
        denom = 20,
        payout = 100,
        trigger = false
    }},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.numer,
                        card.ability.extra.denom,
                        card.ability.extra.payout}}
    end,

    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    atlas = "crew_Gamblecore",
    pos = { x = 0, y = 0 },
    cost = 5,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 7 and not card.ability.extra.trigger then
                if pseudorandom('gambling') < (G.GAME.probabilities.normal/card.ability.extra.denom) then
                    return {
                        dollars = card.ability.extra.payout,
                        message = "Winner!",
                        message_card = card,
                        sound = 'crew_gamble_winner',
                        func = function()
                            card.ability.extra.trigger = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound('tarot1')
                                    card:start_dissolve()
                                    return true
                                end
                            }))
                        end
                    }
                else
                    return {
                        message = 'Aw dang it!',
                        message_card = card,
                        sound = 'crew_gamble_buzzer'
                    }
                end
            end
        end
    end
}