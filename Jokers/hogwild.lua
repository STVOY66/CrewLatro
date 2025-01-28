SMODS.Atlas {
    key = 'crew_HogInfinite',
    path = 'HogInfinite.png',
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_hogwild',
    loc_txt = {
        name = 'Hog Infinite',
        text = {"Retriggers retriggered cards that", "retrigger cards."}
    },

    config = { extra = {triggers = 2}},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    atlas = "crew_HogInfinite",
    pos = { x = 0, y = 0 },
    cost = 5,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if G.GAME.current_round.hogwild then print("Triggered!") end
        end
    end
}