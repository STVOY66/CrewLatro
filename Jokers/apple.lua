SMODS.Atlas {
    key = "crew_GodApple",
    path = "GodApple.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_apple',
    loc_txt = {
        name = 'God Apple',
        text = {"Scoring face cards become {C:attention}Polychrome{}."}
    },

    config = { extra = { trig = false }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
    end,

    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 4,
    atlas = "crew_GodApple",
    pos = { x = 0, y = 0 },
    cost = 12,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            local trig = false
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then
                    trig = true
                    context.scoring_hand[i]:set_edition({polychrome=true}, false, false)
                end
            end
            if trig then card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Polychrome!"}) end
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