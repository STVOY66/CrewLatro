SMODS.Atlas {
    key = 'crew_HogInfinite',
    path = 'HogInfinite.png',
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_hogwild',
    loc_txt = {
        name = 'Hog Infinite',
        text = {"{C:attention}Retriggered{} cards are triggered", "{C:attention}#1#{} additional times."}
    },

    config = { extra = {trigger = 1}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.trigger}}
    end,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    atlas = "crew_HogInfinite",
    pos = { x = 0, y = 0 },
    cost = 5,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not context.other_card.retriggered then
                context.other_card.retriggered = true
                G.E_MANAGER:add_event(Event({
					func = function()
						context.other_card.retriggered = nil
						return true
					end
				}))
                if not context.other_card.hogged_out then context.other_card.hogged_out = false end
            end
        end

        -- if context.repetition and card.calculated then
        --     return {
        --         message = 'Again!',
        --         repetitions = card.ability.extra.trigger
        --     }
        -- end
    end
}