-------------------------------------------CONSUMABLES DOWN HERE----------------------------------------------------------------
local RelicSetEffects = returnText("RelicSetEffects")

SMODS.ConsumableType{
    key = 'Relics', --consumable type key

    collection_rows = {4,4}, --amount of cards in one page
    primary_colour = G.C.PURPLE, --first color
    secondary_colour = G.C.DARK_EDITION, --second color
    loc_txt = {
        collection = 'Relics', --name displayed in collection
        name = 'Relics', --name displayed in badge
        undiscovered = {
            name = '???', --undiscovered name
            text = {'Discover this relic through finding them in shop.'} --undiscovered text
        }
    },
    shop_rate = 0, --rate in shop out of 100
}

SMODS.UndiscoveredSprite{
    key = 'Relics', --must be the same key as the consumabletype
    atlas = 'Jokers',
    pos = {x = 0, y = 0}
}

SMODS.Atlas{
    key = 'musketeer', --atlas key
    path = 'musketeer.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Atlas{
    key = 'thief', --atlas key
    path = 'thief.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Atlas{
    key = 'eagle', --atlas key
    path = 'wind.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Atlas{
    key = 'passerby', --atlas key
    path = 'passerby.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

local relicShortcut = nil
local bodyParts = {
    "head", "body", "hands", "feet"
} --freaky ahh table name :sob:
local bodyPosition = {
    ["head"] = {0,0},
    ["body"] = {0,1},
    ["hands"] = {1,0},
    ["feet"] = {1,1},
}
local relicDescription = {
    ["placeholder"] = {
        ["head"] = {
            [1] = 'PLACEHOLDER',
            [2] = 'PLACEHOLDER',
        },
        ["body"] = {
            [1] = 'PLACEHOLDER',
            [2] = 'PLACEHOLDER',
        },
        ["hands"] = {
            [1] = 'PLACEHOLDER',
            [2] = 'PLACEHOLDER',
        },
        ["feet"] = {
            [1] = 'PLACEHOLDER',
            [2] = 'PLACEHOLDER',
        },
    },

    ["musketeer"] = {
        ["head"] = {
            [1] = 'A cowboy hat decorated with wild wheat.',
            [2] = 'A mark of the legendary Musketeer Oakley.',
        },
        ["body"] = {
            [1] = "A knitted cape in an ethnic style,",
            [2] = "lined with bulletproof fibers.",
        },
        ["hands"] = {
            [1] = "A pair of leather gloves with partially cracked exterior.",
            [2] = "The area that would have gripped a gun is particularly worn out.",
        },
        ["feet"] = {
            [1] = "These riding boots have a V-shaped cutout.",
            [2] = "Appearing casual and loose, they are also very comfortable to wear.",
        },
    },

    ["thief"] = {
        ["head"] = {
            [1] = "A mask used to change one's facial appearance.",
            [2] = 'Coupled with evocative acting skills, it can help you deceive anyone.',
        },
        ["body"] = {
            [1] = "A steel cable disguised as a woven belt,",
            [2] = "with hooks and pulleys hidden in its buckle.",
        },
        ["hands"] = {
            [1] = "A pair of special gloves interlaced with nanomaterials.",
            [2] = "The prints on its surface can change in real time.",
        },
        ["feet"] = {
            [1] = "A pair of boots that enhances any human's physical prowess.",
            [2] = "It helps the Meteor Thief stride between buildings.",
        },
    },
}
local 
-----------Musketeer of Wild Wheat---------------
relicShortcut = "musketeer"
for i = 1,#bodyParts do
    local v = bodyParts[i]
    local bodyName = BalatroSR.firstToUpper(v)

    SMODS.Consumable{
        key = v..'_'..relicShortcut, 
        set = 'Relics', 
        atlas = relicShortcut, 
        pos = {x = bodyPosition[v][1], y = bodyPosition[v][2]}, 
        loc_txt = {
            name = 'Musketeer of Wild Wheat', 
            text = { 
                '{C:mult}+#1#{} Mult',
                "{C:inactive,s:0.7}(2) {}"..RelicSetEffects["2pcs"][relicShortcut],
                "{C:inactive,s:0.7}(4) {}"..RelicSetEffects["4pcs"][relicShortcut],
                '{C:inactive,s:0.7}'..relicDescription[relicShortcut][v][1]..'{}',
                '{C:inactive,s:0.7}'..relicDescription[relicShortcut][v][2]..'{}',
                '{C:inactive,s:0.7}(Relic Piece: '..bodyName..'){}',
            }
        },
    
        config = {
            extra = RelicSetEffects["config"][relicShortcut],
            relicName = relicShortcut,
        },
    
        pools = {
            relics = true
        },
    
        loc_vars = function(self,info_queue, center)
            return {vars = {
                center.ability.extra.baseMult,
                center.ability.extra.twopcsBonus,
                center.ability.extra.fourpcsBonus,
            }
        } 
        end,
    
        can_use = function(self,card)
            if #G.jokers.highlighted == 1 and G.jokers.highlighted[1].ability and string.find(G.jokers.highlighted[1].config.center.key,"j_hsr_") then return true end
        end,
    
        use = function(self,card,area,copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    G.jokers.highlighted[1].ability.extra[v] = card.ability.relicName
                    G.jokers:unhighlight_all()
                    return true
                end
            }))
        end,
    }
