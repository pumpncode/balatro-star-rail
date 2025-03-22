--Be alerted: This is my FIRST mod. I actually planned this to be more of a practice project, but it seems everyone is now expecting for it to be released so here comes nothing.

BalatroSR = SMODS.current_mod
SMODS.current_mod.optional_features = { retrigger_joker = true }

local allFolders = {
    "none", "code"
} --Detects in order, going from left to right.

local allFiles = {
    --["none"] = {"animatedSprite"},
    ["none"] = {},
    ["code"] = {"bepis_shenanigans", "stickers", "jokers", "warptickets", "blinds", "relics", "booster", "keybinds"},
} --Same goes with this.

local joker_to_main_mode = 2 
--Mode 1: Normal mode, add Joker to the Joker area, which will be consumed after shop.
--Mode 2: Experimental mode, Joker in Joker area immediately consumes added jokers if possible for Eidolon. 

local hsrText = { --The core of EVERYTHING.
    RelicSetEffects = {
        ["2pcs"] = {
            ["musketeer"] = "{s:0.7}Increases wearer's {}{C:attention,s:0.7}Attack {}{s:0.7}by #2#%{}",
            ["thief"] = "{s:0.7}If wearer originally gives Chips during main scoring, {}{C:mult,s:0.7}+#3#{}{s:0.7} Mult{}",
            ["passerby"] = "{s:0.7}If wearer originally doesn't give Chips or Mult during main scoring, {}{X:chips,C:white,s:0.7}X#2#{s:0.7} Chips{}",
            ["eagle"] = "{s:0.7}Increases wearer's {}{C:attention,s:0.7}Wind Efficiency {}{s:0.7}by #2#%{}",
        },
        ["4pcs"] = {
            ["musketeer"] = "{s:0.7}Increases{}{C:attention,s:0.7} Base Effect Efficiency {}{s:0.7}by #3#%{}",
            ["thief"] = "{s:0.7}If wearer originally gives chips and gives more than (or equal) 200 Chips during main scoring, {}{X:chips,C:white,s:0.7}X#4#{}{s:0.7} Chips{}",
            ["passerby"] = "{s:0.7}If wearer's type is {}{C:attention,s:0.7}Abundance{}{s:0.7}, retrigger themselves{}",
            ["eagle"] = "{s:0.7}If wearer has an {}{C:attention,s:0.7}Ultimate{}{s:0.7}, increases Cooldown Regeneration by #3#{}",
        },
        ["config"] = {
            ["musketeer"] = {
                ["Name"] = "Musketeer of Wild Wheat",
                ["Effect"] = '+8 Mult',
                baseMult = 8,
                twopcsBonus = 12,
                fourpcsBonus = 10,
            },
            ["thief"] = {
                ["Name"] = "Thief of Shooting Meteor",
                ["Effect"] = 'If wearer gives Chips during main scoring, +25 Chips. Otherwise, +5 Mult',
                baseChips = 25,
                baseMult = 5,
                twopcsBonus = 15,
                fourpcsBonus = 1.5,
            },
            ["passerby"] = {
                ["Name"] = "Passerby of Wandering Cloud",
                ["Effect"] = "+5 Chips",
                baseChips = 5,
                twopcsBonus = 1.2,
            },
            ["eagle"] = {
                ["Name"] = "Eagle of Twilight Line",
                ["Effect"] = '+10 Chips',
                baseChips = 10,
                twopcsBonus = 10,
                fourpcsBonus = 1,
            }
        },
    },
    CardStats = {
        --Debuffs which Playing Cards can have.
        ElementReductionStats = { 
            "Ice_res_pen",
            "Fire_res_pen",
            "Wind_res_pen",
            "Lightning_res_pen",
            "Quantum_res_pen",
            "Imaginary_res_pen",
            "Physical_res_pen",
            "all_type_res_pen",
        },
        Debuffs = {
            "def_reduction",
            "dmg_taken",
            "dotMulti",
        },
        DoT = {
            "kafka_shock_dot",
            "sampo_wind_shear_dot",
        },
        --Stats of HSR Jokers.
        CharacterStats = {
            "bee", --Basic Effect Efficiency.
            "atkMulti",
            "elementMulti",
        },
        CharacterDebuffs = { --[[All values here are automatically read by inflict_debuff (check jokers.lua):
        - max_stack: Stackable debuff. If not declared, it will be seen as a boolean debuff. (aka set to true when inflicted.)
        - text: Add text to playing cards if this is declared.
        - (debuff_name): Declare any debuff names in ElementReductionStats and Debuffs, and it will increase that value.
        - related_debuffs: For some purposes.
        - adv_related_debuffs: Advanced related_debuffs:
            EX: {
                ["shock_dot"] = { --Declares debuff's name.
                    ["min_stack"] = 1 --Declares how many stacks the debuff needs.
                }
            }
        - other_name: Debuff's name is also counted as those names.
        - priority: If declared, check all debuffs in related_debuffs, and overwrites them with this debuff if priority is higher.
        - priority:
            + If set to 0: Doesn't inflict debuff until all debuffs in related_debuffs aren't found.
            + If set to 1: Only inflict if debuffs in related_debuffs are all found.
            + if set to 2: Like priority 1, but if false, then inflict all debuffs from related_debuffs. If true, inflicts the aforementioned debuff, and clears all debuffs from related_debuffs
        - priority_block: If set to true, and current card has this debuff - all debuffs from related_debuffs can't be inflicted.
        - priority_clear: If set to true, clears all debuffs in related_debuffs when this debuff exists.
        - duration: If not declared, this debuff has inf duration.
        - keep_duration_on_inflict: If declared true, duration won't be reset when debuff is inflicted again.
        EX: dotMulti = 30 => Through calculation, dotMulti will be x(1 + 0.3).
        ]]
            Kafka = {
                ["kafka_dot"] = {
                    max_stack = 1,
                    related_debuffs = {"shock_dot"},
                    other_name = {"shock_dot"},
                    priority = 2,
                    priority_block = true,
                    priority_clear = true,
                    text = "Amplified Shock"
                },
                ["kafka_da_capo"] = {
                    dotMulti = 30,
                },
                ["kafka_e3"] = {
                    dotMulti = 30,
                },
                ["kafka_e6"] = {
                    dotMulti = 100,
                },
            },
            Sampo = {
                ["sampo_wind_shear_dot"] = {
                    max_stack = 5,
                    other_name = {"wind_shear_dot"},
                    related_debuffs = {"wind_shear_dot"},
                    priority_block = true,
                    priority_clear = true,
                    text = "Wind Shear",
                },
                ["sampo_e6"] = {
                    dotMulti = 15,
                },
            },
            Pela = {
                ["pela_exposed1"] = {
                    def_reduction = 20,
                },
                ["pela_exposed3"] = {
                    def_reduction = 30,
                },
                ["pela_exposed5"] = {
                    def_reduction = 40,
                },
                ["pela_exposed6"] = {
                    def_reduction = 45,
                },
                ["pela_e4"] = {
                    Ice_res_pen = 12,
                },
            },
            Asta = {
                ["asta_burn_dot"] = {
                    max_stack = 5,
                    text = "Asta DOT"
                }
            },
            Welt = {
                ["welt_debuff"] = {
                    dmg_taken = 12,
                },
                ["welt_debuffe4"] = {
                    dmg_taken = 25,
                },
            },
            Clara = {
                ["clara_mark"] = {
                    text = "Marked by Clara"
                },
            },
            Seele = {
                ["seele_butterfly_flurry"] = {
                    text = "Butterfly Flurry",
                    dmg_taken = 50,
                },
            },
            JingYuan = {
                ["jy_e6"] = {
                    max_stack = 3,
                    dmg_taken = 12,
                },
            },
            Serval = {
                ["serval_e4"] = {
                    def_reduction = 10,
                },
            },
            Other = {
                ["shock_dot"] = {
                    max_stack = 1,
                    mult = 20,
                    text = "Shock"
                },
                ["wind_shear_dot"] = {
                    max_stack = 5,
                    chip = 20,
                    text = "Wind Shear",
                },
                ["burn_dot"] = {
                    max_stack = 5,
                    mult = 5,
                    text = "Burn"
                }
            },
        },
        CharacterBuffs = {--[[All values here are automatically read by buffJoker (check jokers.lua):
        - duration: After each joker_main trigger, reduces by 1. If duration is below (or equal) 0, the buff is removed. If not declared, duration is seen as 1.
        - max_stack: If declared, buff will scale on stacks.
        - permBuff: If declared and is true, buff lasts forever unless it is manually removed. If not declared, permBuff is seen as false.
        - remain_end_of_round: If declared and is true, buff remains at the end of round. If not declared, remain_end_of_round is seen as false.
        - mult: If declared, give mult at end of hand.
        - chip: Similarly, but for chips.
        - xMult: Similarly, but for xmult.
        - xChip: Similarly, but for xchip.
        - bee: Increase Joker's stat by that amount.
        - atkMulti: Increase Joker's stat by that amount.
        - elementMulti: Increase Joker's stat by that amount.
        - speed: Increase Joker's stat by that amount.
        - cooldownRegenBonus: :3 (Due to how priorities work, if you want this to work, you will have to increase duration by 1 more than it should be. For example, if you want it to last for 1 turn then put the duration to 2.)
        ]]
            Yanqing = {
                ["yanqing_soulsteel_sync"] = {
                    permBuff = true,
                },
                ["yanqing_soulsteel_synce2"] = {
                    permBuff = true,
                    speed = 20,
                },
                ["yanqing_soulsteel_synce4"] = {
                    permBuff = true,
                    elementMulti = 1.12,
                },
                ["yanqing_soulsteel_synce6"] = {
                    permBuff = true,
                    atkMulti = 1.2,
                },
                ["yanqing_e5"] = {
                    permBuff = true,
                    xChip = 1.5,
                },
            },
            Arlan = {
                ["arlan_passive0"] = {
                    permBuff = true,
                    max_stack = 5,
                    bee = 1.2,
                },
                ["arlan_passive6"] = {
                    permBuff = true,
                    max_stack = 10,
                    bee = 1.3,
                },
                ["arlan_xmult"] = {
                    permBuff = true,
                    xMult = 1.02,
                }
            },
            Natasha = {
                ["natasha_e2_temp"] = {
                    duration = 1,
                    xChip = 1.5,
                },
            },
            Tingyun = {
                ["tingyun_benediction0"] = {
                    duration = 3,
                    bee = 1.5,
                    atkMulti = 1.5,
                },
                ["tingyun_benediction1"] = {
                    duration = 3,
                    bee = 1.5,
                    atkMulti = 1.5,
                    mult = 15,
                },
                ["tingyun_benediction2"] = {
                    duration = 3,
                    bee = 1.5,
                    atkMulti = 1.5,
                    mult = 15,
                    cooldownRegenBonus = 1,
                },
                ["tingyun_e3"] = {
                    remain_end_of_round = true,
                    bee = 1.5,
                },
                ["tingyun_benediction4"] = {
                    duration = 3,
                    bee = 1.5,
                    atkMulti = 1.7,
                    mult = 15,
                    cooldownRegenBonus = 1,
                },
                ["tingyun_benediction5"] = {
                    duration = 3,
                    bee = 1.7,
                    atkMulti = 1.7,
                    mult = 15,
                    cooldownRegenBonus = 1,
                },
                ["tingyun_benediction6"] = {
                    duration = 3,
                    bee = 1.7,
                    atkMulti = 1.7,
                    mult = 15,
                    xMult = 1.5,
                    cooldownRegenBonus = 1,
                },
            },
            Asta = {
                ["asta_astrometry"] = {
                    duration = 3,
                    max_stack = 4,
                    mult = 5,
                    atkMulti = 1.05,
                },
                ["asta_astral_blessing"] = {
                    duration = 3,
                    speed = 50,
                },  
            },
            M7 = {
                ["M7_e2"] = {
                    bee = 1.2,
                },
                ["M7_e4"] = {
                    xMult = 1.5,
                },
            },
            DanHeng = {
                ["danheng_passive2"] = {
                    permBuff = true
                },
                ["danheng_e4"] = {
                    duration = 1,
                    elementMulti = 1.36,
                },
                ["danheng_e1"] = {
                    permBuff = true,
                    atkMulti = 1.12,
                },
                ["danheng_e6"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    speed = 25,
                }
            },
            Welt = {
                ["welt_e1"] = {
                    duration = 1,
                    bee = 1.5,
                }
            },
            Himeko = {
                ["himeko_fua"] = {
                    permBuff = true,
                },
                ["himeko_e5"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    atkMulti = 1.5,
                },
                ["himeko_e1"] = {
                    duration = 2,
                    speed = 20,
                },
                ["himeko_e2"] = {
                    permBuff = true,
                    atkMulti = 1.15,
                },
            },
            Bailu = {
                ["bailu_e1"] = {
                    duration = 2,
                    cooldownRegenBonus = 1,
                },
                ["bailu_e2"] = {
                    duration = 2,
                    bee = 1.15,
                },
                ["bailu_e4"] = {
                    duration = 2,
                    max_stack = 3,
                    atkMulti = 1.1,
                },
            },
            Clara = {
                ["clara_e2"] = {
                    duration = 2,
                    bee = 1.3,
                },
            },
            Seele = {
                ["seele_e2"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    speed = 25,
                },
                ["seele_e3"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    atkMulti = 1.1,
                },
                ["seele_e1"] = {
                    permBuff = true,
                    atkMulti = 1.15,
                },
                ["seele_e5"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    speed = 50,
                },
            },
            JingYuan = {
                ["jy_e2"] = {
                    duration = 1,
                    bee = 1.2,
                },
                ["jy_e4"] = {
                    permBuff = true,
                    max_stack = 10,
                    atkMulti = 1.02,
                },
                ["jy_e5"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    atkMulti = 1.15,
                },
            },
            Herta = {
                ["herta_e2"] = {
                    permBuff = true,
                    atkMulti = 1.04,
                    max_stack = 10,
                },
                ["herta_e3"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    atkMulti = 1.10,
                },
                ["herta_e5"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    atkMulti = 1.10,
                },
            },
            Qingque = {
                ["qingque_e2"] = {
                    permBuff = true,
                    max_stack = 4,
                    atkMulti = 1.05,
                },
                ["qingque_e3"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    atkMulti = 1.05,
                },
                ["qingque_e5"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    atkMulti = 1.07,
                },
            },
            Serval = {
                ["serval_e2"] = {
                    permBuff = true,
                    max_stack = 5,
                    atkMulti = 1.05,
                },
                ["serval_e3"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    atkMulti = 1.05,
                },
                ["serval_e5"] = {
                    permBuff = true,
                    remain_end_of_round = true,
                    atkMulti = 1.07,
                },
            },
            Others = {

            },
        },
        config = { --[[All values here are automatically read by HSRJokerMain (check jokers.lua):
        - mult: If declared, give mult at end of hand. Some Relic effects will consider this as a Joker which originally gives mult at end of hand.
        - chip: Similarly, but for chips.
        - xMult: Similarly, but for xmult.
        - xChip: Similarly, but for xchip.
        - noGains: Stops the Joker from being able to gain Mult/Chips/XMult/XChips from Relics and Buffs.
        - gainEfficiency: Increases/decreases all gains by a multiplier.
        - handUsage: If declared, when a Hand is played, consume that amount more Hands. Used for Jokers such as Arlan.
        - hand: If declared, when Joker is added, increases Hand by that amount.
        - discard: If declared, when Joker is added, increases Discard by that amount.
        (While we are here, I will explain how those two work: Whenever a Joker adds a hand or a discard, it is saved to:
        card.ability["given_hand"] | card.ability["given_discard"]

        on Joker removal, it basically checks those and remove by that repsective amount.

        As for how "e1hand" works, for example, check HSRContextHandler.
        )
        - Additionally, if you want a HSR Joker to have those but only at certain Eidolons, add "e"..(required eidolon).."mult/chip/xMult/xChip".
        EX:
        "e1mult" = 50 => At >= Eidolon 1, give 50 mult at end of hand,
        ]]
            Yanqing = {
                type = "The Hunt",
                element = "Ice",
            },
            Trash = {
                type = "Destruction",
                element = "Physical",
                money = 1,
            },
            Arlan = {
                type = "Destruction",
                element = "Lightning",
                handUsage = 1,
                mult = 25,
                e2chip = 10,
                e3mult = 25,
                e5chip = 10,
                e5mult = 10,
            },
            Bronya = {
                type = "Harmony",
                element = "Wind",
                xMult = 1.5,
            },
            Kafka = {
                type = "Nihility",
                element = "Lightning",
                isNegative = false,
                shockMult = 5,
                e4Buff = 1.5,
                e5Buff = 50,
                ultCooldown = 0,
                ultRequiredCooldown = 15,
            },
            Sampo = {
                type = "Nihility",
                element = "Wind",
                windShearMaxStacks = 5,
                windShearChips = 20,
                e3Buff = 30,
                e4Buff = 30,
                e5Buff = 2,
                e6Buff = 15,
            },
            Pela = {
                type = "Nihility",
                element = "Ice",
                mult = 15,
                e2mult = 15,
                ultCooldown = 0,
                discardedCards = 0,
                ultRequiredCooldown = 2,
            },
            Natasha = {
                type = "Abundance",
                element = "Physical",
                hand = 1,
                e3hand = 1,
                e5discard = 1,
                ultCooldown = 0,
                ultRequiredCooldown = 15,
                e2Gain = 1.5,
            },
            Tingyun = {
                type = "Harmony",
                element = "Lightning",
                bee = 1.5,
                atkMulti = 1.5,
            },
            Asta = {
                type = "Harmony",
                element = "Fire",
                atkMulti = 1.05,
                multBuff = 5,
                burnMult = 5,
                astrometryStack = 0,
                ultCooldown1 = 0,
                ultRequiredCooldown1 = 3,
                ultCooldown2 = 0,
                ultRequiredCooldown2 = 1,
            },
            M7 = {
                type = "Preservation",
                element = "Ice",
                ultCooldown = 0,
                ultRequiredCooldown = 3,
                chip = 20,
                e1mult = 5,
                e3chip = 30,
            },
            DanHeng = {
                type = "The Hunt",
                element = "Wind",
            },
            Welt = {
                type = "Nihility",
                element = "Imaginary",
                chip = 0,
                xChip = 1,
            },
            Himeko = {
                type = "Erudition",
                element = "Fire",
            },
            Bailu = {
                type = "Abundance",
                element = "Lightning",
                gainEfficiency = 0.5,
                ultCooldown1 = 0,
                ultRequiredCooldown1 = 3,
                ultCooldown2 = 0,
                ultRequiredCooldown2 = 2,
                hand = 1,
                discard = 1,
                e3xMult = 2.5,
                e5xChip = 2.5,
            },
            Clara = {
                type = "Destruction",
                element = "Physical",
                gainEfficiency = 2,
                mult = 0,
                xMult = 1,
                e3chip = 25,
                e5chip = 25,
            },
            Qingque = {
                type = "Erudition",
                element = "Quantum",
                tile = 0,
            },
            Seele = {
                type = "The Hunt",
                element = "Quantum",
                speed = 125,
                repeatSuit = "Spades",
                chosenRank = 2,
            },
            JingYuan = {
                type = "Erudition",
                element = "Lightning",
                checkedSuits = {},
                hpa = 0,
            },
            Herta = {
                type = "Erudition",
                element = "Ice",
            },
            Sushang = {
                type = "The Hunt",
                element = "Physical",
            },
            Serval = {
                type = "Erudition",
                element = "Lightning",
                shockChance = 3,
                ultCooldown = 0,
                ultRequiredCooldown = 10,
            },
            Hook = {
                type = "Destruction",
                element = "Fire",
                mult = 0,
            },
            Gepard = {
                type = "Preservation",
                element = "Ice",
            },
        }
    },
}

