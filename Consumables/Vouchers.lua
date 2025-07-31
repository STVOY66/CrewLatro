SMODS.Atlas {
    key = "crew_AllIn",
    path = "AllIn.png",
    px = 71, py = 95
}

SMODS.Voucher {
    key = "crew_bet",
    loc_txt = {
        name = 'All In',
        text = {"{C:attention}+#1#{} Ante,", "{C:chips}+#2#{} hand", "each round."}
    },

    config = { extra = {
        anteMod = 1,
        handMod = 1,
    }},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.anteMod,
                        card.ability.extra.handMod}}
    end,

    unlocked = true,
    discovered = true,
    atlas = "crew_AllIn",
    pos = { x = 0, y = 0 },
    cost = 5,

    redeem = function(self, card)
        ease_ante(card.ability.extra.anteMod)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.anteMod

        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.handMod
        ease_hands_played(card.ability.extra.handMod)
    end
}