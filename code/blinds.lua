---@diagnostic disable: return-type-mismatch
local defaultUISize = 6
local hsrUISize = 1
SMODS.current_mod.passive_ui_size = function()
   return math.min(hsrUISize,defaultUISize)
end

SMODS.Blind{ --Test Blind
    key = 'Test',
    loc_txt = {
       name = 'YOU ARE FUCKEDDDDDD',
       text = {
          'All Jokers are debuffed'
       }
    },
    dollars = 5,
    mult = 0.1,
    boss_colour = HEX('C8831B'),
    boss = {min = 10, max = 10, showdown = true},
    in_pool = function(self)
      return false
    end,
 
    recalc_debuff = function(self,card,from_blind)
       if card.ability.set == 'Joker' then return true end
    end
}

local hookTo = ease_background_colour_blind
function ease_background_colour_blind(state, blind_override) --FORCE THE FUCKING GAME OTIMOATIEOAM TO change color of the background :3
   local ret = hookTo(state, blind_override)

   if G and G.GAME and G.GAME.blind and (G.GAME.blind.name == "bl_hsr_Svarog" or G.GAME.blind.name == "bl_hsr_Cocolia") then
      ease_background_colour{new_colour = HEX("abcbff"), special_colour = HEX("d2e0f7"), tertiary_colour = darken(G.C.WHITE, 0.5), contrast = 3}
   end

   return ret
end

local hookTo = Game.start_run
function Game:start_run(args) --To change the background color even when you re-enter the run
   hookTo(self, args)

   ease_background_colour_blind()

   if G and G.GAME and G.GAME.blind and (G.GAME.blind.name == "bl_hsr_Svarog" or G.GAME.blind.name == "bl_hsr_Cocolia") then --Ensuring that Particles are loaded even when run is reloaded
      G.E_MANAGER:add_event(Event({
         trigger = 'immediate',
         func = function()
            G.hsr_snow = Particles(1, 1, 0,0, {
               timer = 0.015,
               scale = 0.2,
               initialize = true,
               lifespan = 1,
               speed = 1.1,
               padding = -1,
               attach = G.ROOM_ATTACH,
               colours = {HEX("d2e0f7"),HEX("abcbff")},
               fill = true
            })
            G.hsr_snow.fade_alpha = 1
            G.hsr_snow:fade(1, 0)
 
            return true
         end
      }))  
   end
end

local game_updateref = Game.update
function Game.update(self, dt)
    -- i hate chicot, same
    if find_passive("psv_hsr_Showdown") then G.GAME.blind.disabled = nil end
    game_updateref(self, dt)
end