local absoluteNecessary = { --Every HSR Joker should have this. Now, I know I COULD organize everything better, but it's too late for me to go back.
    currentEidolon = 0, --Handling HSR Joker's Eidolons.
    --Relics Stuff.
    head = nil,
    headName = "None",
    body = nil,
    bodyName = "None",
    hands = nil,
    handsName = "None",
    feet = nil,
    feetName = "None",
    headEffect = "",
    bodyEffect = "",
    handsEffect = "",
    feetEffect = "",
    twppcssetEffect = "None",
    fourpcssetEffect = "None",
    --Planar Ornaments, currently not doing anything yet.
    orbName = "None",
    orb = nil,
    orbEffect = "",
    ropeName = "None",
    rope = nil,
    ropeEffect = "",
    planarsetEffect = "None",
    --Description Pages.
    page = 1,
    max_page = 4,
    --Stats.
    self_retriggers = 0, --Resets to 0 after retriggering.
    excess_action_value = 0, --Each 100 Excess Action Value = 1 Self Retrigger.
    speed = 100, --Each Speed point above 100 = 1 Excess Action Value every hand.
    j_atk = 0, --j_atk = 10 -> 10% ATK Buff. This is only for visualization.
    j_bee = 0, --j_bee = 10 -> 10% Basic Effect Efficiency. This is only for visualization.
    j_elementMulti = 0, --j_elementMulti = 10 -> 10% Element Multiplier. This is only for visualization.
    otherStats = "None", --Visualizing other unmentioned Stats.
    --Other unmentioned vars.
} 