end
----------Thief of Shooting Meteor---------------
relicShortcut = "thief"
for i = 1,#bodyParts do
    local v = bodyParts[i]
    local bodyName = BalatroSR.firstToUpper(v)
    SMODS.Consumable{
        key = v..'_'..relicShortcut, 
        set = 'Relics', 
        atlas = relicShortcut, 
        pos = {x = bodyPosition[v][1], y = bodyPosition[v][2]}, 
        loc_txt = {
            name = 'Thief of Shooting Meteor', 
            text = { 
                'If wearer gives Chips during main scoring, {C:chips}+#1#{} Chips',
                'Otherwise, {C:mult}+#2#{} Mult',
                "{C:inactive,s:0.7}(2) {}"..RelicSetEffects["2pcs"][relicShortcut],
                "{C:inactive,s:0.7}(4) {}"..RelicSetEffects["4pcs"][relicShortcut],
                '{C:inactive,s:0.7}'..relicDescription[relicShortcut][v][1]..'{}',
                '{C:inactive,s:0.7}'..relicDescription[relicShortcut][v][2]..'{}',
                '{C:inactive,s:0.7}(Relic Piece: '..bodyName..'){}',
            }
        },
    
        config = {
            extra = RelicSetEffects["config"][relicShortcut],
            relicName = relicShortcut,
        },
    
        pools = {
            relics = true
        },
    
        loc_vars = function(self,info_queue, center)
            return {vars = {
                center.ability.extra.baseChips,
                center.ability.extra.baseMult,
                center.ability.extra.twopcsBonus,
                center.ability.extra.fourpcsBonus,
            }
        } 
        end,
    
        can_use = function(self,card)
            if #G.jokers.highlighted == 1 and G.jokers.highlighted[1].ability and string.find(G.jokers.highlighted[1].config.center.key,"j_hsr_") then return true end
        end,
    
        use = function(self,card,area,copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    G.jokers.highlighted[1].ability.extra[v] = card.ability.relicName
                    G.jokers:unhighlight_all()
                    return true
                end
            }))
        end,
    }
