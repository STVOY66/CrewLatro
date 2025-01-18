SMODS.Consumable {
    key = "500kg",
    set = "Spectral",
    loc_txt = {
        name = "500kg Bomb",
        text = {"Randomly destroys {C:attention}half{} {C:inactive}(#2#){} of the cards from the deck,", "pays {C:money}$#1#{} per destroyed card"}
    },

    config = { extra = {payout = 1, denom = 2, default_blast = 26}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.payout, tern(G.GAME.kg_blast_zone == nil, card.ability.extra.default_blast, G.GAME.kg_blast_zone), card.ability.extra.default_blast}}
    end,

    atlas = "ConsumAtlas",
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    hidden = true,
    soul_set = "Spectral",
    soul_rate = 0.03,
    can_repeat_soul = true,

    add_to_deck = function(self, card, card_table, other_card)
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
        pseudoshuffle(temp_deck, pseudoseed(pseudoseed("LegalizeNuclearBombs")*os.time()))
        for count = 1, G.GAME.kg_blast_zone do temp_deck[count]:start_dissolve() end
        ease_dollars(G.GAME.kg_blast_zone)

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.2,
            func = function()
                G.GAME.kg_blast_zone = math.floor(#G.playing_cards / card.ability.extra.denom)
            end
        }), "other")

        G.E_MANAGER:clear_queue(other)
    end
}