SMODS.ObjectType {key = 'relics'}

--SMODS.current_mod_path.."/"

--[[ Some important variables that my mod uses:

- G.GAME.NormalPity <-- If you played HSR or basically any gacha game, you know what this does. This Pity is only used for Normal Tickets.
- G.GAME.SpecialPity <-- If you played HSR or basically any gacha game, you know what this does. This Pity is only used for Special Tickets.
- G.GAME.FiftyPity <-- The same goes with this.
- G.GAME.FourStarsFiftyPity <-- Just read the name.
- G.GAME.

]]
--Variables for Gacha.
local debug, debugMode = false, 2
local MaxPity = 90
local SoftPityDistance = 20
local PercentagePerSoftPity = 20 --Take the number and divide it by 10, and you will have the percentage.
local Base5StarsChance = 6 --0.6%.
local Base4StarsChance = 51 -- 5.1%
local CharList = { --All characters available from Gacha.
    [3] = {
        "Trash"
    },
    [4] = {
        "Arlan", "Pela", "Sampo", "Tingyun", "Asta", "Natasha", "Qingque", "DanHeng", "M7", "Hook"
    },
    [5] = {
        ["Limited"] = {
            "Kafka", "Seele", "JingYuan"
        },
        ["Standard"] = {
            "Yanqing", --lowkey fucked :speaking_head:
            "Bronya",
            "Welt",
            "Himeko",
            "Bailu"
        }
    },
}
local BannerList = { --All banners.
    [1] = {
        Name = "Butterfly on Swordtip",
        FiveStars = "Seele",
        FourStars = {"Pela", "Natasha", "DanHeng"}
    },
    [2] = {
        Name = "Swirl of Heavenly Spear",
        FiveStars = "JingYuan",
        FourStars = {"Tingyun", "Qingque", "M7"}
    },
    [3] = {
        Name = "Nessun Dorma (EARLY)",
        FiveStars = "Kafka",
        FourStars = {"Serval", "Sampo", "Pela"}
    },
}

