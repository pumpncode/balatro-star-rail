SMODS.Atlas{
    key = 'boosters', --atlas key
    path = 'boosters.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
} --Placeholder, for now.

SMODS.Booster({
    key = 'relics',
    loc_txt = {
        name = 'Relics Pack',
        group_name = 'relics',
        text = {
            'Choose {C:attention}#2#{} of up to',
            '{C:attention}#1#{} Relic pieces',
            '{s:0.3} {}',
            '{s:0.8,C:inactive}With Jimbo\'s scientific breakthrough,',
            '{s:0.8,C:inactive}some jokers can now wear powerful',
            '{s:0.8,C:inactive}clothing pieces to power themselves up!',
        }
    },
    loc_vars = function(self,info_queue,card)
        return{vars = {card.ability.extra,card.ability.choose}}
    end,
    atlas = 'boosters',
    group_key = 'hsr_relic_pack',
    pos = { x = 0, y = 5 },
    config = {extra = 6, choose = 2},
    weight = 7,
    cost = 5,
    draw_hand = false,
    discovered = true,  
    kind = "HSR",
    create_card = function(self)
        return {set = 'relics', area = G.pack_cards, skip_materialize = true}
    end
})