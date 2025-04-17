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

SMODS.Atlas{ --For placeholder.
    key = 'placeholder', --atlas key
    path = 'musketeer.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
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

    ["passerby"] = {
        ["head"] = {
            [1] = 'A withered twig that was used as a hairstick, with new flower buds sprouting on the end.',
            [2] = 'Now, the past is long gone, and the stick inlaid with parcel-gilt flower buds commemorates the beginning of a new life.',
        },
        ["body"] = {
            [1] = 'An old coat with a ragged hemline. The embroidery has been ruined by blade marks.',
            [2] = 'Flesh heals quickly, but a coat does not, nor does a person\'s pain.',
        },
        ["hands"] = {
            [1] = 'Bracers made from flowing coral gold and the leather of unknown beasts.',
            [2] = 'Only master artisans from the Vidyadhara dragon race can create this kind of superior armor.',
        },
        ["feet"] = {
            [1] = 'A durable pair of boots that have left shoe-prints on many worlds',
            [2] = 'and have witnessed many lethal situations.',
        },
    },

    ["eagle"] = {
        ["head"] = {
            [1] = 'A helmet used in high-speed flights that resembles the beak of a skyfish eagle.',
            [2] = 'It illustrates the principles of fluid mechanics.',
        },
        ["body"] = {
            [1] = 'A belt harness that connects the winged suit with metal supports embedded in thick linen.',
            [2] = 'Soft and tight-fitting.',
        },
        ["hands"] = {
            [1] = 'A ring worn by an outstanding skyfisher master,',
            [2] = 'with a pair of skyfish eagle\'s wings holding tight the wearer\'s finger.',
        },
        ["feet"] = {
            [1] = 'Puttees to keep the legs warm during flights,',
            [2] = 'decorated with a skyfish eagle\'s bristle feathers.',
        },
    },

    ["hunter"] = {
        ["head"] = {
            [1] = 'A hood made from the head of a huge Snow Plains bear. The fur seems to be possessed by some ghost or deity,',
            [2] = 'making it invulnerable to physical attacks.',
        },
        ["body"] = {
            [1] = 'A cloak made from the fine scales of the Ice Dragon,',
            [2] = 'nearly invisible under the brilliant refraction of light.',
        },
        ["hands"] = {
            [1] = 'A pair of tactical gloves, on which scaly claws of snowrock lizards are tightly sewn.',
            [2] = 'It can be used to safely climb up and hang on to any wall.',
        },
        ["feet"] = {
            [1] = 'A pair of enhanced power boots wrapped in soft elk fur.',
            [2] = 'With these, the hunter will only leave shallow footprints behind in the Snow Plains.',
        },
    },

    ["thunder"] = {
        ["head"] = {
            [1] = 'A pair of classic sunglasses worn by one of the lead singers,',
            [2] = 'Janis, whose chrome lenses reflect a blue hue.',
        },
        ["body"] = {
            [1] = 'David, one of the band\'s lead singers, drew a white star on the back',
            [2] = 'of this leather jacket and made it the cover of the band\'s final album.',
        },
        ["hands"] = {
            [1] = 'Bassist Sid\'s bracelet, woven from silk wristbands from tours.',
            [2] = 'Several lines of lyrics are written on it.',
        },
        ["feet"] = {
            [1] = 'Drummer Bonham\'s ankle boots, the dark leather surface',
            [2] = 'glued with rivets reflecting the stage lights.',
        },
    },

    ["champion"] = {
        ["head"] = {
            [1] = 'Boxing headgear that provides excellent protection.',
            [2] = 'It perfectly fits the shape of the owner\'s face.',
        },
        ["body"] = {
            [1] = 'A boxer\'s professional-level chest guard.',
            [2] = 'The outer and inner padding is designed to provide protection while not hindering movement.',
        },
        ["hands"] = {
            [1] = 'A pair of boxing gloves kept in excellent condition.',
            [2] = 'Some slight wear doesn\'t hinder their effectiveness.',
        },
        ["feet"] = {
            [1] = 'Intricately crafted from leather and mesh, the combination of',
            [2] = 'a thick insole and thin outsole ensures the wearer can be agile on their feet.',
        },
    },

    ["firesmith"] = {
        ["head"] = {
            [1] = 'Protective goggles crafted from dark-black fire crystals.',
            [2] = 'Through these lenses, even the flurry of intense sparks becomes a mosaic of dull shadows.',
        },
        ["body"] = {
            [1] = 'A blacksmith\'s apron without any superfluous adornment.',
            [2] = 'The texture of the leather and the family emblem are clearly visible.',
        },
        ["hands"] = {
            [1] = 'A ring with a symbol of flames.',
            [2] = 'It is the highest symbol of honor among the Firesmith clan.',
        },
        ["feet"] = {
            [1] = 'A prosthetic produced from metallic alloy.',
            [2] = 'Its surface is entwined with vivid fiery carvings.',
        },
    },

    ["genius"] = {
        ["head"] = {
            [1] = 'A pair of communication goggles embedded with ultraremote sensing technology that',
            [2] = 'breaks through the shackles of limited transmission and remote distances.',
        },
        ["body"] = {
            [1] = 'Diving-suit-like attire that envelops the body when activated,',
            [2] = 'sending neural signals from your whole body to the metafield in real time.',
        },
        ["hands"] = {
            [1] = 'A pair of gloves equipped with a precision frequency-capture device,',
            [2] = 'which enables direct manipulation of otherwise-intangible sound and light vibrations.',
        },
        ["feet"] = {
            [1] = 'A wearable gravity-capture device. It is shaped like',
            [2] = 'a pair of ice skates that reflects the stars\' twinkling lights during quick gliding.',
        },
    },

    ["wastelander"] = {
        ["head"] = {
            [1] = 'A breathing mask able to filter sand and radiation out from the air.',
            [2] = 'It seems like it was made from a discarded respirator.',
        },
        ["body"] = {
            [1] = 'A baggy robe adapted from a missionary\'s attire.',
            [2] = '...that\'s it.',
        },
        ["hands"] = {
            [1] = 'Multi-functional trash that can detect ionizing radiation in the air.',
            [2] = 'It can also trash-talk.',
        },
        ["feet"] = {
            [1] = 'The leg part of powered armor,',
            [2] = 'an exoskeleton made from scrap metals and old wires.',
        },
    },

    ["purity"] = {
        ["head"] = {
            [1] = 'A casque that resembles the religious stone statues of the Goddess of Forgiveness.',
            [2] = 'It was used to hide the wearer\'s appearance.',
        },
        ["body"] = {
            [1] = 'A heavy breastplate decorated with the distinctive symbols of',
            [2] = 'the Church of Purity Palace. Even the joints are airtight.',
        },
        ["hands"] = {
            [1] = 'A silver ring decorated with an ecclesiastical pattern,',
            [2] = 'Oembedded with a rather cloudy gem.',
        },
        ["feet"] = {
            [1] = 'Standard boots distributed to the Knights of the Church of Purity Palace,',
            [2] = 'with a simple word carved on their heels: Order.',
        },
    },

    ["wuthering"] = {
        ["head"] = {
            [1] = 'A standard-issue helmet that covers the head and face.',
            [2] = 'It has lining inside to help keep its wearer warm.',
        },
        ["body"] = {
            [1] = 'A neatly-ironed uniform of the Silvermane Guards from long ago.',
            [2] = 'The sturdy buttons press creases in the fabric.',
        },
        ["hands"] = {
            [1] = 'Metal gauntlets that give off a silvery sparkle.',
            [2] = 'A complex mechanical structure is hidden within its design.',
        },
        ["feet"] = {
            [1] = 'A pair of hard, silver-white metal greaves.',
            [2] = 'They provide protection while also being lightweight and warm.',
        },
    },
}
local 
-----------Musketeer of Wild Wheat---------------
relicShortcut = "musketeer"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
for i = 1,#bodyParts do
    local v = bodyParts[i]
    local bodyName = BalatroSR.firstToUpper(v)

    SMODS.Consumable{
        key = v..'_'..relicShortcut, 
        set = 'Relics', 
        atlas = relicShortcut, 
        pos = {x = bodyPosition[v][1], y = bodyPosition[v][2]}, 
        loc_txt = {
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Thief of Shooting Meteor---------------
relicShortcut = "thief"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
for i = 1,#bodyParts do
    local v = bodyParts[i]
    local bodyName = BalatroSR.firstToUpper(v)
    SMODS.Consumable{
        key = v..'_'..relicShortcut, 
        set = 'Relics', 
        atlas = relicShortcut, 
        pos = {x = bodyPosition[v][1], y = bodyPosition[v][2]}, 
        loc_txt = {
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Passerby of Wandering Cloud------------    
relicShortcut = "passerby"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
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
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Eagle of Twilight Line-----------------
relicShortcut = "eagle"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
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
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Hunter of Glacial Forest---------------
relicShortcut = "hunter"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
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
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
            text = { 
                '{C:attention}+#1#%{} ATK',
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
                center.ability.extra.baseATK,
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Band of Sizzling Thunder---------------
relicShortcut = "thunder"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
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
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
            text = { 
                '{C:attention}+#1#%{} ATK, {C:attention}+#2#%{} Basic Effect Efficiency',
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
                center.ability.extra.baseATK,
                center.ability.extra.baseBEE,
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Champion of Streetwise Boxing----------
relicShortcut = "champion"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
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
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
            text = { 
                '{C:attention}+#1#%{} Basic Effect Efficiency',
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
                center.ability.extra.baseBEE,
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Firesmith of Lava-Forging---------------
relicShortcut = "firesmith"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
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
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
            text = { 
                '{C:attention}+#1#%{} ATK',
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
                center.ability.extra.baseATK,
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Genius of Brilliant Stars----------------
relicShortcut = "genius"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
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
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
            text = { 
                '{C:attention}+#1#%{} ATK, {X:mult,C:white}X#2#{} Mult',
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
                center.ability.extra.baseATK,
                center.ability.extra.baseXMult,
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Wastelander of Banditry Desert-----------
relicShortcut = "wastelander"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
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
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
            text = { 
                '{C:attention}+#1#%{} Basic Effect Efficiency, {X:chips,C:white}X#2#{} Chips',
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
                center.ability.extra.baseBEE,
                center.ability.extra.baseXChip,
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Knight of Purity Palace-------------------
relicShortcut = "purity"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
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
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
            text = { 
                '{X:chips,C:white}X#1#{} Chips',
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
                center.ability.extra.baseXChip,
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end
----------Guard of Wuthering Snow--------------------
relicShortcut = "wuthering"
SMODS.Atlas{
    key = relicShortcut, --atlas key
    path = relicShortcut..'.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
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
            name = RelicSetEffects["config"][relicShortcut]["Name"], 
            text = { 
                '{X:mult,C:white}X#1#{} Mult',
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
                center.ability.extra.baseXMult,
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

        calculate = function(self,card,context)
            if (context.ending_shop or context.end_of_round) and context.main_eval then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end,
    }
end