function returnHsrBanners() --Returning HSR Banners as a table.
    return BannerList
end
--Functions related to Gacha.

function debugCheck(randomRNG, softPity, Pity) --RNG Check for 3-Star, 4-Star, and 5-Star.
    local three,four,five = 0,0,0
    if (randomRNG <= (Base5StarsChance + (softPity * PercentagePerSoftPity))/1000) or (Pity >= MaxPity) then
        five = five + 1
    elseif randomRNG <= Base4StarsChance/1000 or Pity % 10 == 0 then
        four = four + 1
    else
        three = three + 1
    end
    return three,four,five
end

function gacha_load_card(cardName) --Load Joker to Gacha Results.
    local newcard = SMODS.create_card({set = 'Joker', area = BalatroSR.hsr_gacha_results_area, skip_materialize = true, key = "j_hsr_"..cardName})
    BalatroSR.add_to_gacha_results(newcard)
end

function gacha_clear_results() --Clear Gacha Results.
    for i,v in ipairs(G.hsr_gacha_results_area.cards) do
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                v.T.r = -0.2
                v:juice_up(0.3, 0.4)
                v.states.drag.is = true
                v.children.center.pinch.x = true
                if v.edition and v.edition.card_limit then
                    BalatroSR.hsr_gacha_results_area.config.card_limit = BalatroSR.hsr_gacha_results_area.config.card_limit - v.edition.card_limit
                end
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                    func = function()
                            G.hsr_gacha_results_area:remove_card(v)
                            v:remove()
                            v = nil
                        return true; end})) 
                return true
            end
        })) 
    end
end

BalatroSR.add_to_gacha_results = function(card, args)
    BalatroSR.hsr_gacha_results_area:emplace(card)
end

BalatroSR.hsr_gacha_roll = function(card) --Gacha Roll for Normal Warp Tickets and Special Warp Tickets.
    if not BalatroSR.hsr_gacha_results_open then --Open Gacha Results if it's closed... I mean, why wouldn't it be opened?
        BalatroSR.open_gacha_results(true, true)
    end
    if card.config.center.key == "c_hsr_starrailspecialpass" then
        local three,four,five = 0,0,0

        for i = 1, card.ability.extra.roll do --RNG Check.
            local softPity = 0
            
            G.GAME.SpecialPity = (G.GAME.SpecialPity or 0) + 1
            if G.GAME.SpecialPity >= (MaxPity - SoftPityDistance) then
                softPity = MaxPity - G.GAME.SpecialPity
            end
    
            local randomRNG = pseudorandom("hsr_special_warp")
            local a,b,c = debugCheck(randomRNG, softPity, G.GAME.SpecialPity)
            three = three + a
            four = four + b
            five = five + c
    
            --Base5StarsChance is 6
            --The softPity part is usually at 0, so it can just be ignored.
            if (randomRNG <= (Base5StarsChance + (softPity * PercentagePerSoftPity))/1000) or (G.GAME.SpecialPity >= MaxPity) then --0.6% for a 5 stars
               G.GAME.SpecialPity = 0
            end 
        end
    
        if debug and debugMode == 2 then
            local softPity = 0
            if G.GAME.SpecialPity >= (MaxPity - SoftPityDistance) then
                softPity = MaxPity - G.GAME.SpecialPity
            end
            print("3 Stars: "..three)
            print("4 Stars: "..four)
            print("5 Stars: "..five)
            print("5 Stars Chance: "..((Base5StarsChance + (softPity * PercentagePerSoftPity))/10).."%")
            print("Current Pity: "..G.GAME.SpecialPity)
            print("----------")
        end
        --Adding the cards inside gacha_results card area.
        gacha_clear_results()
        for i = 1, three do
            gacha_load_card("Trash")
        end
    
        for i = 1,four do
            if not G.GAME.FourStarsFiftyPity then G.GAME.FourStarsFiftyPity = false end
            if G.GAME.FourStarsFiftyPity then
                G.GAME.FourStarsFiftyPity = false
                local randomChar = pseudorandom_element(BannerList[card.ability.extra.selected_banner]["FourStars"])
                if randomChar then
                    gacha_load_card(randomChar)
                end
            else
                local TheWheelOfLessDoom = pseudorandom("hsr_fourstarsfiftyfifty")
                if TheWheelOfLessDoom <= 1/2 then --eh, could be worse
                    G.GAME.FourStarsFiftyPity = true
                    local randomChar = pseudorandom_element(CharList[4])
                    if randomChar then
                        gacha_load_card(randomChar)
                    end 
                else --gg
                    local randomChar = pseudorandom_element(BannerList[card.ability.extra.selected_banner]["FourStars"])
                    if randomChar then
                        gacha_load_card(randomChar)
                    end
                end
            end
        end
    
        for i = 1, five do
            if not G.GAME.FiftyPity then G.GAME.FiftyPity = false end
            if G.GAME.FiftyPity then
                G.GAME.FiftyPity = false
                local randomChar = card.ability.extra.featured5
                if randomChar then
                    gacha_load_card(randomChar)
                end
            else
                local TheWheelOfDoom = pseudorandom("hsr_fiftyfifty")
                if TheWheelOfDoom <= 1/2 then  --rest in peace :sob:
                    G.GAME.FiftyPity = true
                    local randomChar = pseudorandom_element(CharList[5]["Standard"])
                    if randomChar then
                        gacha_load_card(randomChar)
                    end
                else --Yipee, you won!
                    local randomChar = card.ability.extra.featured5
                    if randomChar then
                        gacha_load_card(randomChar)
                    end
                end
            end
        end

    else
        local three,four,five = 0,0,0

        for i = 1, card.ability.extra.roll do
            local softPity = 0
            
            G.GAME.NormalPity = (G.GAME.NormalPity or 0) + 1
            if G.GAME.NormalPity >= (MaxPity - SoftPityDistance) then
                softPity = MaxPity - G.GAME.NormalPity
            end

            local randomRNG = pseudorandom("hsr_normal_warp")
            local a,b,c = debugCheck(randomRNG, softPity, G.GAME.NormalPity)
            three = three + a
            four = four + b
            five = five + c

            if (randomRNG <= (Base5StarsChance + (softPity * PercentagePerSoftPity))/1000) or (G.GAME.NormalPity >= MaxPity) then --0.6% for a 5 stars
               G.GAME.NormalPity = 0
            end 
        end

        if debug and debugMode == 2 then
            local softPity = 0
            if G.GAME.NormalPity >= (MaxPity - SoftPityDistance) then
                softPity = MaxPity - G.GAME.NormalPity
            end
            print("3 Stars: "..three)
            print("4 Stars: "..four)
            print("5 Stars: "..five)
            print("5 Stars Chance: "..((Base5StarsChance + (softPity * PercentagePerSoftPity))/10).."%")
            print("Current Pity: "..G.GAME.NormalPity)
            print("----------")
        end
    
        --Adding the cards inside gacha_results card area.
        gacha_clear_results()
        for i = 1, three do
            gacha_load_card("Trash")
        end
    
        for i = 1,four do
            local randomChar = pseudorandom_element(CharList[4])
            if randomChar then
                gacha_load_card(randomChar)
            end
        end
    
        for i = 1, five do
            local randomChar = pseudorandom_element(CharList[5]["Standard"])
            if randomChar then
                gacha_load_card(randomChar)
            end
        end

    end