SMODS.Blind{
   key = 'Svarog',
   loc_txt = {
      name = 'Svarog',
      text = {
         'The Iron Protector',
         'of Belobog'
      }
   },
   dollars = 10,
   mult = 3.5,
   boss_colour = HEX('919191'),
   boss = {min = 8, max = 8, showdown = true},
   passives = {
      "psv_hsr_Svarog_passive1",
      "psv_hsr_Showdown",
   },
   phases = 3,
   resistances = {"Physical","Ice","Quantum","Imaginary"},
   --weaknesses = {"Fire","Lightning","Wind"},

   set_blind = function(self)
      --Elemental Resistance stuff
      for _,r in ipairs(self.resistances or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) - 0.2
      end
      for _,w in ipairs(self.weaknesses or {}) do
         G.GAME[w.."_multi"] = (G.GAME[w.."_multi"] or 1) + 0.3
      end
      --Adding snow particles
      G.E_MANAGER:add_event(Event({
         trigger = 'immediate',
         func = function()
            G.hsr_snow = Particles(1, 1, 0,0, {
               timer = 0.015,
               scale = 0.2,
               initialize = true,
               lifespan = 1,
               speed = 1.1,
               padding = -1,
               attach = G.ROOM_ATTACH,
               colours = {HEX("d2e0f7"),HEX("abcbff")},
               fill = true
            })
            G.hsr_snow.fade_alpha = 1
            G.hsr_snow:fade(1, 0)
 
            return true
         end
      }))  

   end,

   defeat = function(self)
      G.E_MANAGER:add_event(Event({ --Clearing the snow particles
         trigger = 'immediate',
         func = function()
            if G.hsr_snow then
               G.hsr_snow.max = 0  
            end

            return true
         end
      }))   

      for _,c in ipairs(G.jokers.cards) do --Un-debuffing the cards debuffed by Svarog
         if c.ability.debuffedBySvarog then
            SMODS.calculate_effect({message = localize("hsr_released")},c)
            c:juice_up()
            c.ability.debuffedBySvarog = nil
            c:set_debuff(false)
         end
      end
   end,

   phase_change = function(self)
      --[[G.E_MANAGER:add_event(Event({ code for plasma transition it seems
         func = (function()
             local text = localize('k_balanced')
             play_sound('gong', 0.94, 0.3)
             play_sound('gong', 0.94*1.5, 0.2)
             play_sound('tarot1', 1.5)
             ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
             ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
             attention_text({
                 scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
             })
             G.E_MANAGER:add_event(Event({
                 trigger = 'after',
                 blockable = false,
                 blocking = false,
                 delay =  4.3,
                 func = (function() 
                         ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                         ease_colour(G.C.UI_MULT, G.C.RED, 2)
                     return true
                 end)
             }))
             G.E_MANAGER:add_event(Event({
                 trigger = 'after',
                 blockable = false,
                 blocking = false,
                 no_delete = true,
                 delay =  6.3,
                 func = (function() 
                     G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                     G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                     return true
                 end)
             }))
             return true
         end)
      }))]]
      ease_hands_played(G.GAME.round_resets.hands - G.GAME.current_round.hands_left)
      
      for k,p in ipairs(G.GAME.blind) do
         if p == "hsr_Svarog_debuff1" then G.GAME.blind[k] = nil end
         if p == "hsr_Svarog_debuff2" then G.GAME.blind[k] = nil end
      end

      for _,c in ipairs(G.jokers.cards) do
         if c.ability.debuffedBySvarog then
            SMODS.calculate_effect({message = localize("hsr_released")},c)
            c:juice_up()
            c.ability.debuffedBySvarog = nil
            c:set_debuff(false)
         end
      end

      if G.GAME.current_round.phases_beaten == 1 then
         G.GAME.blind.passives = {
            "psv_hsr_Svarog_passive1",
            "psv_hsr_Showdown",
            "psv_hsr_Svarog_passive3",
         }
         G.E_MANAGER:add_event(Event({
            func = (function()
               local text = localize('hsr_phase_2')
               attention_text({
                   scale = 1.4, text = text, hold = 5, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
               })
               return true
            end)
         }))
      elseif G.GAME.current_round.phases_beaten == 2 then
         G.GAME.blind.passives = {
            "psv_hsr_Svarog_passive1",
            "psv_hsr_Showdown",
            "psv_hsr_Svarog_passive3_2",
         }
         G.E_MANAGER:add_event(Event({
            func = (function()
               local text = localize('hsr_phase_3')
               attention_text({
                   scale = 1.4, text = text, hold = 5, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
               })
               return true
            end)
         }))
      end

      --[[if armExist then --Delete all arms when entering a new phase.
         for k,passive in ipairs(G.GAME.blind.passives) do
            if passive == "psv_hsr_Svarog_summon" then
               G.GAME.blind.passives[k] = nil
            end
         end
      end]]
   end,

   calculate = function(self,card,context)
      local passive3,passive3_2 = false,false
      local SvarogDebuffCounter = 0
      for _,passive in ipairs(G.GAME.blind.passives or {}) do
         if passive == "psv_hsr_Svarog_passive3" then
            passive3 = true
         elseif passive == "psv_hsr_Svarog_passive3_2" then
            passive3_2 = true
         end   
      end
      local howManyArms = 0
      for _,passive in ipairs(G.GAME.blind.passives or {}) do
         if passive == "psv_hsr_Svarog_summon" then
            howManyArms = howManyArms + 1
         end
      end

      for _,c in ipairs(G.jokers.cards) do
         if c.ability.debuffedBySvarog then
            SvarogDebuffCounter = SvarogDebuffCounter + 1
         end
      end

      if context.before then
         G.GAME.blind["hsr_svarog_arm_destroyed"] = false
      end

      if context.before and (passive3 or passive3_2) then
         if (passive3 and howManyArms < 1 and not G.GAME.blind["hsr_Svarog_summon_2"]) or (passive3_2 and howManyArms < 2 and not G.GAME.blind["hsr_Svarog_summon_3"]) then
            if passive3 then
               G.GAME.blind["hsr_Svarog_summon_2"] = true
               G.GAME.blind.passives[#G.GAME.blind.passives+1] = "psv_hsr_Svarog_summon"
            elseif passive3_2 then
               G.GAME.blind["hsr_Svarog_summon_3"] = true
               G.GAME.blind.passives[#G.GAME.blind.passives+1] = "psv_hsr_Svarog_summon"
               G.GAME.blind.passives[#G.GAME.blind.passives+1] = "psv_hsr_Svarog_summon"
            end
            return{
               message = localize("hsr_svarog_engage")
            }
         end

         local heart,club,spade,diamond = BalatroSR.vanillaSuitCheck(context.scoring_hand)

         if not heart and howManyArms > 0 then
            local temp = 0
            local check = 1
            if passive3_2 and howManyArms > 1 then
               check = check + 1
            end
            for _ = 1,howManyArms do
               if (SvarogDebuffCounter + temp) < check then
                  local poolToCheck = {}

                  for _,c in ipairs(G.jokers.cards) do
                     if not c.ability.debuffedBySvarog and not c.debuff then
                        poolToCheck[#poolToCheck+1] = c
                     end
                  end
   
                  local random = pseudorandom_element(poolToCheck,pseudoseed("hsr_svarog_rng"))
                  if random then
                     SMODS.calculate_effect({message = localize("hsr_debuffed")},random)
                     random:juice_up()
                     random:set_debuff(true)
                     random.ability.debuffedBySvarog = true
                     temp = temp + 1
                  end
               end
            end
         end

         if heart and club and spade and diamond and not G.GAME.blind["hsr_svarog_arm_destroyed"] then
            for k,passive in ipairs(G.GAME.blind.passives) do
               if passive == "psv_hsr_Svarog_summon" then
                  G.GAME.blind["hsr_svarog_arm_destroyed"] = true
                  table.remove(G.GAME.blind.passives,k)
                  local poolToCheck = {}

                  for _,c in ipairs(G.jokers.cards) do
                     if c.ability.debuffedBySvarog and c.debuff then
                        poolToCheck[#poolToCheck+1] = c
                     end
                  end
   
                  local random = pseudorandom_element(poolToCheck,pseudoseed("hsr_svarog_rng2"))
                  if random then
                     SMODS.calculate_effect({message = localize("hsr_released")},random)
                     random:juice_up()
                     random:set_debuff(false)
                     random.ability.debuffedBySvarog = false
                  end

                  return {
                     message = localize("hsr_destroyed"),
                  }
               end
            end
         end
      end

      if context.final_scoring_step and howManyArms > 0 then
         if howManyArms <= 1 then
            return{
               xmult = 0.5,
               xchips = 0.5,
            }
         else
            return{
               xmult = 0.5,
               xchips = 0.5,
               extra = {
                  xmult = 0.5,
                  xchips = 0.5,
               }
            }
         end
      end
   end,
}