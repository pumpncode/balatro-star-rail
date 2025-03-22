SMODS.Atlas{
    key = 'boosters', --atlas key
    path = 'boosters.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
} --Placeholder, for now.

SMODS.Booster({
    key = 'relics',
    loc_txt = {
        name = 'Relic Booster Pack',
        group_name = 'relics',
        text = {
            'Contains Relics',
            'Grants many benefits when equipped'
        }
    },
    atlas = 'boosters',
    group_key = 'hsr_relic_pack',
    pos = { x = 0, y = 5 },
    config = {extra = 4, choose = 2},
    weight = 5,
    cost = 5,
    draw_hand = false,
    discovered = true,  
    kind = "HSR",
    create_card = function(self)
        return {set = 'relics', area = G.pack_cards, skip_materialize = true}
    end
})