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
                "{C:inactive,s:0.8}It's fantastic"}
    },
    
    unlocked = true, discovered = true,
    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2,
    atlas = "Fantastic",
    pos = { x = 0, y = 0},
    cost = 4,

    calculate = function(self, card, context)
        if context.
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