SMODS.Atlas {
    key = 'crew_HogInfinite',
    path = 'HogInfinite.png',
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_hogwild',
    loc_txt = {
        name = 'Hog Infinite',
        text = {"{C:green}#1# in #2#{} chance to retrigger scoring cards", "a maximum of #3# additional times."}
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.num, card.ability.extra.denom, card.ability.extra.max_trig}}
    end,

    config = { extra = {num = (G.GAME and G.GAME.probabilities.normal or 1), denom = 2, max_trig = 5}},
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    atlas = "crew_HogInfinite",
    pos = { x = 0, y = 0 },
    cost = 5,


    -- TODO: Optimize weight table generation.
    calculate = function(self, card, context)
        -- pseudorandom("HOGINFINITE") < (G.GAME.probabilities.normal/card.ability.extra.denom) 
        local trig_proc = pseudorandom("HAWGWILD")
        local trig_denom = card.ability.extra.denom
        local trig_num = card.ability.extra.num
        if context.repetition and context.cardarea == G.play and (trig_proc < (trig_num/trig_denom)) then
            local trigs = 0
            local weights = {}
            for i = 1, card.ability.extra.max_trig do
                if i == 1 then weights[i] = trig_num/trig_denom
                else weights[i] = weights[i-1]/(CREWLIB.tern(trig_denom <= 1, 2, trig_denom)) end
            end
            print(weights)

            for i = card.ability.extra.max_trig, 1, -1 do
                if trig_proc < weights[i] then
                    trigs = i
                    break
                end
            end
            print(trigs)

            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "HAWG WILD!", sound = "crew_hawg_wild", volume = 0.8})
            
            return {
                repetitions = trigs,
                message = "Again!",
                card = context.other_card
            }
        end
    end,

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Art: GravyWizard", G.C.GREY, G.C.WHITE, 0.8 )
        -- table.insert(badges, 1, create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 ))
    end
}