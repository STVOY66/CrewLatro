SMODS.Sound {
    key = 'crew_music_Project8',
    path = 'Project_8.ogg',
    select_music_track = function()
        return (G.GAME == G.STATES.MENU) and 1 or false
    end,
    vol = 0.6,
    pitch = 0.7
}

SMODS.Sound {
    key = 'crew_clutch',
    path = 'clutch1.ogg',
}

SMODS.Sound {
    key = 'crew_moaioh',
    path = 'moai.ogg',
}

SMODS.Sound {
    key = 'crew_gamble_buzzer',
    path = 'gamble_buzzer.ogg',
}

SMODS.Sound {
    key = 'crew_gamble_winner',
    path = 'gamble_payout.ogg',
}

SMODS.Sound {
    key = 'crew_picklesound',
    path = 'pickle_.ogg',
}

SMODS.Sound {
    key = 'crew_pickle_no_good',
    path = 'pickle_no_good.ogg',
}

SMODS.Sound {
    key = 'crew_hawg_wild',
    path = 'hog_wild.ogg',
}

SMODS.Sound {
    key = 'crew_poop',
    path = 'poop2.ogg',
}

SMODS.Sound {
    key = 'crew_flush',
    path = 'flush1.ogg',
}