end
--
BalatroSR.save_config = function(self) --Saving configs.
    SMODS.save_mod_config(self)
    G.hsr_keybind_settings = {}
    for k, v in pairs(self.config.keybinds) do G.hsr_keybind_settings[v] = k end
end

BalatroSR.hsr_to_joker = function(j) --Add Joker from Gacha Results to Joker Area
    local card = j
    local exists = false
    for i,v in pairs(G.hsr_gacha_results_area.cards) do
        if v == card then
            exists = true
            break
        end
    end
    if not exists then return end
    if #G.jokers.cards >= G.jokers.config.card_limit and joker_to_main_mode == 1 then return end
    
    local og_edition = nil
    if card:get_edition() and card.edition.key then
        og_edition = card.edition.key
    end

    local cardName = string.gsub(card.ability.name,string.sub(card.ability.name,1,6),"")

    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true

            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                func = function()
                        G.hsr_gacha_results_area:remove_card(card)
                        card:remove()
                        card = nil
                    return true; end})) 
            return true
        end
    })) 

    if joker_to_main_mode == 1 then
        local dup = SMODS.create_card({set = 'Joker', area = BalatroSR.hsr_gacha_results_area, skip_materialize = true, key = "j_hsr_"..cardName, no_edition = true})
        dup:add_to_deck()
        G.jokers:emplace(dup)
        if og_edition then
            dup:set_edition(og_edition,true)
        end
    elseif joker_to_main_mode == 2 then
        local existingJoker = nil
        for _,v in ipairs(G.jokers.cards) do
            if v.config.center.key == card.config.center.key then
                existingJoker = v
                break
            end
        end

        if existingJoker and existingJoker.ability.extra.currentEidolon < 6 then
            existingJoker.ability.extra.currentEidolon = existingJoker.ability.extra.currentEidolon + 1

            if og_edition and not existingJoker:get_edition() then
                existingJoker:set_edition(og_edition,true)
            end
        else
            local dup = SMODS.create_card({set = 'Joker', area = BalatroSR.hsr_gacha_results_area, skip_materialize = true, key = "j_hsr_"..cardName, no_edition = true})
            dup:add_to_deck()
            G.jokers:emplace(dup)
            if og_edition then
                dup:set_edition(og_edition,true)
            end
        end
    end
end

--Game related code.

BalatroSR.calculateRelics = function(extraStuff, additionalConditions, element, card) --Calculate stats which Relics give.
    local RelicSetEffects = hsrText["RelicSetEffects"]
    local extraMult = 0
    local extraChips = 0
    local extraxMult = 1
    local extraxChip = 1
    local extraeav = 0
    local extraspeed = 0
    local bee = 1
    local atkMulti = 1
    local elementMulti = 1
 
    local alike = {
       musketeer = 0,
       thief = 0,
       passerby = 0,
       eagle = 0,
    } --...remind me to add ALL relic keys here.
 
    local specificConditions = {
       --["thief_compat"] = false, (went unused, since I added some code to automatically handle this.)
    } --Some relics have certain conditions to be met before their effects proc, hence, this table.
 
    if additionalConditions and type(additionalConditions) == "table" then
       for i,v in pairs(additionalConditions) do
          specificConditions[i] = v
       end
    end
 
    local bodyParts = {
       "head", "body", "hands", "feet"
    } --freaky ahh table name :sob:
 
    local jokerGains = {}
    local eidolonGains = {}
 
    local stuffToCheck = {"mult","chip","xMult","xChip"}
    local maxEidolons = 6 --honestly, do i even need to clarify this?
 
    function checkIfOriginallyGive(a)
       if jokerGains[a] and jokerGains[a] > 0 then
          return true
       else
          return false
       end
    end
 
    if card.ability and card.ability.extra then --Load jokerGains, eidolonGains, which will then all be added to the aforementioned extra variables.
       for _,v in pairs(stuffToCheck) do
          if card.ability.extra[v] then
             jokerGains[v] = card.ability.extra[v]
          end
       end
 
       for i = 1,maxEidolons do
          for _,v in pairs(stuffToCheck) do
             if card.ability.extra["e"..i..v] then
                if eidolonGains[i] then
                   table.insert(eidolonGains[i],{[v] = card.ability.extra["e"..i..v]})
                else
                   eidolonGains[i] = {[v] = card.ability.extra["e"..i..v]}
                end
                eidolonGains[i] = {[v] = card.ability.extra["e"..i..v]}
             end
          end
       end
 
       for i = 1,maxEidolons do
          local specificEidolonGain = eidolonGains[i]
          if specificEidolonGain then
             if card.ability.extra.currentEidolon >= i then
                for d,p in pairs(specificEidolonGain) do
                   jokerGains[d] = (jokerGains[d] or 0) + p
                end
             end
          end
       end
 
       for i,v in pairs(jokerGains) do
          if i == "mult" then
             extraMult = extraMult + v
          elseif i == "chip" then
             extraChips = extraChips + v
          elseif i == "xMult" then
             extraxMult = (extraxMult or 1) * (v - 1)
          elseif i == "xChip" then
             extraxChip = (extraxChip or 1) + (v - 1)
          end
       end
    end
 
    function setBonus(setName)
       local set = RelicSetEffects["config"][setName]
       if setName == "musketeer" or (setName == "thief" and not checkIfOriginallyGive("chip")) then
          extraMult = extraMult + set["baseMult"]
       elseif setName == "eagle" or setName == "passerby" then
          extraChips = extraChips + set["baseChips"]
       elseif setName == "thief" and checkIfOriginallyGive("chip") then
          extraChips = extraChips + set["baseChips"]
       end
 
       alike[setName] = alike[setName] + 1
    end
 
    for i,v in pairs(bodyParts) do
       if extraStuff[v] then
          local selected = extraStuff[v]
          setBonus(selected)
       end
    end
 
    for i,v in pairs(alike) do
       local set = RelicSetEffects["config"][i]
       if i == "musketeer" then
          if v >= 2 then
             atkMulti = atkMulti + BalatroSR.convertFromPercentage(set["twopcsBonus"])
          end
          if v >= 4 then
             bee = bee + BalatroSR.convertFromPercentage(set["fourpcsBonus"])
          end
       elseif i == "thief" then
          if v >= 2 and checkIfOriginallyGive("chip") then
             extraMult = extraMult + RelicSetEffects["config"]["thief"]["twopcsBonus"]
          end
          if v >= 4 and checkIfOriginallyGive("chip") and extraChips and extraChips >= 200 then
             extraxChip = extraxChip + (RelicSetEffects["config"]["thief"]["fourpcsBonus"] - 1)
          end
       elseif i == "passerby" then
          if v >= 2 and (not checkIfOriginallyGive("chip")) and (not checkIfOriginallyGive("mult")) then
             extraxChip = extraxChip + (RelicSetEffects["config"]["passerby"]["twopcsBonus"] - 1)
          end
          if v >= 4 then
             if card.ability.extra.type == "Abundance" then
                --Remind me to make it so that it retriggers Abundance cards.
             end
          end
       elseif i == "eagle" then
          if v >= 2 and element == "Wind" then
             elementMulti = elementMulti + BalatroSR.convertFromPercentage(set["twopcsBonus"])
          end
       end
    end
 
    return {
       ["extraMult"] = extraMult,
       ["extraChips"] = extraChips,
       ["extraxMult"] = extraxMult,
       ["extraxChip"] = extraxChip,
       ["bee"] = bee,
       ["atkMulti"] = atkMulti,
       ["alike"] = alike,
       ["elementMulti"] = elementMulti,
       ["eav"] = extraeav,
       ["speed"] = extraspeed,
    }
