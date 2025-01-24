-- overrides judgement for 'Ocupado'
SMODS.Consumable:take_ownership(
    'c_judgement',
    {
        use = function(self, card, area, copier)
            local key_override = nil
            local sticker_override = nil
            if G.GAME.stake > 3 and pseudorandom('doorstuck') < 0.2 then
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