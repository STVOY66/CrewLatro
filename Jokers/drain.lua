SMODS.Atlas {
    key = "DownTheDrain",
    path = "DownTheDrain.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'drain',
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
    atlas = "DownTheDrain",
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
            local valid_suit = false
            for k, v in pairs(G.hand.highlighted) do
                if v:is_suit(G.GAME.current_round.drain_card.suit) then
                    valid_suit = true
                    break
                end
            end
            if valid_suit then
                card.ability.extra.total = card.ability.extra.total + card.ability.extra.mod
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})

                print("Re-rolling...")
                local valid_cards = {}
                for k, v in pairs(G.playing_cards) do
                    -- TODO: Filter out stone cards
                    -- if not v.config.center == G.P_CENTERS.m_stone then
                        valid_cards[#valid_cards + 1] = v
                    -- end
                end
                if valid_cards[1] then
                    local drain_card = pseudorandom_element(valid_cards, pseudoseed("PottyTime"..G.GAME.round_resets.ante))
                    G.GAME.current_round.drain_card.suit = drain_card.base.suit
                end
            end
        end

        if context.joker_main and card.ability.extra.total > 0 then
            return {
                message = "+"..card.ability.extra.total,
                vars = {card.ability.extra.total},
                mult_mod = card.ability.extra.total,
                card = self
            }
        end
    end
}

local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.current_round.drain_card = { suit = 'Spades' } 
  return ret
end

function SMODS.current_mod.reset_game_globals(run_start)
    -- G.GAME.current_round.drain_card = { suit = 'Spades' }
    -- local valid_cards = {}
    -- for k, v in pairs(G.playing_cards) do
    --     if not v.config.center == G.P_CENTERS.m_stone then
    --         valid_cards[#valid_cards + 1] = v
    --     end
    -- end
    -- if valid_cards[1] then
    --     local drain_card = pseudorandom_element(valid_cards, pseudoseed("PottyTime"..G.GAME.round_resets.ante))
    --     print(drain_card.suit)
    --     G.GAME.current_round.drain_card.suit = drain_card.suit
    -- end
end