end

BalatroSR.readBuffs = function(card)
    local relicBonus = BalatroSR.calculateRelics(card.ability.extra,nil,card.ability.extra.element,card)
    local ret = {
        ["atkMulti"] = 1 + (relicBonus["atkMulti"] - 1),
        ["bee"] = 1 + (relicBonus["bee"] - 1),
        ["elementMulti"] = 1 + (relicBonus["elementMulti"] - 1),
        ["speed"] = 0 + relicBonus["speed"],
        ["eav"] = 0 + relicBonus["eav"],
        ["cooldownRegenBonus"] = 0,
        ["mult"] = 0 + relicBonus["extraMult"],
        ["chip"] = 0 + relicBonus["extraChips"],
        ["xMult"] = 1 + (relicBonus["extraxMult"] - 1),
        ["xChip"] = 1 + (relicBonus["extraxChip"] - 1),
        ["alike"] = relicBonus["alike"]
    }

    local allBuffs = hsrText["CardStats"]["CharacterBuffs"]
    local cardAbility = card.ability

    for _,character in pairs(allBuffs) do --Load buffs.
        for buffName, buff in pairs(character) do
            if cardAbility[buffName] then
                for spcBuffName, spcBuff in pairs(buff) do --Add buff's effects accordingly.
                    for stuffName,_ in pairs(ret) do
                        if stuffName == spcBuffName then
                            if stuffName == "atkMulti" or stuffName == "bee" or stuffName == "elementMulti" or stuffName == "xMult" or stuffName == "xChip" then
                                ret[stuffName] = ret[stuffName] + ((spcBuff - 1) * (cardAbility[buffName.."_stack"] or 1))
                            else
                                ret[stuffName] = ret[stuffName] + (spcBuff * (cardAbility[buffName.."_stack"] or 1))
                            end
                        end
                    end                 
                end
            end
        end
    end

    return ret
end

BalatroSR.readDebuffs = function(card)
    local ret = {
        ["def_reduction"] = 0,
        ["dmg_taken"] = 0,   
        ["dotMulti"] = 0,
        ["elements"] = {},
        ["text"] = {}
    }

    for _,char in pairs(hsrText["CardStats"]["CharacterDebuffs"]) do
        for debuffName, debuffVals in pairs(char) do
            if card and card.ability and card.ability[debuffName] then
                for valName, valValue in pairs(debuffVals) do
                    local stack = 1
                    if type(card.ability[debuffName]) == "number" then
                        stack = card.ability[debuffName]
                    end

                    if string.find(valName,"_res_pen") then
                        ret["elements"][valName] = (ret["elements"][valName] or 0) + (valValue/100 * stack)
                    elseif valName == "text" then
                        local supposedText = valValue
                        local needToRemove = false
                        if debuffVals["duration"] then
                            needToRemove = true
                            if supposedText == valValue then
                                supposedText = supposedText.." ("
                            end
                            local currentDuration = (card.ability[debuffName.."_duration"] or "Something went wrong.")
                            supposedText = supposedText..currentDuration.." turn(s) remaining, "
                        end

                        if debuffVals["max_stack"] then
                            needToRemove = true
                            if supposedText == valValue then
                                supposedText = supposedText.." ("
                            end
                            local currentStack = (card.ability[debuffName] or "Something went wrong.")
                            supposedText = supposedText.."Stack: "..currentStack..", "
                        end

                        if needToRemove then
                            supposedText = supposedText:sub(1,#supposedText-2)..")"
                        end

                        ret["text"][#ret["text"]+1] = supposedText
                    elseif ret[valName] then
                        ret[valName] = (ret[valName] or 0) + (valValue/100 * stack)
                    end
                end
            end
        end
    end

    return ret
end

BalatroSR.checkForIdenticalDebuff = function(debuff, check)
    if debuff == check then
        return true
    end

    local a = nil
    for i,v in pairs(hsrText["CardStats"]["CharacterDebuffs"]) do
        for i2, v2 in pairs(v) do
            if i2 == debuff then
                a = v2
            end
        end
    end
    if not a then return end

    if a["other_name"] then
        for _,name in pairs(a["other_name"]) do
            if name == check then
                return true
            end
        end
    end

    return false
end

--Remind me to credit Myst for everything lol
--Remind me to credit N', the ui savior, the ui man, the MAN himself
--REMIND ME TO CREDIT RIV_FALCON FOR THIS, HOLY SHITTTTTTTTTTTTT

---Real shit down here.
---I call +Mult, +Chips, XMult, XChips as "Gains", by the way.

BalatroSR.randomizeTable = function(table)
    if type(table) == "table" then --please dont be dumb
        local howMany = #table
        local ret = {}

        local indexes = {} --For tables with indexes which aren't numbers.

        for i,v in pairs(table) do
            indexes[#indexes+1] = i
        end

        for _ = 1,howMany do
            local randomIndex = pseudorandom_element(indexes)
            if randomIndex then
                ret[randomIndex] = table[randomIndex]        
                
                for i,v in pairs(indexes) do
                    if v == randomIndex then
                        indexes[i] = nil
                    end
                end
            end
        end

        return ret
    end
end

for _,chr in pairs(hsrText["CardStats"]["config"]) do --add absoluteNecessary to all characters' config. If a variable in here was already declared in the config, it will ignore that.
    for index,line in pairs(absoluteNecessary) do
        if not chr[index] then
            chr[index] = line 
        end
    end
end

function returnText(x) --Grab from hsrText, since, well, other files can't access it.
    return hsrText[x]
end

G.FUNCS.hsr_switch_desc = function(e) --Function attached to Switch Desc button of the Jokers.
    local card = e.config.ref_table
    if not card.ability.extra["page"] then card.ability.extra["page"] = 1 end
    card:juice_up(0.1,0.2)
    card.ability.extra["page"] = card.ability.extra["page"] + 1
    if card.ability.extra["max_page"] then
        if card.ability.extra["page"] >= (card.ability.extra["max_page"] + 1) then
            card.ability.extra["page"] = 1
        end
    elseif card.ability.extra["page"] >= 5 then
        card.ability.extra["page"] = 1
    end
end

G.FUNCS.hsr_switch_banner = function(e) --Function attached to Switch Banner button of Warp Tickets.
    local card = e.config.ref_table
    card:juice_up(0.1,0.2)
    if not G.GAME.current_banner then
        G.GAME.current_banner = 1
    end
    G.GAME.current_banner = G.GAME.current_banner + 1
    if (card.ability.extra["max_banner"] and G.GAME.current_banner >= card.ability.extra["max_banner"] + 1) then
        G.GAME.current_banner = 1
    end
end

G.FUNCS.hsr_to_joker = function(e) --Function attached to the To Joker button of Jokers in Gacha Results.
    local card = G.hsr_gacha_results_area.highlighted[1]
    BalatroSR.hsr_to_joker(card)
end

G.FUNCS.hsr_can_gacha = function(e) --Checking whether you can use the Warp Tickets.
    local card = e.config.ref_table
    if G.GAME.dollars >= card.config.center.cost then
        e.config.colour = G.C.UI.BACKGROUND_DARK
        e.config.button = 'hsr_gacha'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.hsr_can_to_joker = function(e) --Checking whether you can add Jokers from Gacha Results to Joker Area.
    local card = e.config.ref_table
    if #G.jokers.cards < G.jokers.config.card_limit then
        e.config.colour = G.C.UI.BACKGROUND_DARK
        e.config.button = 'hsr_to_joker'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.hsr_gacha = function(e) --Function attached to Roll button of the Warp Tickets.
    local card = e.config.ref_table
    ease_dollars(-card.config.center.cost)

    BalatroSR.hsr_gacha_roll(card)
end

BalatroSR.create_sell_and_switch_buttons = function(card, args) --Adding buttons to Cards.
    local args = args or {}
    local sell = nil
    local use = nil
    local banner_switch = nil
    local to_joker = nil
    local buy_ticket = nil

    if args.sell then
        sell = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card' },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('b_sell'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('$'), colour = G.C.WHITE, scale = 0.4, shadow = true } },
                                        { n = G.UIT.T, config = { ref_table = card, ref_value = 'sell_cost_label', colour = G.C.WHITE, scale = 0.55, shadow = true } }
                                    }
                                }
                            }
                        }
                    }
                },
            }
        }
    end

    if args.use then
        use = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = 0, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_DARK or G.C.UI.BACKGROUND_INACTIVE, button = 'hsr_switch_desc' },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('hsr_switch_desc1'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('hsr_switch_desc2'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                }
                            }
                        }
                    }
                },

            }
        }
    end

    if args.to_joker then
        to_joker = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = 0, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_DARK or G.C.UI.BACKGROUND_INACTIVE, button = 'hsr_to_joker', func = 'hsr_can_to_joker'},
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('hsr_to_joker1'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('hsr_to_joker2'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                }
                            }
                        }
                    }
                },

            }
        }
    end

    if args.banner_switch then
        banner_switch = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = 0, hover = true, use_once = true, shadow = true, colour = G.C.RED or G.C.UI.BACKGROUND_INACTIVE, button = 'hsr_switch_banner' },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('hsr_switch_banner1'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('hsr_switch_banner2'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                }
                            }
                        }
                    }
                },

            }
        }
    end

    if args.buy_ticket then
        buy_ticket = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_DARK or G.C.UI.BACKGROUND_INACTIVE, button = 'hsr_gacha', func = 'hsr_can_gacha' },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('hsr_buy'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('$'), colour = G.C.WHITE, scale = 0.4, shadow = true } },
                                        { n = G.UIT.T, config = { ref_table = card, ref_value = 'cost', colour = G.C.WHITE, scale = 0.55, shadow = true } }
                                    }
                                }
                            }
                        }
                    }
                },
            }
        }
    end

    return {
        n = G.UIT.ROOT,
        config = {
            align = "cr",
            padding = 0,
            colour = G.C.CLEAR
        },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.15, align = 'cl' },
                nodes = {
                    sell and {
                        n = G.UIT.R,
                        config = { align = 'cl' },
                        nodes = { sell }
                    } or nil,
                    use and {
                        n = G.UIT.R,
                        config = { align = 'cl' },
                        nodes = { use }
                    } or nil,
                    banner_switch and {
                        n = G.UIT.R,
                        config = { align = 'cl' },
                        nodes = { banner_switch }
                    } or nil,
                    to_joker and {
                        n = G.UIT.R,
                        config = { align = 'cl' },
                        nodes = { to_joker }
                    } or nil,
                    buy_ticket and {
                        n = G.UIT.R,
                        config = { align = 'cl' },
                        nodes = { buy_ticket }
                    } or nil,
                }
            }
        }
    }
