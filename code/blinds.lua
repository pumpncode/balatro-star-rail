SMODS.Blind{
    key = 'Test',
    loc_txt = {
       name = 'YOU ARE FUCKEDDDDDD',
       text = {
          'All Jokers are debuffed.'
       }
    },
    dollars = 5,
    mult = 0.1,
    boss_colour = HEX('C8831B'),
    boss = {min = 10, max = 10, showdown = true},
 
    recalc_debuff = function(self,card,from_blind)
       if card.ability.set == 'Joker' then return true end
    end
}