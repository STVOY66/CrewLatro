SMODS.Atlas {
    key = "crew_DownTheDrain",
    path = "DownTheDrain.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_drain',
    loc_txt = {
        name = 'Down the Drain',
        text = {'If a {V:1}#1#{} {C:attention}Flush{} is discarded,',
                'this joker gains {C:mult}+#2#{} Mult',
                '{S:0.8}Suit changes after increase',
                '{C:inactive}(Currently{} {C:mult}+#3# {C:inactive}Mult)'}
    },
    config = { extra = {mod = 2, total = 0} },

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    atlas = "crew_DownTheDrain",
    pos = { x = 0, y = 0},
    cost = 8,

    loc_vars = function(self, info_queue, card)
        return {vars = {G.GAME.current_round.drain_card.suit:sub(1,-2),
                        card.ability.extra.mod,
                        card.ability.extra.total,
                        colours = {G.C.SUITS[G.GAME.current_round.drain_card.suit]}}}
    end,

    calculate = function(self, card, context)
        if context.pre_discard and next(evaluate_poker_hand(G.hand.highlighted)["Flush"]) and not context.blueprint then
            local valid_suit = true
            for k, v in pairs(G.hand.highlighted) do
                if not v:is_suit(G.GAME.current_round.drain_card.suit) then
                    valid_suit = false
                    break
                end
            end
            if valid_suit then
                card.ability.extra.total = card.ability.extra.total + card.ability.extra.mod
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!", sound = "crew_flush", volume = 1})

                local drain_suit = CREWLIB.poll_suit(true, pseudoseed("PottyTime"..G.GAME.round_resets.ante))
                G.GAME.current_round.drain_card.suit = drain_suit
                -- print("Re-rolling...")
            end
        end

        if context.joker_main and card.ability.extra.total > 0 then
            return {
                message = "+"..card.ability.extra.total,
                vars = {card.ability.extra.total},
                mult_mod = card.ability.extra.total,
                card = card
            }
        end
    end,

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 )
        -- table.insert(badges, 1, create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 ))
    end
}

local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.current_round.drain_card = { suit = 'Spades' }
  return ret
end

function SMODS.current_mod.reset_game_globals(run_start)
    if #SMODS.find_card('j_crew_drain') == 0 then
        -- print("Triggered!")
        G.GAME.current_round.drain_card = { suit = 'Spades' }
        local polled_suit = CREWLIB.poll_suit(true, pseudoseed("PottyTime"..G.GAME.round_resets.ante))
        if polled_suit then
            G.GAME.current_round.drain_card.suit = polled_suit
        end
    end
end