end

local card_highlight_ref = Card.highlight
function Card:highlight(is_highlighted)
    self.highlighted = is_highlighted
    if self.highlighted and string.find(self.config.center.key,"j_hsr_") then
        local inGachaResults = false

        for i,v in ipairs(G.hsr_gacha_results_area.cards) do
            if v == self then
                inGachaResults = true
                break
            end
        end

        if self.children.use_button then
            self.children.use_button:remove()
            self.children.use_button = nil 
        end

        if not inGachaResults then
            self.children.use_button = UIBox {
                definition = BalatroSR.create_sell_and_switch_buttons(self, {sell = true, use = true}),
                config = {
                    align = "cr",
                    offset = { x = -0.4, y = 0 },
                    parent = self
                }
            }
        else
            self.children.use_button = UIBox {
                definition = BalatroSR.create_sell_and_switch_buttons(self, {sell = true, to_joker = true}),
                config = {
                    align = "cr",
                    offset = { x = -0.4, y = 0 },
                    parent = self
                }
            }
        end
    elseif self.highlighted and (string.find(self.config.center.key,"c_hsr_starrailspecialpass") or string.find(self.config.center.key,"c_hsr_starrailpass")) then
        if self.children.use_button then
            self.children.use_button:remove()
            self.children.use_button = nil 
        end

        --[[self.children.use_button = UIBox {
            definition = BalatroSR.create_sell_and_switch_buttons(self, {sell = true, use = false, banner_switch = true}),
            config = {
                align = "cr",
                offset = { x = -0.4, y = 0 },
                parent = self
            }
        }]]

        self.children.use_button = UIBox {
            definition = BalatroSR.create_sell_and_switch_buttons(self, {sell = false, use = false, buy_ticket = true, banner_switch = true}),
            config = {
                align = "cr",
                offset = { x = -0.4, y = 0 },
                parent = self
            }
        }
    else
        card_highlight_ref(self, is_highlighted)
    end
end

for i = 1,#allFolders do
    if allFolders[i] == "none" then
        for i2 = 1,#allFiles[allFolders[i]] do
            assert(SMODS.load_file(allFiles[allFolders[i]][i2]..'.lua'))()
        end
    else
        for i2 = 1,#allFiles[allFolders[i]] do
            assert(SMODS.load_file(allFolders[i].."/"..allFiles[allFolders[i]][i2]..'.lua'))()
        end
    end
end
----UI stuff, kill me please

--Keybind stuff, copied straight from KeyboardController.
local hsr_keybind_options = {
    'hsr_turn_page_left',
    'hsr_turn_page_right',
    'hsr_interact_keybind'
}

function hsr_desc_from_rows(desc_nodes, empty, maxw)
    local t = {}
    for k, v in ipairs(desc_nodes) do
      t[#t+1] = {n=G.UIT.R, config={align = "cm", maxw = maxw}, nodes=v}
    end
    return {n=G.UIT.R, config={align = "cm", colour = empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE, r = 0.1, padding = 0.04, minw = 2, minh = 0.25, emboss = not empty and 0.05 or nil, filler = true}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes=t}
    }}
end

