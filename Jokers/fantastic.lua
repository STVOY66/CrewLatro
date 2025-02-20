SMODS.Atlas {
    key = "crew_Fantastic",
    path = "Fantastic.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_saythatagain',
    loc_txt = {
        name = 'Say that Again...',
        text = {'After playing a {C:attention}Four of a Kind{},',
                'create a copy of the played rank in hand with a random suit',
                '{C:inactive,s:0.8}"It\'s Fantastic" - Ben Grimm'}
    },
    
    unlocked = true, discovered = true,
    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 2,
    atlas = "crew_Fantastic",
    pos = { x = 0, y = 0},
    cost = 4,

    calculate = function(self, card, context)
        if context.before and next(context.poker_hands["Four of a Kind"]) then
            print("Triggered!")
            local card_rank = CREWLIB.id_rank[context.scoring_hand[1]:get_id()]

            print("Rank: "..card_rank)
            
            local valid_suits = {}
            for k, v in pairs(G.playing_cards) do
                -- TODO: Filter out stone cards
                -- if not v.config.center == G.P_CENTERS.m_stone then
                valid_suits[#valid_suits + 1] = string.sub(v.base.suit, 1, 1)
                -- end
            end
            local card_suit = pseudorandom_element(valid_suits, pseudoseed('ReedRichards'))
            print("Suit: "..card_suit)

            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "It's Fantastic!", colour = G.C.CHIPS})
            create_playing_card({front = G.P_CARDS[card_suit..'_'..card_rank], center = G.P_CENTERS.c_base}, G.hand, nil, nil, nil)
        end
    end
}