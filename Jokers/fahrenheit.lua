SMODS.Atlas {
    key = "crew_Fahrenheit452",
    path = "Fahrenheit 452.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_fahrenheit',
    loc_txt = {
        name = 'Burn the Books',
        text = {"If first discard is a {C:attention}4{}, {C:attention}5{}, or an {C:attention}Ace{},", "destroy card and gain {C:money}$#1#{}."}
    },

    config = { extra = { payout = 3 }},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.payout}}
    end,

    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    atlas = "crew_Fahrenheit452",
    pos = { x = 0, y = 0 },
    cost = 6,

    calculate = function(self, card, context)
        if context.discard and G.GAME.current_round.discards_used == 0 and #context.full_hand == 1 then
            if not context.other_card.debuff 
            and (context.other_card:get_id() == 4 or context.other_card:get_id() == 5 or context.other_card:get_id() == 14) then
                ease_dollars(card.ability.extra.payout)
                return { message = "BURNT!", remove = true, card = card}
            end
        end
    end,

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 )
        -- table.insert(badges, 1, create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 ))
    end
}