BalatroSR.config_tab = function()
    local loc_options = {}
    for i, v in ipairs(hsr_keybind_options) do loc_options[i] = localize(v, 'hsr_keybinds') end
    BalatroSR.current_keybind = BalatroSR.current_keybind or 'hsr_turn_page_left'
    BalatroSR.current_keybind_val = BalatroSR.config.keybinds[BalatroSR.current_keybind] or ''
    local loc_vars = {scale = 0.7}

    local Node = {}
    localize {type = 'descriptions', key = "hsr_keybind_warning", set = 'dictionary', nodes = Node, vars = loc_vars.vars, scale = loc_vars.scale, text_colour = loc_vars.text_colour, shadow = loc_vars.shadow} 
    Node = hsr_desc_from_rows(Node,true)
    Node.config.colour = loc_vars.background_colour or Node.config.colour

    local Node2 = {}
    localize {type = 'descriptions', key = "hsr_hover_enable_desc", set = 'dictionary', nodes = Node2, vars = loc_vars.vars, scale = loc_vars.scale, text_colour = loc_vars.text_colour, shadow = loc_vars.shadow} 
    Node2 = hsr_desc_from_rows(Node2,true)
    Node2.config.colour = loc_vars.background_colour or Node2.config.colour

    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 5, align = "cm", padding = 0.15, colour = G.C.BLACK}, nodes = {
        create_toggle({label = localize('hsr_keybinds_enable'), ref_table = BalatroSR.config, ref_value = 'enable', callback = function() BalatroSR:save_config() end }),
        {n = G.UIT.R, config = { align = "cm", padding = 0.04 }, nodes = {
            create_text_input({
                w = 4, max_length = 1, prompt_text = BalatroSR.config.keybinds[BalatroSR.current_keybind],
                extended_corpus = true, ref_table = BalatroSR, ref_value = 'current_keybind_val', keyboard_offset = 1,
                callback = function(e)
                    BalatroSR.config.keybinds[BalatroSR.current_keybind] = BalatroSR.current_keybind_val
                    BalatroSR:save_config()
                end
            }),
        }},

        create_option_cycle({
            label = localize('hsr_current_keybind'),
            scale = 0.8,
            w = 4,
            options = loc_options,
            opt_callback = 'hsr_select_keybind',
            current_option = BalatroSR.current_keybind_idx or 1,
        }),

        Node,

        create_toggle({label = localize('hsr_hover_enable'), ref_table = BalatroSR.config, ref_value = 'hover', callback = function() BalatroSR:save_config() end }),

        Node2
    }}
end

function G.FUNCS.hsr_select_keybind(e)
    local hook = G.OVERLAY_MENU:get_UIE_by_ID('text_input').children[1].children[1]
    hook.config.ref_table.callback()
    BalatroSR.current_keybind = hsr_keybind_options[e.to_key]
    BalatroSR.current_keybind_idx = e.to_key
    hook.config.ref_value =  BalatroSR.current_keybind
    G.CONTROLLER.text_input_hook = hook
    G.CONTROLLER.text_input_id = 'text_input'
    for i = 1, 9 do
      G.FUNCS.text_input_key({key = 'right'})
    end
    for i = 1, 9 do
        G.FUNCS.text_input_key({key = 'backspace'})
    end
    local text = BalatroSR.config.keybinds[BalatroSR.current_keybind]
    for i = 1, #text do
      local c = text:sub(i,i)
      G.FUNCS.text_input_key({key = c})
    end
    G.FUNCS.text_input_key({key = 'return'})
    --KBC.current_keybind_val = KBC.config.keybinds[KBC.current_keybind]
    BalatroSR:save_config()
end

BalatroSR.custom_ui = function(modNodes)
    G.joy_desc_area = CardArea(
        G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
        4.25 * G.CARD_W,
        0.95 * G.CARD_H,
        { card_limit = 5, type = 'title', highlight_limit = 0, collection = true }
    )

    G.joy_desc_area.joy_demo_area = true

    for i, key in ipairs({"c_hsr_starrailspecialpass","c_hsr_starrailpass"}) do
        local card = Card(G.joy_desc_area.T.x + G.joy_desc_area.T.w / 2, G.joy_desc_area.T.y,
            G.CARD_W, G.CARD_H, G.P_CARDS.empty,
            G.P_CENTERS[key])
        card.children.back = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["hsr_Jokers"], { x = 0, y = 0 })
        card.children.back.states.hover = card.states.hover
        card.children.back.states.click = card.states.click
        card.children.back.states.drag = card.states.drag
        card.children.back.states.collide.can = false
        card.children.back:set_role({major = card, role_type = 'Glued', draw_major = card})
        G.joy_desc_area:emplace(card)
 
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                --play_sound("card1")
                return true
            end,
        }))
    end

    table.insert(modNodes, {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.07, no_fill = true },
        nodes = {
            { n = G.UIT.O, config = { object = G.joy_desc_area } }
        }
    })

end

BalatroSR.extra_tabs = function()
    return{
        {
            label = "Introduction", --The flood... it is coming...!!
            tab_definition_function = function()
                local introductionNodes = {}
                for index,key in ipairs({"hsr_introduction",{"j_hsr_Trash"},"hsr_introduction1", "hsr_introduction3", "hsr_introduction4", "hsr_introduction5", "hsr_introduction6"}) do
                    if index == 2 then --Planned to add a Trash Joker here, but it looks too crowded, soooo...
                        --[[G.card_room2 = CardArea(
                            G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
                            4.25 * G.CARD_W,
                            0.95 * G.CARD_H,
                            { card_limit = 5, type = 'title', highlight_limit = 0, collection = true }
                        )

                        for i, key in ipairs(key) do
                            local card = Card(G.joy_desc_area.T.x + G.joy_desc_area.T.w / 2, G.joy_desc_area.T.y,
                                G.CARD_W, G.CARD_H, G.P_CARDS.empty,
                                G.P_CENTERS[key])
        
                            G.card_room2:emplace(card)
                        end

                        introductionNodes[#introductionNodes+1] ={
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.07, no_fill = true },
                            nodes = {
                                { n = G.UIT.O, config = { object = G.card_room2 } }
                            }
                        }
                        ]]
                    else
                        introductionNodes[#introductionNodes+1] = {}
                        local loc_vars = {scale = 0.925}
                        localize {type = 'descriptions', key = key, set = 'dictionary', nodes = introductionNodes[#introductionNodes], vars = loc_vars.vars, scale = loc_vars.scale, text_colour = loc_vars.text_colour, shadow = loc_vars.shadow} 
                        introductionNodes[#introductionNodes] = desc_from_rows(introductionNodes[#introductionNodes])
                        introductionNodes[#introductionNodes].config.colour = loc_vars.background_colour or introductionNodes[#introductionNodes].config.colour
                    end
                end

                return
                {n = G.UIT.ROOT, 
                    config = {
                        r = 0.1,
                        minw = 5, 
                        align = "cm", 
                        padding = 0.2, 
                        colour = G.C.BLACK
                    }, 
                    --[[nodes = {
                        {n=G.UIT.R, config={align = "tm", padding = 0.12, emboss = 0.1, colour = G.C.L_BLACK, r = 0.1}, nodes={
                            simple_text_container('hsr_introduction',{colour = G.C.UI.TEXT_LIGHT, scale = 0.3}),
                            },
                        },
                        {n=G.UIT.R, config={align = "tm", padding = 0.12, emboss = 0.1, colour = G.C.L_BLACK, r = 0.1}, nodes={
                            simple_text_container('hsr_introduction1',{colour = G.C.UI.TEXT_LIGHT, scale = 0.3}),
                            },
                        },
                    }]]
                    nodes = introductionNodes
                }
        
            end
        },
    }
end

local keywordTest = {
    ["Basic Effect Efficiency"] = {
        ["C"] = "attention",
    },
    ["Attack"] = {
        ["C"] = "attention",
    },
    ["Speed"] = {
        ["C"] = "attention",
    },
    ["Ultimate"] = {
        ["C"] = "attention",
        ["E"] = 2,
    },
}

local res = BalatroSR.automaticColoring("If current score is lower than 80% of score requirement, increases ATK by 15%", {["s"] = 0.7,["additional_keywords"] = keywordTest}) --fun test :3
--print(res)