end
----------Passerby of Wandering Cloud------------    
relicShortcut = "passerby"
for i = 1,#bodyParts do
    local v = bodyParts[i]
    local bodyName = BalatroSR.firstToUpper(v)
    local rd1 = relicDescription["placeholder"][v][1]
    local rd2 = relicDescription["placeholder"][v][2]
    if relicDescription[relicShortcut] and relicDescription[relicShortcut][v] then
        rd1 = relicDescription[relicShortcut][v][1]
        rd2 = relicDescription[relicShortcut][v][2]
    end
    SMODS.Consumable{
        key = v..'_'..relicShortcut, 
        set = 'Relics', 
        atlas = relicShortcut, 
        pos = {x = bodyPosition[v][1], y = bodyPosition[v][2]}, 
        loc_txt = {
            name = 'Passerby of Wandering Cloud', 
            text = { 
                '{C:chips}+#1#{} Chips',
                "{C:inactive,s:0.7}(2) {}"..RelicSetEffects["2pcs"][relicShortcut],
                "{C:inactive,s:0.7}(4) {}"..RelicSetEffects["4pcs"][relicShortcut],
                '{C:inactive,s:0.7}'..rd1..'{}',
                '{C:inactive,s:0.7}'..rd2..'{}',
                '{C:inactive,s:0.7}(Relic Piece: '..bodyName..'){}',
            }
        },
    
        config = {
            extra = RelicSetEffects["config"][relicShortcut],
            relicName = relicShortcut,
        },
    
        pools = {
            relics = true
        },
    
        loc_vars = function(self,info_queue, center)
            return {vars = {
                center.ability.extra.baseChips,
                center.ability.extra.twopcsBonus,
            }
        } 
        end,
    
        can_use = function(self,card)
            if #G.jokers.highlighted == 1 and G.jokers.highlighted[1].ability and string.find(G.jokers.highlighted[1].config.center.key,"j_hsr_") then return true end
        end,
    
        use = function(self,card,area,copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    G.jokers.highlighted[1].ability.extra[v] = card.ability.relicName
                    G.jokers:unhighlight_all()
                    return true
                end
            }))
        end,
    }
end
----------Eagle of Twilight Line-----------------
relicShortcut = "eagle"
for i = 1,#bodyParts do
    local v = bodyParts[i]
    local bodyName = BalatroSR.firstToUpper(v)
    local rd1 = relicDescription["placeholder"][v][1]
    local rd2 = relicDescription["placeholder"][v][2]
    if relicDescription[relicShortcut] and relicDescription[relicShortcut][v] then
        rd1 = relicDescription[relicShortcut][v][1]
        rd2 = relicDescription[relicShortcut][v][2]
    end
    SMODS.Consumable{
        key = v..'_'..relicShortcut, 
        set = 'Relics', 
        atlas = relicShortcut, 
        pos = {x = bodyPosition[v][1], y = bodyPosition[v][2]}, 
        loc_txt = {
            name = 'Eagle of Twilight Line', 
            text = { 
                '{C:chips}+#1#{} Chips',
                "{C:inactive,s:0.7}(2) {}"..RelicSetEffects["2pcs"][relicShortcut],
                "{C:inactive,s:0.7}(4) {}"..RelicSetEffects["4pcs"][relicShortcut],
                '{C:inactive,s:0.7}'..rd1..'{}',
                '{C:inactive,s:0.7}'..rd2..'{}',
                '{C:inactive,s:0.7}(Relic Piece: '..bodyName..'){}',
            }
        },
    
        config = {
            extra = RelicSetEffects["config"][relicShortcut],
            relicName = relicShortcut,
        },
    
        pools = {
            relics = true
        },
    
        loc_vars = function(self,info_queue, center)
            return {vars = {
                center.ability.extra.baseChips,
                center.ability.extra.twopcsBonus,
                center.ability.extra.fourpcsBonus,
            }
        } 
        end,
    
        can_use = function(self,card)
            if #G.jokers.highlighted == 1 and G.jokers.highlighted[1].ability and string.find(G.jokers.highlighted[1].config.center.key,"j_hsr_") then return true end
        end,
    
        use = function(self,card,area,copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    G.jokers.highlighted[1].ability.extra[v] = card.ability.relicName
                    G.jokers:unhighlight_all()
                    return true
                end
            }))
        end,
    }
end