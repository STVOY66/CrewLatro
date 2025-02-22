SMODS.Atlas {
    key = "crew_Clutch",
    path = "Clutch.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_tachanka',
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
    atlas = "crew_Clutch",
    pos = { x = 0, y = 0},
    cost = 8,

    calculate = function(self, card, context)
        if context.destroying_card and G.GAME.current_round.hands_left == 0 and not context.blueprint then
            if not card.ability.extra.trigger then
                card.ability.extra.trigger = true
                -- print('Trigger!')
                local temp_hand = {}
                for k, v in pairs(G.hand.cards) do temp_hand[#temp_hand+1] = v end
                G.E_MANAGER:add_event(Event({
                    trigger = "immediate",
                    -- delay = 0.2,
                    func = function()
                        for count = 1, #temp_hand do temp_hand[count]:start_dissolve() end
                        return true
                    end
                }))
            end

            return true
        end

        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                message = "OHHHH MY GAAHHHHHD",
                sound = 'crew_clutch',
                volume = 0.8,
                Xmult_mod = mult^(card.ability.extra.expo-1)
            }
        end

        if context.end_of_round and G.GAME.current_round.hands_left == 0 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:start_dissolve()
                    return true
                end
            }))
        end
    end,

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 )
        -- table.insert(badges, 1, create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 ))
    end
}