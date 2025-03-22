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

SMODS.Blind{
   key = 'Svarog',
   loc_txt = {
      name = 'Svarog',
      text = {
         'The Iron Protector',
         'of Belobog'
      }
   },
   dollars = 5,
   mult = 4,
   boss_colour = HEX('919191'),
   boss = {min = 10, max = 10, showdown = true},
   passives = {
      "psv_hsr_Svarog_passive1",
      "psv_hsr_Showdown",
      "psv_hsr_Svarog_passive2",
      "psv_hsr_Svarog_passive3",
      "psv_hsr_Svarog_passive4",
  },

   calculate = function(self,card,context)
      if context.final_scoring_step then
         return{
            xmult = 0.5
         }
      end
   end,
}