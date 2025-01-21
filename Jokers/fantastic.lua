SMODS.Atlas {
    key = "Fantastic",
    path = "Fantastic.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'fantastic',
    loc_txt = {
        name = 'Say that Again...',
        text = {'After playing a {C:attention}Four of a Kind{},',
                'create a copy of the played rank in hand with a random suit',
                '{C:inactive,s:0.8}"It\'s Fantastic" - Ben Grimm'}
    },
    
    unlocked = true, discovered = true,
    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2,
    atlas = "Fantastic",
    pos = { x = 0, y = 0},
    cost = 4,

    calculate = function(self, card, context)
        if context.before and next(context.poker_hands["Four of a Kind"]) then
            print("Triggered!")
            target_rank = context.scoring_hand[1]:get_id()
            card_rank = target_rank < 10 and tostring(target_rank) or target_rank == 10 and 'T'
                      or target_rank == 11 and 'J' or target_rank == 12 and 'Q'
                      or target_rank == 13 and 'K' or target_rank == 14 and 'A'
            print("Rank: "..card_rank)
            card_suit = pseudorandom_element({'S', 'H', 'D', 'C'}, pseudoseed('ReedRichards'))
            print("Suit: "..card_suit)

            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "It's Fantastic!", colour = G.C.CHIPS})
            create_playing_card({front = G.P_CARDS[card_suit..'_'..card_rank], center = G.P_CENTERS.c_base}, G.hand, nil, nil, nil)
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