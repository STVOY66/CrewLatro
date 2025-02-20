SMODS.Atlas {
    key = 'crew_Cigarettes',
    path = 'Cigarettes.png',
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_500cigs',
    loc_txt = {
        name = '#5# Cigarettes',
        text = {"This Joker gains {C:mult}+#1#{} Mult and {C:chips}-#2#{} Chips per hand played.",
                "{C:inactive}(Currently {C:mult}#3#{C:inactive} Mult and {C:chips}#4#{C:inactive} Chips)"}
    },
    
    config = { extra = {m_mod = 1, c_mod = 5, t_mult = 0, t_chips = 0, cigs = 500}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.m_mod,
                        card.ability.extra.c_mod,
                        CREWLIB.tern(card.ability.extra.t_mult < 0, card.ability.extra.t_mult, '+'..card.ability.extra.t_mult),
                        CREWLIB.tern(card.ability.extra.t_chips < 0, card.ability.extra.t_chips, '+'..card.ability.extra.t_chips),
                        card.ability.extra.cigs}}
    end,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    atlas = "crew_Cigarettes",
    pos = { x = 0, y = 0 },
    cost = 5,

    calculate = function(self, card, context)
        if context.before and not context.debuffed_hand and not card.debuff then
            this_joke = card.ability.extra
            this_joke.cigs = this_joke.cigs - 1
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "-1 Cigarette!"})
            if this_joke.cigs <= 0 then
                SMODS.debuff_card(card, true, 'ciggies')
            end
            this_joke.t_mult = this_joke.t_mult + this_joke.m_mod
            this_joke.t_chips = this_joke.t_chips - this_joke.c_mod
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.t_chips,
                mult = card.ability.extra.t_mult
            }
        end
    end
}