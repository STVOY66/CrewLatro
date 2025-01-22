SMODS.Atlas {
    key = "at-Clutch",
    path = "Clutch.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'j-clutch',
    loc_txt = {
        name = 'HE\'S IN THE WALLS!!!',
        text = {'On final hand of round, {X:dark_edition,C:white}^#1#{} Mult.',
                'Destroys all playing cards in the play area',
                '{C:red,E:2}self destructs{}'}
    },

    config = {extra = {expo = 3, trigger = false}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.expo}}
    end,
    
    unlocked = true, discovered = true,
    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 3,
    atlas = "at-Clutch",
    pos = { x = 0, y = 0},
    cost = 8,

    calculate = function(self, card, context)
        if context.destroying_card and G.GAME.current_round.hands_left == 0 then
            card.ability.extra.trigger = true
        else card.ability.extra.trigger = false end

        if card.ability.extra.trigger then
            print('Triggered')
            local temp_hand = {}
            for k, v in pairs(G.hand.cards) do temp_hand[#temp_hand+1] = v end
            for k, v in pairs(context.full_hand) do temp_hand[#temp_hand+1] = v end

            G.E_MANAGER:add_event(Event({
                trigger = "before",
                delay = 0.2,
                func = function()
                    for count = 1, #temp_hand do temp_hand[count]:shatter() end
                    return true
                end
            }))
            card.ability.extra.trigger = false
        end

        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                message = "OHHHH MY GAAHHHHHD",
                Xmult_mod = mult^(card.ability.extra.expo-1)
            }
        end
    end
}