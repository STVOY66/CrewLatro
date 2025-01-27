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

    config = { extra = {triggers = 1, retrig = false, modded_cards = {}}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.triggers}}
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
        if context.individual and context.cardarea == G.play and not card.ability.extra.retrig then
            context.other_card.triggers = context.other_card.triggers + 1
            print(''..context.other_card.triggers)
            if context.other_card.triggers >= 2 then card.ability.extra.retrig = true end
            card.ability.extra.modded_cards[#card.ability.extra.modded_cards + 1] = context.other_card
        end

        if context.repetition and card.ability.extra.retrig then
            return {
                message = 'Again!',
                repititions = card.ability.extra.triggers,
                func = function()
                    card.ability.extra.retrig = false
                    return true
                end
            }
        end

        if context.end_of_round and #card.ability.extra.modded_cards > 0 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1,
                func = function()
                    for k, v in pairs(card.ability.extra.modded_cards) do
                        v.triggers = 0
                        print(v.triggers)
                    end
                    card.ability.extra.modded_cards = {}
                    return true
                end
            }))
        end
    end
}