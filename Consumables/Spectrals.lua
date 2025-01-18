SMODS.Atlas {
    key = "500kg_Bomb",
    path = "500kg_Bomb.png",
    px = 63, py = 93
}

SMODS.Consumable {
    key = "500kg",
    set = "Spectral",
    loc_txt = {
        name = "500kg Bomb",
        text = {"Randomly destroys {C:attention}half{} {C:inactive}(#2#){} of the cards from the deck,", "pays {C:money}$#1#{} per destroyed card"}
    },

    config = { extra = {payout = 1, denom = 2, default_blast = 26}},
    loc_vars = function(self, info_queue, card)
        -- Ternary prevents nil value from displaying
        return {vars = {card.ability.extra.payout, tern(G.GAME.kg_blast_zone == nil, card.ability.extra.default_blast, G.GAME.kg_blast_zone), card.ability.extra.default_blast}}
    end,

    atlas = "500kg_Bomb",
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    hidden = true, -- Makes it a rare card (a la 'Soul')
    soul_set = "Spectral",
    soul_rate = 0.03, -- 3% chance of replacing a card in a spectral booster pack
    can_repeat_soul = true, -- more than 1 can appear ('Showman')

    add_to_deck = function(self, card, card_table, other_card)
        G.E_MANAGER:clear_queue("other")
        G.GAME.kg_blast_zone = math.floor(#G.playing_cards / card.ability.extra.denom)
        print(G.GAME.kg_blast_zone)
    end,

    can_use = function(self, card)
        if G.GAME.kg_blast_zone > 0 then
            return true
        end
        return false
    end,

    use = function(self, card, area, copier)
        local temp_deck = {}
        for k, v in pairs(G.playing_cards) do temp_deck[#temp_deck+1] = v end
        pseudoshuffle(temp_deck, pseudoseed("LegalizeNuclearBombs")) -- Shuffles all cards in temporary deck
        for count = 1, G.GAME.kg_blast_zone do temp_deck[count]:start_dissolve() end -- Destroys half of the cards
        ease_dollars(G.GAME.kg_blast_zone)

        G.E_MANAGER:add_event(Event({ -- Puts destruction on slight delay to allow calculating size of blast zone
            trigger = "after",
            delay = 0.2,
            func = function()
                G.GAME.kg_blast_zone = math.floor(#G.playing_cards / card.ability.extra.denom)
            end
        }), "other")

    end
}