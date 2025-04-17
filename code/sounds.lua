SMODS.Sound{
    key = "music_godfather",
    path = "godfather.ogg",
    select_music_track = function(self)
        if G and G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_hsr_Svarog" then
            return math.huge --id return a gazillion if possible
        end 
    end,
}

SMODS.Sound{
    key = "music_wildfire_i",
    path = "wildfire_i.ogg",
    pitch = 1,
    select_music_track = function(self)
        if G and G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_hsr_Cocolia" and (G.GAME.current_round.phases_beaten or 0) < 2 then
            return math.huge --id return a gazillion if possible
        end 
    end,
}

SMODS.Sound{
    key = "music_wildfire_v",
    path = "wildfire_v.ogg",
    pitch = 1,
    select_music_track = function(self)
        if G and G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_hsr_Cocolia" and (G.GAME.current_round.phases_beaten or 0) >= 2 then
            return math.huge --id return a gazillion if possible
        end 
    end,
}

SMODS.Sound{
    key = "music_hopes_and_dreams",
    path = "hopes_and_dreams.ogg",
    pitch = 1,
    select_music_track = function(self)
        if G and G.GAME and G.GAME.blind and G.GAME.blind.name == "bl_hsr_Asriel" then
            return math.huge --id return a gazillion if possible
        end 
    end,
}