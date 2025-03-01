----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
    key = 'crew_JoseLuck', --atlas key
    path = 'JoseLuck.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'crew_JoseLuck', --joker key
    loc_txt = { -- local text
        name = 'Jose Luck',
        text = {
          'When hand is played,',
          '{C:green}#4# in #3#{} chance for {X:mult,C:white} X#1# {}',
          '{C:green}#4# in #3#{} chance for {X:mult,C:white} X#2# {}',
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'crew_JoseLuck', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 2, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 0.01, Xmult2 = 10, odds = 10
      }
    },
    
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult, card.ability.extra.Xmult2, card.ability.extra.odds, ""..(G.GAME and G.GAME.probabilities.normal or 1)}} --#1# is replaced with card.ability.extra.Xmult
    end,

    calculate = function(self,card,context)
        if context.joker_main and pseudorandom('JoseLuck') < G.GAME.probabilities.normal / card.ability.extra.odds then
            return {
              xmult = pseudorandom('joseluckreturn') > 0.5 and card.ability.extra.Xmult or card.ability.extra.Xmult2
            }
        end
    end,

    set_badges = function(self, card, badges)
      badges[#badges+1] = create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 )
      -- table.insert(badges, 1, create_badge("Art: DemarcoCooley", G.C.GREY, G.C.WHITE, 0.8 ))
    end
}


----------------------------------------------
------------MOD CODE END----------------------