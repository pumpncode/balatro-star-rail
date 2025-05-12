return { --remind me to work on this
    descriptions = {
        Passive = {
            --Svarog
            psv_hsr_Svarog_passive1 = {
                name = 'Elemental Resistance',
                text = {
                   '[{C:red}-20%{}] {C:hsr_ice}Ice{}, {C:hsr_physical}Physical{}, {C:hsr_quantum}Quantum{}, {C:hsr_imaginary}Imaginary{}',
                }
            },
            psv_hsr_Svarog_passive2 = { --Unused
                name = 'A Steel Heart Capable of Care',
                text = {
                    'If {C:attention}Clara{} is in the Joker area, her effects are {C:green,E:2}increased{}',
                    'by 50%',
                }
            },
            psv_hsr_Svarog_passive3 = {
                name = 'Boost Deployment',
                text = {
                    'Summons 1 {C:attention}Auxiliary Robot Arm Unit{} {C:inactive}(A.A.A.A){}',
                    ' ',
                    'If scored hand has base suits {C:spades}Spades{}, {C:hearts}Hearts{}, {C:clubs}Clubs{},',
                    'and {C:diamonds}Diamonds{}, deactivates an {C:attention}A.A.A.A{}',
                }
            },
            psv_hsr_Svarog_passive3_2 = {
                name = 'Boost Deployment V2.0',
                text = {
                    'Summons 2 {C:attention}Auxiliary Robot Arm Unit{} {C:inactive}(A.A.A.A){}',
                    ' ',
                    'If scored hand has base suits {C:spades}Spades{}, {C:hearts}Hearts{}, {C:clubs}Clubs{},',
                    'and {C:diamonds}Diamonds{} cards, deactivates an {C:attention}A.A.A.A{}',
                }
            },
            psv_hsr_Svarog_summon = {
                name = 'Auxiliary Robot Arm Unit',
                text = {
                    'If played hand has no cards with base Suit {C:hearts}Hearts{},',
                    '{C:red,E:2}debuffs a Joker{}',
                    ' ',
                    '{X:mult,C:white}X0.5{} Mult',
                    '{X:chips,C:white}X0.5{} Chips',
                }
            },
            --Cocolia
            psv_hsr_Cocolia_ER = {
                name = 'Elemental Resistance',
                text = {
                   '[{C:red}-20%{}] {C:hsr_imaginary}Imaginary{}',
                   '[{C:red}-40%{}] {C:hsr_physical}Physical{}, {C:hsr_wind}Wind{}',
                   '[{C:red}-60%{}] {C:hsr_ice}Ice{}',
                }
            },
            psv_hsr_Cocolia_passive1 = {
                name = 'Hoarfrost of Eternal Isolation',
                text = {
                    '{C:attention}Leftmost{} played card becomes {C:attention}Glass{}',
                    '{C:red}Destroys{} {C:attention}rightmost{} played card, reduces {C:mult}Mult{} by',
                    'its {C:chips}Chips * 5{}'
                },
            },
            psv_hsr_Cocolia_passive2 = {
                name = 'Chill of Bone-Piercing Coagulation',
                text = {
                    'If scored hand has only:',
                    '- 1 Suit: {C:attention}rightmost{} card becomes {C:attention}Stone{}',
                    '- 1 Rank: {C:attention}rightmost{} card becomes {C:attention}Foil{}',
                },
            },
            psv_hsr_Cocolia_passive2_1 = {
                name = 'Bone-Shattering Cold',
                text = {
                    '{C:attention}Leftmost{} played card becomes {C:attention}Glass{}',
                    'Each card in hand has {C:green}50%{} to become {C:attention}Glass{}',
                    '{C:red}Destroys{} {C:attention}Glass{} cards in hand',
                },
            },
            psv_hsr_Cocolia_passive2_2 = {
                name = 'Harbinger of Annihilation',
                text = {
                    'Caps Score at {C:attention}50%{} of Score Requirement per hand,',
                    '{C:attention}Marks{} a random Joker',
                    'After 3 {C:blue}Hands{} are played, {C:red}destroys{} marked Joker,',
                    '{C:red,E:2}reduces Score by half{}',
                },
            },
            psv_hsr_Cocolia_passive2_3 = {
                name = 'Heartless Annihilator Call',
                text = {
                    'Summons 1 {C:attention}Lances of the Eternal Freeze{}',
                },
            },
            psv_hsr_Cocolia_summon = {
                name = 'Lances of the Eternal Freeze',
                text = {
                    'Destroyed if scored hand has more than 2 base {C:attention}Suits{},',
                    '{C:attention}Ranks{}',
                    ' ',
                    '{X:mult,C:white}X0.5{} Mult',
                },
            },
            psv_hsr_Cocolia_passive3_nuke = {
                name = '{C:red}Last Choir of Genesis',
                text = {
                    '{C:red,E:2}Destroys all cards in hand',
                    '{C:red,E:2}and half of your deck,',
                    '{C:red,E:2}reduces Score to 0 if next hand',
                    '{C:red,E:2}does not beat the Blind',
                },
            },
            psv_hsr_Cocolia_passive3_1 = {
                name = "The Creation's Prelude",
                text = {
                    'After using 7 {C:blue}Hands{}/{C:red}Discards{},',
                    'uses {C:red,E:2}Last Choir of Genesis{}',
                    ' ',
                    '{X:chips,C:white}X0.3{} Chips',
                    '{X:mult,C:white}X0.3{} Mult',
                },
            },
            --Frostspawn
            psv_hsr_Frostspawn_ER = {
                name = 'Elemental Resistance',
                text = {
                   '[{C:red}-20%{}] {C:hsr_imaginary}Imaginary{}, {C:hsr_quantum}Quantum{}, {C:physical}Physical{}, {C:hsr_lightning}Lightning{}',
                   '[{C:red}-40%{}] {C:hsr_ice}Ice{}',
                }
            },
            --Flamespawn
            psv_hsr_Flamespawn_ER = {
                name = 'Elemental Resistance',
                text = {
                   '[{C:red}-20%{}] {C:hsr_lightning}Lightning{}, {C:hsr_wind}Wind{}, {C:hsr_quantum}Quantum{}, {C:hsr_imaginary}Imaginary{}',
                   '[{C:red}-40%{}] {C:hsr_fire}Fire{}',
                }
            },
            --Thunderspawn
            psv_hsr_Thunderspawn_ER = {
                name = 'Elemental Resistance',
                text = {
                   '[{C:red}-20%{}] {C:hsr_ice}Ice{}, {C:hsr_fire}Fire{}, {C:hsr_quantum}Quantum{}, {C:hsr_imaginary}Imaginary{}',
                   '[{C:red}-40%{}] {C:hsr_lightning}Lightning{}',
                }
            },
            --Windspawn
            psv_hsr_Windspawn_ER = {
                name = 'Elemental Resistance',
                text = {
                   '[{C:red}-20%{}] {C:hsr_ice}Ice{}, {C:hsr_physical}Physical{}, {C:hsr_quantum}Quantum{}, {C:hsr_imaginary}Imaginary{}',
                   '[{C:red}-40%{}] {C:hsr_wind}Wind{}',
                }
            },
            --Automaton Direwolf
            psv_hsr_A_Direwolf_ER = {
                name = 'Elemental Resistance',
                text = {
                   '[{C:red}-20%{}] {C:hsr_fire}Fire{}, {C:hsr_physical}Physical{}, {C:hsr_quantum}Quantum{}, {C:hsr_wind}Wind{}',
                }
            },
            psv_hsr_A_Direwolf_passive1 = {
                name = 'Dismantle',
                text = {
                   '{E:2,C:red}Destroys{} scoring hand if hand score',
                   'is {C:attention}above{} 50% of score requirement',
                }
            },
            psv_hsr_A_Direwolf_passive2 = {
                name = 'Lock On Target',
                text = {
                   'If played hand is {C:attention}High Card{},',
                   'replaces this passive with {C:attention}Felling Order{}',
                }
            },
            psv_hsr_A_Direwolf_passive2_1 = {
                name = '{C:red}Felling Order{}',
                text = {
                   'After each hand, {E:2,C:red}destroys{} 3',
                   'random cards in hand. If hand then',
                   'has no cards, {E:2,C:red}destroys{} a',
                   'random Joker',
                }
            },
            --Others
            psv_hsr_Showdown = {
                name = 'Final Showdown',
                text = {
                    "{C:red,E:2}Can't be disabled{}",
                    'Boss Blind has {C:attention}3{} Phases',
                    ' ',
                    'Restores {C:blue}Hands{} when entering next phase'
                }
            },
            psv_hsr_wtf = {
                name = 'Hecatoncheires',
                text = {
                    '{C:red}Discards{} are',
                    'restored when they are used',
                    '{C:inactive,E:2}Last push - let us {}{C:dark_edition,E:2}Trailblaze!',
                }
            },
        },
        dictionary={
            hsr_keybind_warning = {
                name = "",
                text = {
                    "{s:inactive}You will need to restart the game if you change the keybinds for them to work.{}"
                },
            },
            hsr_hover_enable_desc = {
                name = "",
                text = {
                    "{s:inactive}If enabled, you can turn pages only by hovering your mouse on the Card.{}"
                },
            },
            hsr_hello_world = {
                "Hello World!",
                "la manchaland don quixote",
                "please work for god sake"
            },
            hsr_introduction = {
                name = "",
				text = {
                    "This mod is entirely based on {C:dark_edition}Honkai Star Rail{}, a game which I WAS addicted to, and probably will be again.",   
                    "Don't let the {C:red}stereotypes{} get you, the game is not {C:money}Pay To Win{}, and it's pretty fun. I highly suggest checking it out!",
                    "Most Jokers in this mod function much more differently from others, which I will explain below.",
				},
            },
            hsr_introduction1 = {
                name = "",
				text = {
                    "HSR Jokers{} can only be obtained through Warp Tickets, except for {C:attention}Literal Trash{}.",   
                    "HSR Jokers can increase their {C:attention}Eidolon{} by having identical or certain cards at its right, further buffing them.",
                    "HSR Jokers have stats, which are all {C:green}increased{}/{C:red}decreased{} by {C:green}Buff{}/{C:red}Debuffs{}, {C:green}increasing{}/{C:red}decreasing{} the effectiveness of their effects.",
                    "HSR Jokers all have an {C:attention}Element{} and a {C:attention}Type{}, which some effects may use to determine the outcome.",
				},
            },
            hsr_introduction3 = {
                name = "",
				text = {
                    "There is currently a number of stats a HSR Joker can have, which is: {C:attention}Attack{}, {C:attention}Element Multi{}, {C:attention}Cooldown Regeneration{}, {C:attention}Basic Effect Efficiency{}, {C:attention}Ultimate Efficiency{}, {C:attention}Follow-up Effect Efficiency{}.",
                    "Playing Cards can have a numder of stats, which is: {C:attention}Element Res{}, {C:attention}DOT Multi{}, {C:attention}Defense Reduction{}, which all boost [Attack] effects that target them.",
                    "{C:attention}Basic Effect Efficiency{} boosts effects of HSR Jokers which are triggered at end of hand, such as {C:mult}+5{} Mult."
				},
            },
            hsr_introduction4 = {
                name = "",
				text = {
                    "{C:attention}Relics{} can be bought from a Booster Pack in shop, boosting HSR Jokers' stats as well as having certain {C:attention}Set Effects{} triggered when you have multiple parts of the same set equipped.",
                    "However, it is important to note that some effects will {C:red}NOT{} work if the conditions aren't met."
				},
            },
            hsr_introduction5 = {
                name = "",
				text = {
                    "Some HSR Jokers can have {C:attention}Ultimates{}, which can be recharged through certain conditions, and the cooldown can be sped up through {C:attention}Cooldown Regeneration{}.",
                    "Some HSR Jokers can have {C:attention}Follow-up Effects{}, which is usually triggered under a certain condition.",
                    "Some HSR Jokers can inflict {C:attention}DOT (Damage Over Time){}, basically allowing inflicted Cards to function like Steel Cards with the DOT's respective gains.",
                    "These types of effect can be interacted with by certain effects.",
				},
            },
            hsr_introduction6 = {
                name = "",
				text = {
                    "And last but not least - Remember to {C:dark_edition}read{}! Most HSR Jokers don't share the same effect as the other, especially the Legendaries,",
                    "so if you are unsure of their functionalities - Read, and do so thoroughly.",
				},
            },
        },
        Joker = {
            ["hsr_relic_box"] = {
                name = "",
                text = {
                    '{C:inactive}-----[{}Bonus Set Effects{C:inactive}]-----{}',
                    '{C:inactive,s:0.7}[2] #16#{}',
                    '{C:inactive,s:0.7}[4] #17#{}',
                    '{C:inactive}[Head]{}'..' #8#',
                    '{C:inactive,s:0.7}#12#{}',
                    '{C:inactive}[Body]{}'..' #9#',
                    '{C:inactive,s:0.7}#13#{}',
                    '{C:inactive}[Hands]{}'..' #10#',
                    '{C:inactive,s:0.7}#14#{}',
                    '{C:inactive}[Feet]{}'..' #11#',
                    '{C:inactive,s:0.7}#15#{}',
                }
            },
            ["hsr_page"] = {
                name = "",
                text = {
                    '{C:inactive}(Page #18#/#19#){}',
                }
            },
            ["hsr_stats_page"] = {
                name = "",
                text = {
                    "Speed: {C:red}#20#{}",
                    "{C:inactive,s:0.8}(Excess Action Value: #21#){}",
                    "Attack: {C:red}#22#%{}",
                    "Basic Effect Efficiency: {C:red}#23#%{}",
                    "#3# Element Multiplier: {C:red}#24#%{}",
                    "Other Stats:",
                    "{C:inactive,s:0.7}#25#{}",
                }
            },
            ["j_hsr_Trash1"] = {
                name = "Literal Trash",
                text = {
                    '{C:inactive}...It is a trash bag. What did you expect-{}',
                    '{C:inactive}Did you think it will give you money?{}',
                }
            },
            ["j_hsr_Trash2"] = {
                name = "Literal Trash",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'..' {s:0.7}Gain{} {C:money,s:0.7}$#31#{} {s:0.7}at end of round{}',
                    '{C:inactive,s:0.8}(Eidolon 2){}'..' {s:0.7}Gain{} {C:money,s:0.7}$#31#{} {s:0.7}at end of round{}',
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Gain{} {C:money,s:0.7}$#31#{} {s:0.7}at end of round{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'..' {s:0.7}Gain{} {C:money,s:0.7}$#31#{} {s:0.7}at end of round{}',
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Gain{} {C:money,s:0.7}$#31#{} {s:0.7}at end of round{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'..' {s:0.7}Gain{} {C:money,s:0.7}$#31#{} {s:0.7}at end of round{}',
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}A trash bag. Maybe a certain lunatic will be{}',
                    '{C:inactive,s:0.6}tremendously buffed when standing next to it.{}',
                },
            },
            ["j_hsr_Yanqing1"] = {
                name = "Yanqing",
                text = {
                    'If no discards were used this round, gain {C:attention}Soulsteel Sync{}',
                    '{C:inactive}If Joker has{} {C:attention}Soulsteel Sync{}{C:inactive}:{}',
                    '{C:inactive}- [Attack] Played cards with {C:spades}Spade{}{C:inactive} suit give {}{X:chips,C:white}X1.1{}{C:inactive} Chips and {}{C:money}$1{}',
                    "{C:inactive}- Increases {}{C:attention}ATK{}{C:inactive} by 25%{}",
                }
            },
            ["j_hsr_Yanqing2"] = {
                name = "Yanqing",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'..' {s:0.7}If Joker has {}{C:attention,s:0.7}Soulsteel Sync{}{s:0.7}, played cards with Spade suit give {}{C:chips,s:0.7}+20{}{s:0.7} Chips{}',
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}If Joker has {}{C:attention,s:0.7}Soulsteel Sync{}{s:0.7}, increases {}{C:attention,s:0.7}SPD{}{s:0.7} by 20{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}If Joker has {}{C:attention,s:0.7}Soulsteel Sync{}{s:0.7}, played cards with Spade suit give {}{C:money,s:0.7}$1{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}If Joker has {}{C:attention,s:0.7}Soulsteel Sync{}{s:0.7}, increases {}{C:attention,s:0.7}Ice Element Multiplier{}{s:0.7} by 12%{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}If Joker has {}{C:attention,s:0.7}Soulsteel Sync{}{s:0.7}, {}{X:chips,C:white,s:0.7}X1.5{}{s:0.7} Chips{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}If Joker has {}{C:attention,s:0.7}Soulsteel Sync{}{s:0.7}, increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 25%{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}For some reason, pain and agony can be felt from{}',
                    '{C:inactive,s:0.6}HSR players as he pops out of the train.{}',
                }
            },
            ["j_hsr_Arlan1"] = {
                name = "Arlan",
                text = {
                    "{C:mult}+25{} Mult",
                    "(1) When hand is played, use 2 {C:blue}Hands{} instead",
                    "(2) For each remaining {C:blue}Hand{} below {C:blue}Max Hands{},",
                    "increases {C:attention}Basic Effect Efficiency{} by 20% {C:inactive}(Up to 100%){}",
                }
            },
            ["j_hsr_Arlan2"] = {
                name = "Arlan",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}If {}{s:0.7,C:chips}Hand{}{s:0.7} is lower than (or equal) 2, further increases this Joker's {}{s:0.7,C:attention}Basic Effect Efficiency{}{s:0.7} by 50%{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'..' {s:0.7,C:chips}+10{}{s:0.7} Chips{}',
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7,C:mult}+25{}{s:0.7} Mult{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}If {}{s:0.7,C:chips}Hand{}{s:0.7} is lower than (or equal) 2, {}{X:mult,C:white,s:0.7}X1.02{}{s:0.7} Mult{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7,C:chips}+10 {}{s:0.7}Chips, {}{s:0.7,C:mult}+10{}{s:0.7} Mult{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}Each {}{s:0.7,C:chips}Hand{}{s:0.7} below max hand increases Joker's {}{C:attention,s:0.7}Basic Effect Efficiency{}{s:0.7} by 30% instead,",
                    '{s:0.7}Cap is increased to 300%{}',
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Bronya1"] = {
                name = "Bronya",
                text = {
                    '{X:mult,C:white}X#31#{} Mult',
                    'Retrigger {C:attention}rightmost{}{C:dark_edition} HSR{} Joker except {C:attention}Bronya{}',
                }
            },
            ["j_hsr_Bronya2"] = {
                name = "Bronya",
                text = {
                    '{C:inactive,s:0.8}(Eidolon ?){}'..'{s:0.7} bronya too op, so no eidolon effects :3{}',
                    'Current Eidolon: {C:mult}?{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}The strongest Harmony character in history.{}', 
                    '{C:inactive,s:0.6}...Being power crept by a wannabe priest and a child is insane tho :sob:{}',
                }
            },
            ["j_hsr_Kafka1"] = {
                name = "Kafka",
                text = {
                    "A random card in hand and 4 adjacent cards to it are inflicted",
                    "with {C:attention}Shock{}, or {C:attention}Amplified Shock{} if they",
                    "are already inflicted with it",
                    '{C:inactive}[Attack]{} Triggers all {}{C:attention}DoT{} effects of cards in hand',
                    '{C:inactive}Ultimate [#34#/#35# Discarded Cards]{} All cards are inflicted with',
                    '{C:attention}Amplified Shock{}',
                }
            },
            ["j_hsr_Kafka2"] = {
                name = "Kafka",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'..' {s:0.7}Unplayed cards in hand are inflicted with{}{C:attention,s:0.7} Da Capo{}{s:0.7}, increasing{}{C:attention,s:0.7} DoT{}{s:0.7} efficiency by 30%{}',
                    '{C:inactive,s:0.8}(Eidolon 2){}'..' {s:0.7}Discarded cards inflicted with{}{C:attention,s:0.7} Shock{}{s:0.7} give{}{C:money,s:0.7} $5{}',
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Increases{} {C:attention,s:0.7}DoT{}{s:0.7} efficiency by 30%{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'..' {s:0.7}Unplayed cards in hand inflicted with {}{C:attention,s:0.7}Shock{}{s:0.7} give {}{X:mult,C:white,s:0.7} X#32#{}{s:0.7} Mult{}',
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Unplayed cards in hand inflicted with{}{C:attention,s:0.7} Shock{}{s:0.7} give{}{C:mult,s:0.7} +#33#{}{s:0.7} Mult{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'..' {s:0.7}Kafka becomes {}{C:dark_edition,s:0.7}Negative{}{s:0.7}, increases{}{C:attention,s:0.7} DoT{}{s:0.7} efficiency by 100%{}',
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}A lost architype in HSR, now reborn stronger than ever.{}', 
                    '{C:inactive,s:0.6}A Stellaron Hunter, capable of manipulating individuals to her desires.{}',
                }
            },
            ["j_hsr_Sampo1"] = {
                name = "Sampo",
                text = {
                    'A random card in hand is inflicted with 1 stack of',
                    '{C:attention}Wind Shear 5{} times',
                    '{C:inactive}[Attack]{} Triggers all {}{C:attention}Wind Shear{} effects of cards in hand',
                }
            },
            ["j_hsr_Sampo2"] = {
                name = "Sampo",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'..' {s:0.7}{C:attention,s:0.7}Wind Shear{}{s:0.7} is retriggered{}',
                    '{C:inactive,s:0.8}(Eidolon 2){}'..' {s:0.7}An additional stack of {C:attention,s:0.7}Wind Shear{}{s:0.7} is inflicted{}',
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Increases{} {C:attention,s:0.7}Wind Shear{}{s:0.7} efficiency by #33#%{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'..' {s:0.7}If an unplayed card in hand has 5 or more stacks of {}{C:attention,s:0.7}Wind Shear{}{s:0.7}, additionally gives {}{C:chips,s:0.7}+#34#{}{s:0.7} Chips per stack{}',
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Unplayed cards in hand inflicted with{}{C:attention,s:0.7} Wind Shear{}{s:0.7} give{}{C:mult,s:0.7} +#35#{}{s:0.7} Mult per stack{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'..' {s:0.7}Increases {}{C:attention,s:0.7}DoT{}{s:0.7} efficiency by #36#%{}',
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}The jester, the unpredictable.{}', 
                    '{C:inactive,s:0.6}A very much "ordinary" salesman in Belebog.{}',
                }
            },
            ["j_hsr_Pela1"] = {
                name = "Pela",
                text = {
                    '{C:mult}+#31#{} Mult',
                    '{C:inactive}Ultimate [#33#/#35# Hand]{} Unplayed cards in hand are inflicted', 
                    'with {C:attention}Exposed{}, reducing their {C:attention}DEF{} by 20%',
                }
            },
            ["j_hsr_Pela2"] = {
                name = "Pela",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'..' {s:0.7}Each 5 discarded cards reduces Ultimate Cooldown by 1 hand{}{C:inactive,s:0.8} [#34#/5]{}',
                    '{C:inactive,s:0.8}(Eidolon 2){}'..' {C:mult,s:0.7}+#32#{}{s:0.7} Mult{}',
                    "{C:inactive,s:0.8}(Eidolon 3){}".." {s:0.7}Increases {}{C:attention,s:0.7}Exposed{}{s:0.7}'s{}{C:attention,s:0.7} DEF Reduction{}{s:0.7} by 10%{}",
                    "{C:inactive,s:0.8}(Eidolon 4){}".." {C:attention,s:0.7}Exposed{}{s:0.7} additionally reduces unplayed cards'{}{C:attention,s:0.7} Ice RES{}{s:0.7} by 12%{}",
                    "{C:inactive,s:0.8}(Eidolon 5){}".." {s:0.7}Increases {}{C:attention,s:0.7}Exposed{}{s:0.7}'s{}{C:attention,s:0.7} DEF Reduction{}{s:0.7} by 10%{}",
                    "{C:inactive,s:0.8}(Eidolon 6){}".." {s:0.7}Increases {}{C:attention,s:0.7}Exposed{}{s:0.7}'s{}{C:attention,s:0.7} DEF Reduction{}{s:0.7} by 5%{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive, s:0.6}Intelligence Officer of the Silvermane Guard.{}', 
                    '{C:inactive, s:0.6}...to say she is strong would be a severe underestimation.{}',
                }
            },
            ["j_hsr_Natasha1"] = {
                name = "Natasha",
                text = {
                    '{C:chips}+#31#{} Hand',
                    '{C:inactive}Ultimate [#32#/#33# Discarded Cards]{} {C:chips}+#31#{} Hand for the current round', 
                }
            },
            ["j_hsr_Natasha2"] = {
                name = "Natasha",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'..' {s:0.7}If current hand is below (or equal) 2, increase Cooldown Regeneration by 1{}',
                    '{C:inactive,s:0.8}(Eidolon 2){}'..' {s:0.7}After triggering {}{C:attention,E:2,s:0.7}Ultimate{}{s:0.7}, next turn, {}{s:0.7,C:white,X:chips}X#34#{}{s:0.7} Chips{}',
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7,C:chips}+1{}{s:0.7} Hand{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'..' {s:0.7}Once per round, when current hand reaches 1, immediately give {}{C:chips,s:0.7}+1{}{s:0.7} Hand{}',
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7,C:red}+1{}{s:0.7} Discard{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'..' {s:0.7}Once per round, after triggering {}{C:attention,E:2,s:0.7}Ultimate{}{s:0.7}, {}{s:0.7,C:red}+1{}{s:0.7} Discard{}',
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}A fastidious doctor who always wears a curious smile.{}',
                    '{C:inactive,s:0.6}She is one of the very few doctors whom the Underworld people can turn to.{}',
                }
            },
            ["j_hsr_Tingyun1"] = {
                name = "Tingyun",
                text = {
                    'Grants the rightmost HSR Joker except herself with {C:attention}Benediction{}, lasting for 3 turns',
                    '{C:inactive}Jokers with {}{C:attention}Benediction{}{C:inactive} increase their {}{C:attention}Attack{}{C:inactive} by #31#%,{}',
                    '{C:inactive}and their {}{C:attention}Basic Effect Efficiency{}{C:inactive} by #32#%{}',
                }
            },
            ["j_hsr_Tingyun2"] = {
                name = "Tingyun",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'..' {s:0.7}Jokers with {}{s:0.7,C:attention}Benediction{}{s:0.7} give {}{s:0.7,C:mult}+15{}{s:0.7} Mult{}',
                    '{C:inactive,s:0.8}(Eidolon 2){}'..' {s:0.7}Jokers with {}{s:0.7,C:attention}Benediction{}{s:0.7} increase their Cooldown Regeneration by 1{}',
                    '{C:inactive,s:0.8}(Eidolon 3){}'.." {s:0.7}Increase {}{s:0.7,C:attention}Basic Effect Efficiency{}{s:0.7} by 50%{}",
                    '{C:inactive,s:0.8}(Eidolon 4){}'..' {s:0.7,C:attention}Benediction{}{s:0.7} additionally buffs {}{s:0.7,C:attention}Attack{}{s:0.7} by 20%{}',
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7,C:attention}Benediction{}{s:0.7} additionally buffs {}{s:0.7,C:attention}Basic Effect Efficiency{}{s:0.7} by 20%{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'..' {s:0.7}Jokers with {}{s:0.7,C:attention}Benediction{}{s:0.7} give {}{s:0.7,X:mult,C:white}X1.5{}{s:0.7} Mult{}',
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}A silver-tongued Foxian Girl, Head Representative of the Whistling Flames.{}',
                    '{C:inactive,s:0.6}She has such a way with words that often leaves her audience eagerly waiting for more of her tales.{}',
                }
            },
            ["j_hsr_Asta1"] = {
                name = "Asta",
                text = {
                    'Gain one stack of {}{C:attention}Astrometry{} (up to 4) for each different Suit scored this round',
                    '{C:attention}Astrometry{}{C:inactive} reduces by 4 stacks at end of round{}',
                    "{C:inactive}Each stack of {}{C:attention}Astrometry{}{C:inactive} buffs every Jokers' {}{C:attention}Attack{}{C:inactive} by #31#% and {}{C:mult}+#32#{}{C:inactive} Mult{}",
                    '{C:inactive}Ultimate [#34#/#35# Hands, #36#/#37# Discards]{} Grant Jokers {C:attention}Astral Blessing{} for 3 turns',
                    "{C:inactive}Jokers' {}{C:attention}SPD{}{C:inactive} with {}{C:attention}Astral Blessing{}{C:inactive} increases by 50{}",
                }
            },
            ["j_hsr_Asta2"] = {
                name = "Asta",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'..' {s:0.7}A random card in hand is inflicted with {}{C:attention,s:0.7}Burn 5 {}{s:0.7}times. Triggers all {}{C:attention,s:0.7}Burn{}{s:0.7} effects of cards in hand{}',
                    '{C:inactive,s:0.8}(Eidolon 2){}'..' {s:0.7}If {}{C:attention,E:2,s:0.7}Ultimate{}{s:0.7} was triggered this round, {}{s:0.7,C:attention}Astrometry{}{s:0.7} will not be reduced at end of current round{}',
                    '{C:inactive,s:0.8}(Eidolon 3){}'.." {s:0.7}Each stack of {}{C:attention,s:0.7}Astrometry{}{s:0.7} additionally gives {}{C:mult,s:0.7}+5{}{s:0.7} Mult{}",
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}If the number of {}{C:attention,s:0.7}Astrometry{}{s:0.7}'s stack is more than (or equal) 2, increase Cooldown Regeneration by 1{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Reduce the number of Hands necessary to trigger {}{C:attention,E:2,s:0.7}Ultimate{}{s:0.7} by 1{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}If the number of {}{C:attention,s:0.7}Astrometry{}{s:0.7}'s stack is 4, increase {}{c:attention,s:0.7}Attack{}{s:0.7} by 50%{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}A silver-tongued Foxian Girl, Head Representative of the Whistling Flames.{}',
                    '{C:inactive,s:0.6}She has such a way with words that often leaves her audience eagerly waiting for more of her tales.{}',
                }
            },
            ["j_hsr_M71"] = {
                name = "March 7th",
                text = {
                    "{C:chips}+20{} Chips",
                    '{C:inactive}Ultimate [#31#/#32# Hand]{} {C:blue}+1{} Hand,',
                    '2 random played cards turn into {C:attention}Glass{} cards,',
                    'revert at the end of round',
                }
            },
            ["j_hsr_M72"] = {
                name = "March 7th",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7,C:mult}+5{}{s:0.7} Mult{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'..' {s:0.7}After triggering {}{C:attention,E:2,s:0.7}Ultimate{}{s:0.7}, next turn, {C:attention,s:0.7}Basic Effect Efficiency{}{s:0.7} increases by 20%{}',
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7,C:chips}+30{}{s:0.7} Chips{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}After triggering {}{C:attention,E:2,s:0.7}Ultimate{}{s:0.7}, next turn, {}{s:0.7,C:white,X:mult}X1.5{}{s:0.7} Mult{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}If current hand is below (or equal) 2, increase Cooldown Regeneration by 1{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {C:attention,E:2,s:0.7}Ultimate{}{s:0.7} converts 3 cards instead{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_DanHeng1"] = {
                name = "Dan Heng",
                text = {
                    "{C:inactive}[Attack]{} Played cards with {C:spades}Spade{} suit give {C:mult}+5{} Mult",
                    "Once per round, if {C:blue}Hand{} is lower than 2,",
                    "Played cards with {C:spades}Spade{} suit give {C:chips}+20{} Chips",
                }
            },
            ["j_hsr_DanHeng2"] = {
                name = "Dan Heng",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}If current score is lower than (or equal) 50% of score requirement, increases {}{C:attention,s:0.7}Attack{}{s:0.7} by 12%{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}Increases Passive's {}{s:0.7,C:attention}Threshold{}{s:0.7} by 1{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Played cards with {}{C:spades,s:0.7}Spade{}{s:0.7} suit give {}{s:0.7,C:mult}+2{}{s:0.7} Mult{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}Once per round, if Dan Heng possesses a Buff, increases {}{C:attention,s:0.7}Wind Element Multiplier{}{s:0.7} by 36% for one turn{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Played Cards with {}{s:0.7,C:spades}Spade{}{s:0.7} suit give {}{s:0.7,C:mult}+3{}{s:0.7} Mult{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}Increase {}{s:0.7,C:attention}SPD{}{s:0.7} by 25{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Welt1"] = {
                name = "Welt",
                text = {
                    "{C:chips}+#31#{} Chips, {X:chips,C:white}X#32#{} Chips {C:inactive,s:0.7}(Each 100 Chips increases XChips by {}{X:chips,C:white,s:0.7}X1.1{}{C:inactive,s:0.7}){}",
                    "Randomly selects a card in played hand {C:attention}3{} times, increases {C:chips}Chips{} equal to",
                    "the card's Chips, and increases its {C:attention}DMG Taken{} by 12%",
                    "{C:red,E:2}Chips reset at the end of Ante{}"
                }
            },
            ["j_hsr_Welt2"] = {
                name = "Welt",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}Each hand, increases {}{C:attention,s:0.7}Basic Effect Efficiency{}{s:0.7} by 50% for 1 turn{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}Each unique card chosen by Passive doubles the scaling for {}{C:chips,s:0.7}Chips{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7,C:chips}+100{}{s:0.7} Chips{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}Passive increases {}{C:attention,s:0.7}DMG Taken{}{s:0.7} by 25% instead{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7,C:chips}+200{}{s:0.7} Chips{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}Passive selects 4 cards instead. Scaling for {}{C:chips,s:0.7}Chips{}{s:0.7} is doubled{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Himeko1"] = {
                name = "Himeko",
                text = {
                    "If played hand contains at least 3 different {C:attention}Ranks{} or {C:attention}Suits{}, triggers {C:attention,E:2}Follow-up Effect{}",
                    "{C:inactive}[Follow-up Effect, Attack]{} Played cards give {X:mult,C:white}X1.2{} Mult and {X:chips,C:white}X1.2{} Chips,",
                    "afterwards, {C:red,E:2}destroys a card with the lowest rank{}",
                }
            },
            ["j_hsr_Himeko2"] = {
                name = "Himeko",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}When {}{C:attention,E:2,s:0.7}Follow-up Effect{}{s:0.7} is triggered, increases {}{C:attention,s:0.7}SPD{}{s:0.7} by 20 for 2 turns{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 15% if current score is higher than (or equal) 50% of score requirement{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}If there are 4 different Suits in played hand, {}{X:mult,C:white,s:0.7}X2{}{s:0.7} Mult instead{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7,E:2,C:attention}Follow-up Effect{}{s:0.7} only needs 2 different {}{C:attention,s:0.7}Ranks{}{s:0.7} or {}{C:attention,s:0.7}Suits{}{s:0.7} to trigger{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 50%{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7,E:2,C:attention}Follow-up Effect{}{s:0.7} additionally retriggers played cards once{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Bailu1"] = {
                name = "Bailu",
                text = {
                    "{E:2,C:red}This Joker gives 50% less Mult/Chips{}",
                    "{C:blue}+1{} Hand, {C:red}+1{} Discard",
                    '{C:inactive}Ultimate [Once per Round, #31#/#32# Hands, #33#/#34# Discards]{} Select a random card in hand {C:attention}3{} times,',
                    '- For each {C:attention}Unique{} card chosen, {C:blue}+1{} Hand for the current round',
                    '- For each {C:attention}Repeated{} card chosen, {C:red}+1{} Discard for the current round',
                }
            },
            ["j_hsr_Bailu2"] = {
                name = "Bailu",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}When {}{C:attention,E:2,s:0.7}Ultimate{}{s:0.7} is triggered, if {}{s:0.7,C:blue}Hands{}{s:0.7} are above 3, increases all Jokers' {}{s:0.7,C:attention}Cooldown Regeneration{}{s:0.7} by 1 for 1 turn{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}When {}{C:attention,E:2,s:0.7}Ultimate{}{s:0.7} is triggered, increases Bailu's {}{s:0.7,C:attention}Basic Effect Efficiency{}{s:0.7} by 15% for 2 turns{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7,X:mult,C:white}X2.5{}{s:0.7} Mult{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}Each {}{s:0.7,C:attention}Unique{}{s:0.7} card (up to 3) increases all Jokers' {}{s:0.7,C:attention}ATK{}{s:0.7} by 10% for 2 turns{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7,X:chips,C:white}X2.5{}{s:0.7} Chips{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}Once per Ante, if {}{s:0.7,C:blue}Hand{}{s:0.7} reaches 0, restores to Max Hands{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Clara1"] = {
                name = "Clara",
                text = {
                    "{E:2,C:green}This Joker gives 100% more Mult/Chips{}",
                    "{C:mult}+#31#{} Mult",
                    "When a Hand is drawn, inflicts {C:attention}Mark of Counter{} on a random card in hand",
                    "{E:2,C:red}Destroys all cards in hand inflicted with Mark of Counter when a hand is played{}",
                    "For every card destroyed this way, increases Mult by {C:mult}+10{}",
                }
            },
            ["j_hsr_Clara2"] = {
                name = "Clara",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}Destroyed cards with {}{C:attention,s:0.7}Mark of Counter{}{s:0.7} applies {}{C:attention,s:0.7}Mark of Counter{}{s:0.7} to adjacent cards{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}When a card with {}{C:attention,s:0.7}Mark of Counter{}{s:0.7} is destroyed, increases {}{C:attention,s:0.7}Basic Effect Efficiency{}{s:0.7} by 30% for 2 turns{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7,C:chips}+25{}{s:0.7} Chips{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}Each {}{s:0.7,C:mult}100{}{s:0.7} Mult additionally gives {}{s:0.7,X:mult,C:white}X1.1{}{s:0.7} Mult{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7,C:chips}+25{}{s:0.7} Chips{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}Passive additionally increases Mult by {}{s:0.7,C:mult}+40.{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Seele1"] = {
                name = "Seele",
                text = {
                    "{C:inactive}[Attack]{} Played cards with {V:2}#31#{} suit give {X:mult,C:white}X1.1{} Mult",
                    "Retriggers all played cards with {V:2}#31#{} suit",
                    "{C:inactive}[Attack]{} Played {C:attention}#32#s{} give {X:chips,C:white}X1.1{} Chips",
                    "{C:red,E:2}Suit and Rank reset after a hand is played{}",
                }
            },
            ["j_hsr_Seele2"] = {
                name = "Seele",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}If current score is lower than (or equal) 80% of score requirement, increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 15%{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}Increases {}{C:attention,s:0.7}Speed{}{s:0.7} by 25{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Increases {}{C:attention,s:0.7}Attack{}{s:0.7} by 10%{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}Played Cards with both {}{C:attention,s:0.7}Chosen Rank{}{s:0.7} and {}{C:attention,s:0.7}Chosen Suit{}{s:0.7} give {}{C:white,X:mult,s:0.7}X1.5{}{s:0.7} Mult and {}{C:white,X:chips,s:0.7}X1.5{}{s:0.7} Chips instead{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Increases {}{C:attention,s:0.7}Speed{}{s:0.7} by 50{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}Played cards are inflicted with {}{C:attention,s:0.7}Butterfly Flurry{}",
                    "{C:attention,s:0.7}Butterfly Flurry{}{s:0.7} increases affected cards' {}{C:attention,s:0.7}DMG Taken{}{s:0.7} by 50%{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_JingYuan1"] = {
                name = "Jing Yuan",
                text = {
                    "When hand is played, each card with unique {C:attention}Rank{} increases {C:attention}Hit-per-action{} by 1 (up to 10),", 
                    "then triggers {E:2,C:attention}Follow-up Effect{}",
                    "{C:inactive}[Follow-up Effect, Attack]{} For each {C:attention}Hit-per-action{}, a random card in hand",
                    "and its adjacent cards give {C:mult}+25{} Mult, as well as additional effects depending on their {C:attention}Enhancement{}:",
                    "{s:0.8,C:inactive}[Lucky Card] There is a fixed 50% chance to give {}{s:0.8,C:white,X:mult}X2{}{s:0.8,C:inactive} Mult{}",
                    "{s:0.8,C:inactive}[Mult Card] {}{s:0.8,C:white,X:mult}X1.5{}{s:0.8,C:inactive} Mult{}",
                    "{s:0.8,C:inactive}[Glass Card] {}{s:0.8,C:white,X:chips}X2{}{s:0.8,C:inactive} Chips, then destroy itself{}",
                    "{E:2,C:red}Resets Hit-per-action to 0 when hand is played{}",
                }
            },
            ["j_hsr_JingYuan2"] = {
                name = "Jing Yuan",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}Adjacent cards give 25% more {C:mult,s:0.7}Mult{}/{C:chips,s:0.7}Chips{}{s:0.7} from {}{C:attention,E:2,s:0.7}Follow-up Effect{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}After using {}{C:attention,E:2,s:0.7}Follow-up Effect{}{s:0.7}, increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 35% for 1 turn{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Begins at 2 {}{C:attention,s:0.7}Hit-per-action{}{s:0.7} instead of 0 each hand{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}When {}{E:2,C:attention,s:0.7}Follow-up Effect{}{s:0.7} is triggered, each {}{C:attention,s:0.7}Hit-per-action{}{s:0.7} increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 2%{}{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 15%{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}Cards targeted by {}{E:2,C:attention,s:0.7}Follow-up Effect{}{s:0.7} increase their {}{C:attention,s:0.7}DMG Taken{}{s:0.7} by 12%, stacking up to 3 times{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Herta1"] = {
                name = "Herta",
                text = {
                    "When current score first reaches higher (or equal) than 50% of score",
                    "requirement, triggers {E:2,C:attention}Follow-up Effect{}",
                    "{C:inactive}[Follow-up Effect, Attack]{} Each unplayed card gives {C:chips}+25{} Chips,",
                    "and the next cards also give {C:chips}+25{} Chips more if consecutively triggered,",
                    "if it is a {C:attention}Glass Card{}, additionally gives {X:chips,C:white}X1.2{} Chips",
                }
            },
            ["j_hsr_Herta2"] = {
                name = "Herta",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}Chips from {}{E:2,C:attention,s:0.7}Follow-up Effect{}{s:0.7} are increased by 40%{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}When {}{E:2,C:attention,s:0.7}Follow-up Effect{}{s:0.7} is triggered, each card in hand increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 4%, up to 40%{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 10%{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {C:attention,E:2,s:0.7}Follow-up Effect{}{s:0.7} additionally gives {}{s:0.7,C:chips}+10{}{s:0.7} Chips{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 12%{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {C:attention,E:2,s:0.7}Follow-up Effect{}{s:0.7} gives {}{s:0.7,C:white,X:chips}X1.5{}{s:0.7} Chips instead when card is {}{C:attention,s:0.7}Glass{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Qingque1"] = {
                name = "Qingque",
                text = {
                    "If played hand is {C:attention}Four of a Kind{}, triggers {C:attention}A Scoop of Moon{}",
                    "{C:inactive}[A Scoop of Moon]{} {C:attention}Suit{} of each card in hand is randomized",
                    "For each card with the same base {C:attention}Suit{} in played hand, increases {C:attention}Tile{} by 1",
                    "When {C:attention}Tile{} is 4, resets to 0 and enters {C:attention}Cherry on Top!{} state",
                    "{C:inactive}If Joker has {}{C:attention}Cherry on Top!{}{C:inactive}:",
                    "{C:inactive}- [Attack] Scored cards give {}{C:white,X:mult}X4{}{C:inactive} Mult, {}{C:white,X:chips}X2{}{C:inactive} Chips, {}{C:money}$1{}",
                    "{C:inactive}- Exits {}{C:attention}Cherry on Top!{}{C:inactive} state at the end of hand{}",
                    "{C:inactive}[Current Tiles: #31#]{}"
                }
            },
            ["j_hsr_Qingque2"] = {
                name = "Qingque",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {C:attention,s:0.7}Cherry on Top!{}{s:0.7} state gives 10% more Mult and Chips{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}When {}{C:attention,s:0.7}A Scoop of Moon{}{s:0.7} is triggered, increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 5% up to 4 times, resets at the end of round{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 5%{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}In {}{C:attention,s:0.7}Cherry on Top!{}{s:0.7} state, there is a fixed 75% chance to retrigger each played card once{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 7%{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {C:attention,s:0.7}Cherry on Top!{}{s:0.7} state gives {}{s:0.7,C:white,X:mult}X5{}{s:0.7} Mult instead{}",
                    "{s:0.7}When {}{C:attention,s:0.7}A Scoop of Moon{}{s:0.7} is triggered, if there is a {}{C:attention,s:0.7}Suit{}{s:0.7} with the highest number in hand{}",
                    "{s:0.7}randomizes cards with other {}{C:attention,s:0.7}Suit{}{s:0.7}, else, randomizes all cards{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Sushang1"] = {
                name = "Sushang",
                text = {
                    "{C:inactive}[Attack]{} Played card with {V:2}#31#{} suit gives {C:chips}+#34#{} Chips:",
                    "- {C:green}#32# in #33#{} to {C:red,E:2}destroy{}, and permenantly increases Chips from",
                    "{C:attention}Attack{} by {C:chips}+25{}",
                    "- {C:green}#32# in #35#{} to be inflicted with {C:attention}Bleed{}, and a fixed {C:green}75%{} to trigger {C:attention}Bleed{},",
                    "repeated up to 5 times",
                    "{C:inactive}(Suit resets every time this Joker is obtained){}"
                }
            },
            ["j_hsr_Sushang2"] = {
                name = "Sushang",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}When {}{C:attention,E:2,s:0.7}Attack{}{s:0.7} breaks a card, increases {}{C:attention,s:0.7}SPD{}{s:0.7} by 25 for 1 turn, up to 4 times{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}When {}{C:attention,E:2,s:0.7}Attack{}{s:0.7} triggers {C:attention,s:0.7}Bleed{}{s:0.7}, increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 20% for 1 turn{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 5%{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 40%{}',
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 7%{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}Increases {}{C:attention,s:0.7}SPD{}{s:0.7} by 10{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Gepard1"] = {
                name = "Gepard",
                text = {
                    "{C:blue}+2{} Hands",
                    "{X:chips,C:white}X#31#{} Chips",
                    "{C:inactive}(Increases by {}{X:chips,C:white}X0.2{}{C:inactive} per Stone Card in deck){}",
                    "When hand is played, if {C:attention}leftmost{} card in hand is",
                    "{C:attention}Stone{}, increases its Chips by {C:chips}+50{}. Else,",
                    "converts it to {C:attention}Stone{}",
                }
            },
            ["j_hsr_Gepard2"] = {
                name = "Gepard",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}If card is {}{C:attention,s:0.7}Stone{}{s:0.7}, additionally increases its Chips by {}{C:chips,s:0.7}+25{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}When Joker turns card into {}{C:attention,s:0.7}Stone{}{s:0.7}, {}{C:attention,s:0.7}Basic Effect Efficiency{}{s:0.7} increases by 20% for 1 turn{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {C:attention,s:0.7}Stone{}{s:0.7} cards when scored give {}{s:0.7,C:mult}+20{}{s:0.7} Mult{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}+2 {}{C:blue,s:0.7}Hand{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {C:attention,s:0.7}Stone{}{s:0.7} cards when scored give {}{s:0.7,C:money}$1{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {s:0.7}Once per round, when {}{C:blue,s:0.7}Hand{}{s:0.7} reaches 0, increases {}{C:blue,s:0.7}Hand{}{s:0.7} by +4{}",
                    "{s:0.7}If card is {}{C:attention,s:0.7}Stone{}{s:0.7}, additionally increases its Chips by {}{C:chips,s:0.7}+75{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Serval1"] = {
                name = "Serval",
                text = {
                    "When hand is played, each card in hand has {C:green}#31# in #32#{} to be",
                    "inflicted with {C:attention}Shock{}",
                    "{C:inactive}[Attack]{} Each card in hand inflicted with {C:attention}Shock{} gives {C:mult}+15{} Mult",
                    "{C:inactive}Ultimate [#33#/#34# Discarded Cards]{} Inflicts all cards in hand with {C:attention}Shock{}",
                }
            },
            ["j_hsr_Serval2"] = {
                name = "Serval",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {s:0.7}When {}{C:attention,s:0.7,E:2}Attack{}{s:0.7} is triggered, 1 in 2 for each adjacent card with {}{C:attention,s:0.7}Shock{}{s:0.7} to give {}{s:0.7,C:mult}+15{}{s:0.7} Mult{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}Everytime Serval inflicts {}{C:attention,s:0.7}Shock{}{s:0.7}, increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 5% up to 5 times{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 5%{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {C:attention,E:2,s:0.7}Ultimate{}{s:0.7} has a fixed 50% to reduce {}{C:attention,s:0.7}DEF{}{s:0.7} by 10%{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 7%{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {C:attention,E:2,s:0.7}Attack{}{s:0.7} gives 30% more Mult{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
            ["j_hsr_Hook1"] = {
                name = "Hook",
                text = {
                    "{C:mult}+#31#{} Mult",
                    "When {C:blue}Hand{}/{C:red}Discard{} is used, inflicts {C:attention}Burn{} on a random",
                    "card and its adjacent cards in hand",
                    "{C:inactive}[Attack]{} Triggers {C:attention}Burn{} on each scored card,",
                    "if it has more than (or equal) 2 stacks of {C:attention}Burn{}, {E:2,C:red}destroys it{},",
                    "and increases Mult by {C:mult}+5{}",
                }
            },
            ["j_hsr_Hook2"] = {
                name = "Hook",
                text = {
                    '{C:inactive,s:0.8}(Eidolon 1){}'.." {C:attention,E:2,s:0.7}Attack{}{s:0.7} gives 20% more Mult{}",
                    '{C:inactive,s:0.8}(Eidolon 2){}'.." {s:0.7}Inflicts an additional stack of {}{C:attention,s:0.7}Burn{}",
                    '{C:inactive,s:0.8}(Eidolon 3){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 5%{}',
                    '{C:inactive,s:0.8}(Eidolon 4){}'.." {s:0.7}If {C:attention,E:2,S:0.7}Attack{}{s:0.7} is triggered, additionally triggers {}{C:attention,s:0.7}Burn{}{s:0.7} on adjacent cards{}",
                    '{C:inactive,s:0.8}(Eidolon 5){}'..' {s:0.7}Increases {}{C:attention,s:0.7}ATK{}{s:0.7} by 7%{}',
                    '{C:inactive,s:0.8}(Eidolon 6){}'.." {C:attention,E:2,s:0.7}Attack{}{s:0.7} gives 30% more Mult{}",
                    'Current Eidolon: {C:red}#1#{}',
                    'Type: {C:red}#2#{}',
                    'Element: {V:1}#3#{}',
                    '{C:inactive,s:0.6}Head of the security department around Herta Space Station{}', 
                    '{C:inactive,s:0.6}who can also manage your finances quite well.{}',
                }
            },
        },
        WarpTickets = {
            c_hsr_starrailspecialpass = {
                name = "Star Rail Special Pass",
                text = {
                    'Roll #1# time(s) with different chances',
                    '{C:inactive,s:0.6}94.3% to get a 3 stars Standard Joker{}',
                    '{C:inactive,s:0.6}5.1% to get a 4 stars Standard Joker{}',
                    '{C:inactive,s:0.6}0.3% to get a 5 stars Standard Joker{}',
                    '{C:inactive,s:0.6}0.3% to get a 5 stars Special Joker{}',
                    'Pity: #7#',
                    '#2#',
                    '{C:inactive,s:0.8}Featured 5-Star:{} {C:attention,s:0.8}#3#{}',
                    '{C:inactive,s:0.8}Featured 4-Star:{} {C:attention,s:0.8}#4#{}',
                    '{C:inactive,s:0.6}[Banner #5#/#6#]{}',
                },
            },

            c_hsr_starrailpass = {
                name = 'Star Rail Pass', 
                text = { 
                    'Roll #1# time(s) with different chances',
                    '{C:inactive,s:0.6}94.3% to get a 3 stars Standard Joker{}',
                    '{C:inactive,s:0.6}5.1% to get a 4 stars Standard Joker{}',
                    '{C:inactive,s:0.6}0.6% to get a 5 stars Standard Joker{}',
                    'Pity: #2#',
                }
            },
        },
        Other = {
            hsr_pc_debuff = {
                name = "Debuffs",
                text = {
                    '{E:2}Inflicted Debuffs{}',
                    '{C:inactive,s:0.8}#1#{}',
                    '{C:inactive,s:0.8}#2#{}',
                },
            },
            hsr_j_buff = {
                name = "Buffs",
                text = {
                    '{E:2}Current Buffs{}',
                    '{C:inactive,s:0.8}#1#{}',
                    '{C:inactive,s:0.8}#2#{}',
                },
            },
            hsr_dot_shock = {
                name = "Shock",
                text = {
                    "{C:inactive}Max Stack:{} {C:attention}1{}",
                    "{C:inactive}[-.. --- -]{}",
                    "{C:inactive}Gives {}{C:mult}+20{}{C:inactive} Mult{}",
                    "{C:inactive}per stack{}",
                },
            },
            hsr_dot_amplified_shock = {
                name = "Amplified Shock",
                text = {
                    "{C:inactive}Max Stack:{} {C:attention}1{}",
                    "{C:inactive}This debuff is also seen as {}{C:attention}Shock{}",
                    "{C:inactive}[-.. --- -]{}",
                    "{C:inactive}Gives {}{C:mult}+20{}{C:inactive} Mult,{}",
                    "{X:mult,C:white}X1.5{}{C:inactive} Mult per stack{}",
                },
            },
            hsr_dot_burn = {
                name = "Burn",
                text = {
                    "{C:inactive}Max Stack:{} {C:attention}5{}",
                    "{C:inactive}[-.. --- -]{}",
                    "{C:inactive}Gives {}{C:mult}+5{}{C:inactive} Mult{}",
                    "{C:inactive}per stack{}",
                },
            },
            hsr_dot_bleed = {
                name = "Bleed",
                text = {
                    "{C:inactive}Max Stack:{} {C:attention}2{}",
                    "{C:inactive}[-.. --- -]{}",
                    "{C:inactive}Gives {}{C:mult}50%{}{C:inactive} Mult{}",
                    "{C:inactive}of card's {C:chips}Chips{}{C:inactive} per stack{}",
                },
            },
            hsr_dot_wind_shear = {
                name = "Wind Shear",
                text = {
                    "{C:inactive}Max Stack:{} {C:attention}5{}",
                    "{C:inactive}[-.. --- -]{}",
                    "{C:inactive}Gives {}{C:chips}+20{}{C:inactive} Chips{}",
                    "{C:inactive}per stack{}",
                },
            },
        },
    },
    misc={
        dictionary = {
            hsr_world_Belobog = "The Freezing Preservation of Humanity",
            hsr_world_Xianzhou = "The Cursed Abundance of Immortality",

            hsr_debuffed = "Debuffed!",
            hsr_destroyed = "Destroyed!",
            hsr_released = "Released!",
            hsr_retriggered = "Retriggered!",
            hsr_upgraded = "Upgraded!",
            hsr_reinforced = "Reinforced!",

            hsr_svarog_engage = "Engage.",
            hsr_cocolia_summon = "Collapse!",
            hsr_cocolia_nuke = "Last Choir of Genesis!",
            hsr_a_direwolf1 = "Vbhhhrrrrrr", --Tsutje
            hsr_a_direwolf2 = "*inserts chainsaw sound", --aikoyori
            hsr_a_direwolf3 = "*saws", --also aikoyori

            k_hsr_3stars = "3-Stars",
            k_hsr_4stars = "4-Stars",
            k_hsr_5stars = "5-Stars",

            hsr_phase_2 = "Phase 2!",
            hsr_phase_3 = "Phase 3!",

            hsr_m7_message = "Glacial Cascade!",
            hsr_danheng_message = "Ethereal Dream!",
            hsr_pela_message = "Exposed!",
            hsr_asta_message1 = "+1 Astrometry!",
            hsr_asta_message2 = "Astral Blessing!",
            hsr_herta_message = "Kuru Kuru!~",
            hsr_qingque_message = "Cherry on Top!",
            hsr_yanqing_message = "Soulsteel Sync!",
            hsr_yanqing_message2 = "Lost Soulsteel Sync!",
            hsr_himeko_message = "Victory Rush!",
            hsr_bailu_message = "Felicitous Thunderleap!",
            hsr_jingyuan_message = "Lightning Lord!",
            hsr_increase = "Increased!",
            hsr_seele_message = "Resurgence!",
            hsr_sushang_message = "Sword Stance!",
            hsr_bronya_message = "Onward!",

            hsr_banner_name1 = "Butterfly on Swordtip",
            hsr_banner_name2 = "Swirl of Heavenly Spear",
            hsr_banner_name3 = "Nessun Dorma (EARLY)",

            hsr_switch_desc1 = "SWITCH",
            hsr_switch_desc2 = "DESC",
            hsr_switch_banner1 = "SWITCH",
            hsr_switch_banner2 = "BANNER",
            hsr_to_joker1 = "TO",
            hsr_to_joker2 = "JOKER",
            hsr_keybinds_enable = "Enable Keybinds",
            hsr_hover_enable = "Change Pages on Hover",
            hsr_current_keybind = "Current Keybind",
            hsr_gacha_show = "Gacha Results",
            hsr_gacha_shop = "Ticket Shop",
            hsr_level_text = "Level",
            hsr_boss_switch1 = "SWITCH",
            hsr_boss_switch2 = "BOSS",
            hsr_buy = "ROLL",
            hsr_relic_pack = "Relics Pack",
        },
        hsr_keybinds = {
            hsr_turn_page_left = "Turn Left",
            hsr_turn_page_right = "Turn Right",
            hsr_interact_keybind = "Interact",
        },
    },
}