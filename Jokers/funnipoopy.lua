SMODS.Atlas {
    key = "crew_Deuce",
    path = "Deuce.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_funnipoopy',
    loc_txt = {
        name = 'Deuce',
        text = {"When playing a flush,",
                "if scoring hand contains a {C:attention}2{},",
                "copy leftmost {C:attention}2{} into hand."}
    },

    config = { extra = {}},
    loc_vars = function(self, info_queue, card)
        -- info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
    end,

    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 3,
    atlas = "crew_Deuce",
    pos = { x = 0, y = 0 },
    cost = 10,

    calculate = function(self, card, context)
        if context.before and next(context.poker_hands["Flush"]) then
            -- print("Triggered!")
            local in_hand = false
            local _deucy = nil
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 2 then
                    in_hand = true
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    _deucy = copy_card(context.scoring_hand[i], nil, nil, G.playing_card)
                    break
                end
            end

            if in_hand then
                _deucy:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, _deucy)
                G.hand:emplace(_deucy)
                _deucy.states.visible = nil

                G.E_MANAGER:add_event(Event({
                    func = function()
                        _deucy:start_materialize()
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Urgghh...", sound = "crew_poop", volume = 0.5})
            end
        end,
        
        set_badges = function(self, card, badges)
            badges[#badges+1] = create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 )
            -- table.insert(badges, 1, create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 ))
        end
        -- if context.repetition and context.cardarea == G.play then
        --     for i=1, #context.scoring_hand do
        --         if context.scoring_hand[i]:is_face() then
        --             context.scoring_hand[i]:set_edition({polychrome=true}, false, false)
        --         end
        --     end
        -- end
    end
}