-- overrides judgement for 'Ocupado'
SMODS.Consumable:take_ownership(
    'c_judgement',
    {
        use = function(self, card, area, copier)
            local key_override = nil
            local sticker_override = nil
            if G.GAME.stake > 3 and pseudorandom('doorstuck') < 0.1 then
                key_override = 'j_crew_occupied'
                sticker_override = {'eternal'}
            end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card = SMODS.create_card({set = 'Joker', area = G.jokers, key = key_override, key_append = 'jud', no_edition = true, stickers = sticker_override})
                card:add_to_deck()
                G.jokers:emplace(card)
                card:juice_up(0.3, 0.5)
                return true end }))
            delay(0.6)
        end
    },
    true
)

SMODS.Atlas {
    key = "crew_Ignorant",
    path = "Ignorant.png",
    px = 63, py = 93
}

SMODS.Consumable {
    key = "crew_waxhead",
    set = "Tarot",
    loc_txt = {
        name = "The Ignorant",
        text = {"Add a {C:attention}random seal{},", "to {C:attention}#1#{} selected", "cards in your hand."}
    },

    config = { extra = {max_select = 2}},
    loc_vars = function(self, info_queue, card)
        -- Ternary prevents nil value from displaying
        return {vars = {card.ability.extra.max_select}}
    end,

    atlas = "crew_Ignorant",
    pos = { x = 0, y = 0 },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false, -- Makes it a rare card (a la 'Soul')

    can_use = function(self, card)
        if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_select then
            return true
        else return false end
    end,

    use = function(self, card, area, copier)
        for k, v in ipairs(G.hand.highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                v:set_seal(SMODS.poll_seal({guaranteed = true}))
                return true end }))
            
            delay(0.5)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:remove_from_highlighted(v, false); return true end }))
        end
    end,
    
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 )
        -- table.insert(badges, 1, create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 ))
    end
}