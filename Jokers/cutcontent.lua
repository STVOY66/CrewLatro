SMODS.Atlas {
    key = "crew_CutContent",
    path = "cutcontent.png",
    px = 71, py = 95
}

SMODS.Joker {
    key = 'crew_cutcontent',
    loc_txt = {
        name = 'Cut Content',
        text = {'Destroys scoring {C:attention}High Card{} and ',
                'places {C:attention}2{} new cards in hand {C:attention}1{} rank lower'}
    },

    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
    
    unlocked = true, discovered = true,
    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    rarity = 3,
    atlas = "crew_CutContent",
    pos = {x = 1, y = 0},
    soul_pos = {x = 2, y = 2},
    cost = 8,

    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            local temp_pos = pseudorandom_element(G.GAME.cutcontent_sprites, pseudoseed("cuttingroom"))
            G.P_CENTERS.j_crew_cutcontent.pos.x = temp_pos.x
            G.P_CENTERS.j_crew_cutcontent.pos.y = temp_pos.y
        end

        if context.after and #context.scoring_hand == 1 then
            local valid_suits = {}
            for k, v in pairs(G.playing_cards) do
                -- TODO: Filter out stone cards
                -- if not v.config.center == G.P_CENTERS.m_stone then
                valid_suits[#valid_suits + 1] = string.sub(v.base.suit, 1, 1)
                -- end
            end
            local new_suit = pseudorandom_element(valid_suits, pseudoseed('CUTTINGROOM'))
            local new_rank = CREWLIB.id_rank[context.scoring_hand[1]:get_id() - 1]

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0,
                blocking = true,
                blockable = true,
                func = function()
                    play_sound('tarot1')
                    context.scoring_hand[1]:start_dissolve()
                    create_playing_card({front = G.P_CARDS[pseudorandom_element(valid_suits, pseudoseed('CUTTINGROOM'))..'_'..new_rank], center = G.P_CENTERS.c_base}, G.hand, nil, nil, nil)
                    create_playing_card({front = G.P_CARDS[pseudorandom_element(valid_suits, pseudoseed('CUTTINGROOM'))..'_'..new_rank], center = G.P_CENTERS.c_base}, G.hand, nil, nil, nil)
                    return true
                end
            }))
        end
    end
}

local function init_sprite_list(dim, num, offset)
    local output = {}
    local atlas_dim = dim
    local sprite_num = num
    local temp_pos = offset
    for i=1, 3 do
        output[i] = {x = temp_pos.x, y = temp_pos.y}
        if temp_pos.x == atlas_dim.x - 1 then
            if temp_pos.y < atlas_dim.y - 1 then
                temp_pos.x = 0
                temp_pos.y = temp_pos.y + 1
            end
        else temp_pos.x = temp_pos.x + 1 end
    end
    return output
end

local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.cutcontent_sprites = init_sprite_list({ x = 3, y = 3}, 3, { x = 1, y = 0})
--   print(ret.cutcontent_sprites)
  return ret
end

