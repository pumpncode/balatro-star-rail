---@diagnostic disable: return-type-mismatch

to_big = to_big or function(x) return x end

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
   config = {extra = {hsr_blindType = "Small"}},
   dollars = 5,
   mult = 0.1,
   boss_colour = HEX('C8831B'),
   boss = {min = 5, max = 5},
   in_pool = function(self)
     return false
   end,
   
   recalc_debuff = function(self,card,from_blind)
     if card.ability.set == 'Joker' then return true end
   end,
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
   if G.hsr_displaying_cutscene then
      -- Cocolia
      if G.hsr_displaying_cutscene == "Cocolia" then
         if G.hsr_cutscene_timer < 1 then
            G.hsr_cutscene_transparency = 1 - G.hsr_cutscene_timer / 1
         end
         if G.hsr_cutscene_timer >= 1.25 then 
            G.CANV_SCALE = 1
            G.hsr_cutscene_transparency = 0
            G.hsr_displaying_cutscene = false
            G.SETTINGS.paused = false
            if G.OVERLAY_MENU then G.OVERLAY_MENU:remove() end
            G.hsr_what_txt = nil
         end
      end
      if not G.hsr_update_lock then G.hsr_cutscene_timer = G.hsr_cutscene_timer + dt end
   end

    -- i hate chicot 
    if find_passive("psv_hsr_Showdown") then G.GAME.blind.disabled = nil end
    game_updateref(self, dt)
end

function hsr_restart_music()
   G.ARGS.push = G.ARGS.push or {}
   G.ARGS.push.type = 'restart_music'
   if G.F_SOUND_THREAD then
      G.SOUND_MANAGER.channel:push(G.ARGS.push)
   else
      RESTART_MUSIC(G.ARGS.push)
   end
end

SMODS.Atlas({
   key = "cocolia_c",
   path = "cocolia_c.png",
   px = 1500,
   py = 654
})

function hsr_display_cutscene(pos, c_type, delay_pause) --Copied from LCorp's display_cutscene
   local atlas = nil
   if c_type == "Cocolia" then
      atlas = "hsr_cocolia_c"
   end
   G.hsr_cutscene_transparency = c_type == "Cocolia" and 1 or 0
   G.hsr_cutscene_timer = 0
   G.hsr_update_lock = true
   G.hsr_displaying_cutscene = c_type

   local ui_nodes = {}
   if atlas then
       G.hsr_cutscene = Sprite(0, 0, 14.2 * (1500 / 654), 14.2, G.ASSET_ATLAS[atlas], pos)
       G.hsr_cutscene.states.drag.can = false
       G.hsr_cutscene.draw_self = function(self, overlay)
           if not self.states.visible then return end
           if self.sprite_pos.x ~= self.sprite_pos_copy.x or self.sprite_pos.y ~= self.sprite_pos_copy.y then
               self:set_sprite_pos(self.sprite_pos)
           end
           prep_draw(self, 1)
           love.graphics.scale(1 / (self.scale.x / self.VT.w), 1 / (self.scale.y / self.VT.h))
           love.graphics.setColor({ 1, 1, 1, G.hsr_cutscene_transparency })
           love.graphics.draw(
               self.atlas.image,
               self.sprite,
               0, 0,
               0,
               self.VT.w / (self.T.w),
               self.VT.h / (self.T.h)
           )
           love.graphics.pop()
           add_to_drawhash(self)
           self:draw_boundingrect()
           if self.shader_tab then love.graphics.setShader() end
       end
       ui_nodes = {
           {n = G.UIT.R, config = { align = "cm", colour = G.C.CLEAR }, nodes = {
               { n = G.UIT.O, config = { object = G.hsr_cutscene }},
           }}
       }
   end

   if c_type == "Cocolia" then
      G.OVERLAY_MENU = UIBox{
          definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes=ui_nodes},
          config = {
              align = "cm",
              offset = {x = 0, y = 0},
              major = G.ROOM_ATTACH,
              bond = 'Strong',
              no_esc = true
          }
      }
  end
   G.E_MANAGER:add_event(Event({trigger = delay_pause and 'after' or 'immediate', delay = delay_pause or 0, timer = "REAL", func = function() 
      G.hsr_update_lock = nil
      G.SETTINGS.paused = true
      -- copied from G.FUNCS.overlay_menu just to remove the pop-in anim
      if G.OVERLAY_MENU and not c_type == "Cocolia" then G.OVERLAY_MENU:remove() end
      G.CONTROLLER.locks.frame_set = true
      G.CONTROLLER.locks.frame = true
      G.CONTROLLER.cursor_down.target = nil
      G.CONTROLLER:mod_cursor_context_layer(G.NO_MOD_CURSOR_STACK and 0 or 1)
      if c_type ~= "Cocolia" then
         G.OVERLAY_MENU = UIBox{
            definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes=ui_nodes},
            config = {
               align = "cm",
               offset = {x = 0, y = 0},
               major = G.ROOM_ATTACH,
               bond = 'Strong',
               no_esc = true
            }
         } 
      end
   return true end }))
end

--Small Blinds
SMODS.Blind{ --Frostspawn
   key = 'Frostspawn',
   loc_txt = {
      name = 'Frostspawn',
      text = {
         'Playing a hand turns',
         'rightmost card in',
         'hand to Stone',
      }
   },
   dollars = 5,
   mult = 1.2,
   boss_colour = G.C.hsr_colors.hsr_ice,
   boss = {min = 1, max = 1},
   passives = {
      "psv_hsr_Frostspawn_ER",
   },
   config = {extra = {hsr_blindType = "Small"}},
   resistances1 = {"Imaginary", "Quantum", "Physical", "Lightning"},
   resistances2 = {"Ice"},
   --weaknesses = {"Fire","Lightning","Wind"},

   in_pool = function(self)
      return false
   end,

   defeat = function(self)
      for _,r in ipairs(self.resistances1 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) + 0.2
      end

      for _,r in ipairs(self.resistances2 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) + 0.4
      end

      for _,r in ipairs(self.resistances3 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) + 0.6
      end
   end,

   set_blind = function(self)
      --Elemental Resistance stuff
      G.GAME["hsr_frostspawn_blind"] = {}
      for _,r in ipairs(self.resistances1 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) - 0.2
      end

      for _,r in ipairs(self.resistances2 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) - 0.4
      end

      for _,r in ipairs(self.resistances3 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) - 0.6
      end
   end,

   calculate = function(self,card,context)
      if context.before then
         if G.hand.cards[#G.hand.cards] then
            BalatroSR.enhanceCard(_,{G.hand.cards[#G.hand.cards]},"m_stone")
         end
      end
   end
}

SMODS.Blind{ --Flamespawn
   key = 'Flamespawn',
   loc_txt = {
      name = 'Flamespawn',
      text = {
         'Playing a hand destroys',
         'rightmost and leftmost',
         'card in hand',
      }
   },
   dollars = 5,
   mult = 1.2,
   boss_colour = G.C.hsr_colors.hsr_fire,
   boss = {min = 1, max = 1},
   passives = {
      "psv_hsr_Frostspawn_ER",
   },
   config = {extra = {hsr_blindType = "Small"}},
   resistances1 = {"Wind", "Quantum", "Imaginary", "Lightning"},
   resistances2 = {"Fire"},
   --weaknesses = {"Fire","Lightning","Wind"},

   in_pool = function(self)
      return false
   end,

   defeat = function(self)
      for _,r in ipairs(self.resistances1 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) + 0.2
      end

      for _,r in ipairs(self.resistances2 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) + 0.4
      end

      for _,r in ipairs(self.resistances3 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) + 0.6
      end
   end,

   set_blind = function(self)
      --Elemental Resistance stuff
      G.GAME["hsr_flamespawn_blind"] = {}
      for _,r in ipairs(self.resistances1 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) - 0.2
      end

      for _,r in ipairs(self.resistances2 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) - 0.4
      end

      for _,r in ipairs(self.resistances3 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) - 0.6
      end
   end,

   calculate = function(self,card,context)
      if context.destroy_card and ((context.destroy_card == (G.hand.cards[#G.hand.cards] or {})) or (context.destroy_card == (G.hand.cards[1] or {}))) then
         return{
            remove = true,
         }
      end
   end
}
--Big Blinds

--Boss Blinds

SMODS.Blind{ --Svarog
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

   in_pool = function(self)
      return false
   end,

   set_blind = function(self)
      --Elemental Resistance stuff
      G.GAME["hsr_svarog_blind"] = {}
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
      for _,r in ipairs(self.resistances or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) + 0.2
      end
      for _,w in ipairs(self.weaknesses or {}) do
         G.GAME[w.."_multi"] = (G.GAME[w.."_multi"] or 1) - 0.3
      end

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
      
      for k,p in ipairs(G.GAME["hsr_svarog_blind"]) do
         if p == "hsr_Svarog_debuff1" then G.GAME["hsr_svarog_blind"][k] = nil end
         if p == "hsr_Svarog_debuff2" then G.GAME["hsr_svarog_blind"][k] = nil end
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
         G.GAME["hsr_svarog_blind"]["hsr_svarog_arm_destroyed"] = false
      end

      if context.before and (passive3 or passive3_2) then
         if (passive3 and howManyArms < 1 and not G.GAME["hsr_svarog_blind"]["hsr_Svarog_summon_2"]) or (passive3_2 and howManyArms < 2 and not G.GAME["hsr_svarog_blind"]["hsr_Svarog_summon_3"]) then
            if passive3 then
               G.GAME["hsr_svarog_blind"]["hsr_Svarog_summon_2"] = true
               G.GAME.blind.passives[#G.GAME.blind.passives+1] = "psv_hsr_Svarog_summon"
            elseif passive3_2 then
               G.GAME["hsr_svarog_blind"]["hsr_Svarog_summon_3"] = true
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

         if heart and club and spade and diamond and not G.GAME["hsr_svarog_blind"]["hsr_svarog_arm_destroyed"] then
            for k,passive in ipairs(G.GAME.blind.passives) do
               if passive == "psv_hsr_Svarog_summon" then
                  G.GAME["hsr_svarog_blind"]["hsr_svarog_arm_destroyed"] = true
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
         for _ = 1,howManyArms do
            SMODS.calculate_effect({xmult = 0.5, xchips = 0.5}, G.GAME.blind)
         end
      end
   end,
}

SMODS.Blind{ --Cocolia
   key = 'Cocolia',
   loc_txt = {
      name = 'Cocolia',
      text = {
         'The Supreme Guardian',
         'of Belobog'
      }
   },
   dollars = 10,
   mult = 3.5,
   boss_colour = HEX('91ccff'),
   boss = {min = 8, max = 8, showdown = true},
   config = {extra = {}},
   in_pool = function(self)
      return false
   end,
   passives = {
      "psv_hsr_Cocolia_ER",
      "psv_hsr_Showdown",
      "psv_hsr_Cocolia_passive1",
      "psv_hsr_Cocolia_passive2",
   },
   passives2 = {
      "psv_hsr_Cocolia_ER",
      "psv_hsr_Showdown",
      "psv_hsr_Cocolia_passive2_1",
      "psv_hsr_Cocolia_passive2_2",
      "psv_hsr_Cocolia_passive2_3",
   },
   passives3 = {
      "psv_hsr_Cocolia_ER",
      "psv_hsr_Showdown",
      "psv_hsr_wtf",
      "psv_hsr_Cocolia_passive3_1",
      "psv_hsr_Cocolia_passive3_nuke",
   },
   phases = 3,
   resistances1 = {"Imaginary"},
   resistances2 = {"Physical", "Wind"},
   resistances3 = {"Ice"},
   --weaknesses = {"Fire","Lightning","Wind"},

   set_blind = function(self)
      --Elemental Resistance stuff
      hsr_restart_music()
      G.GAME["hsr_cocolia_blind"] = {}

      for _,r in ipairs(self.resistances1 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) - 0.2
      end

      for _,r in ipairs(self.resistances2 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) - 0.4
      end

      for _,r in ipairs(self.resistances3 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) - 0.6
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
      for _,r in ipairs(self.resistances1 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) + 0.2
      end

      for _,r in ipairs(self.resistances2 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) + 0.4
      end

      for _,r in ipairs(self.resistances3 or {}) do
         G.GAME[r.."_multi"] = (G.GAME[r.."_multi"] or 1) + 0.6
      end

      G.E_MANAGER:add_event(Event({ --Clearing the snow particles
         trigger = 'immediate',
         func = function()
            if G.hsr_snow then
               G.hsr_snow.max = 0  
            end

            return true
         end
      }))   
   end,

   phase_change = function(self)
      ease_hands_played(G.GAME.round_resets.hands - G.GAME.current_round.hands_left)
      
      if G.GAME.current_round.phases_beaten == 1 then
         G.GAME.blind.passives = self.passives2
         G.E_MANAGER:add_event(Event({trigger = 'before', func = function() 
            hsr_display_cutscene({x = 0, y = 0}, "Cocolia", 0.1)
         return true end }))
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
         G.GAME.blind.passives = self.passives3
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
   end,

   cry_cap_score = function(self,score)
      if (G.GAME.current_round.phases_beaten or 0) == 1 then
         if to_big(score) >= G.GAME.blind.chips/2 then
            return G.GAME.blind.chips/2
         else
            return score
         end
      end
   end,

   calculate = function(self,card,context)
      if (context.destroying_card and context.destroying_card.ability and context.destroying_card.ability.hsr_Cocolia_marked) or (context.destroy_card and context.destroy_card.ability and context.destroy_card.ability.hsr_Cocolia_marked) then
         return true
      end

      if G.GAME.current_round.phases_beaten == 0 then
         if context.before then
            BalatroSR.enhanceCard(nil,{G.play.cards[1]},"m_glass",nil,true,false,true)
            if BalatroSR.numUniqueSuits(context.scoring_hand,true) <= 1 then
               BalatroSR.enhanceCard(nil,{G.play.cards[#G.play.cards]},"m_stone",nil,true,false,true)
            end
            if BalatroSR.numUniqueRanks(context.scoring_hand) <= 1 then
               G.play.cards[#G.play.cards]:set_edition("e_foil",true) 
            end
            G.play.cards[#G.play.cards].ability.hsr_Cocolia_marked = true
            G.GAME["hsr_cocolia_blind"].Cocolia_passive1_proc = BalatroSR.getCardChips(G.play.cards[#G.play.cards])
         end
   
         if context.final_scoring_step then
            if G.GAME["hsr_cocolia_blind"].Cocolia_passive1_proc then
               local cardChips = G.GAME["hsr_cocolia_blind"].Cocolia_passive1_proc
               G.GAME["hsr_cocolia_blind"].Cocolia_passive1_proc = false
   
               if cardChips ~= 0 then
                  local toReduce = nil
                  if Talisman and to_big then
                     if to_big(cardChips*5):gte(to_big(mult)) then
                        toReduce = mult
                     else
                        toReduce = cardChips*5
                     end
                  else
                     toReduce = math.min(to_big(cardChips * 5),to_big(mult))
                  end
                  --print("Destroyed card gives "..cardChips.." chips, reduces Mult by "..(toReduce or 0))
                  G.E_MANAGER:add_event(Event({ 
                     func = (function()
                        play_sound('gong', 0.94, 0.3)
                        play_sound('gong', 0.94*1.5, 0.2)
                        play_sound('tarot1', 1.5)
                        ease_colour(G.C.UI_MULT, {0.267, 0.769, 1, 1})
                        G.E_MANAGER:add_event(Event({
                           trigger = 'after',
                           blockable = false,
                           blocking = false,
                           delay = 2.3,
                           func = (function() 
                              ease_colour(G.C.UI_MULT, G.C.RED, 2)
                              return true
                           end)
                        }))
                        G.E_MANAGER:add_event(Event({
                           trigger = 'after',
                           blockable = false,
                           blocking = false,
                           no_delete = true,
                           delay = 3.3,
                           func = (function() 
                              G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                              return true
                           end)
                        }))
                        return true
                     end)
                  }))
                  return{
                     mult = -(toReduce or 0)
                  }
               end
            end
         end
      end

      if G.GAME.current_round.phases_beaten == 1 then
         local numOfLances = 0
         local jokerIsMarked = nil
         for _,v in pairs(G.GAME.blind.passives) do
            if v == "psv_hsr_Cocolia_summon" then
               numOfLances = numOfLances + 1
            end
         end
         for _,v in ipairs(G.jokers.cards) do
            if v.ability.cocolia_mark then
               jokerIsMarked = v
               break
            end
         end

         if context.destroy_card then
            local isInHand = false
            for _,v in ipairs(G.hand.cards) do
               if v == context.destroy_card then isInHand = true break end
            end

            if isInHand then
               if SMODS.has_enhancement(context.destroy_card,"m_glass") then
                  return true
               end
            end
         end


         if context.before then
            if G.GAME["hsr_cocolia_blind"].hsr_cocolia_markedJoker then
               G.GAME["hsr_cocolia_blind"].hsr_cocolia_countdown = (G.GAME["hsr_cocolia_blind"].hsr_cocolia_countdown or 0) + 1
               if G.GAME["hsr_cocolia_blind"].hsr_cocolia_countdown >= 3 then
                  G.GAME["hsr_cocolia_blind"].hsr_cocolia_countdown = 0
                  G.GAME["hsr_cocolia_blind"].hsr_cocolia_markedJoker = false

                  if jokerIsMarked then
                     G.GAME["hsr_cocolia_blind"].hsr_cocolia_joker_destroyed = true
                     SMODS.calculate_effect({message = localize('hsr_destroyed')},jokerIsMarked)
                     jokerIsMarked:set_debuff(true)

                     G.E_MANAGER:add_event(Event({  --Change color of Chips and Mult UIs
                        func = (function()
                           play_sound('gong', 0.94, 0.3)
                           play_sound('gong', 0.94*1.5, 0.2)
                           play_sound('tarot1', 1.5)
                           ease_colour(G.C.UI_MULT, {0.267, 0.769, 1, 1})
                           ease_colour(G.C.UI_CHIPS, {0.267, 0.769, 1, 1})
                           G.E_MANAGER:add_event(Event({
                              trigger = 'after',
                              blockable = false,
                              blocking = false,
                              delay = 2.3,
                              func = (function() 
                                 ease_colour(G.C.UI_MULT, G.C.RED, 2)
                                 ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                                 return true
                              end)
                           }))
                           G.E_MANAGER:add_event(Event({
                              trigger = 'after',
                              blockable = false,
                              blocking = false,
                              no_delete = true,
                              delay = 3.3,
                              func = (function() 
                                 G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                                 G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                                 return true
                              end)
                           }))
                           return true
                        end)
                     }))

                     G.E_MANAGER:add_event(Event({ --Destroy the marked Joker
                        func = function()
                           jokerIsMarked.T.r = -0.2
                           jokerIsMarked:juice_up(0.3, 0.4)
                           jokerIsMarked.states.drag.is = true
                           jokerIsMarked.children.center.pinch.x = true
                
                           G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                 func = function()
                                    G.jokers:remove_card(jokerIsMarked)
                                    jokerIsMarked:remove()
                                    jokerIsMarked = nil
                                    return true; end})) 
                           return true
                        end
                     })) 
                  end
               end
            end

            if not G.GAME["hsr_cocolia_blind"].summonedLance then
               G.GAME["hsr_cocolia_blind"].summonedLance = true
               table.insert(G.GAME.blind.passives,"psv_hsr_Cocolia_summon")
               for i,v in pairs(G.GAME.blind.passives) do
                  if v == "psv_hsr_Cocolia_passive2_3" then table.remove(G.GAME.blind.passives,i) break end
               end

               SMODS.calculate_effect({message = localize('hsr_cocolia_summon')},G.GAME.blind)
            end

            if G.GAME["hsr_cocolia_blind"].summonedLance then
               if BalatroSR.numUniqueSuits(context.scoring_hand) >= 2 and BalatroSR.numUniqueRanks(context.scoring_hand) >= 2 then
                  for i,v in pairs(G.GAME.blind.passives) do
                     if v == "psv_hsr_Cocolia_summon" then table.remove(G.GAME.blind.passives,i) break end
                  end

                  SMODS.calculate_effect({message = localize('hsr_destroyed')},G.GAME.blind)
               end
            end

            if not jokerIsMarked then
               local randomJoker = pseudorandom_element(G.jokers.cards,pseudoseed("cocolia_mark"))
               if randomJoker then
                  G.GAME["hsr_cocolia_blind"].hsr_cocolia_markedJoker = true
                  buffJoker(nil,randomJoker,"cocolia_mark")
               end
            end

            BalatroSR.enhanceCard(nil,{G.play.cards[1]},"m_glass",nil,true,false,true)

            local poolCards = {}
            for _,v in ipairs(G.hand.cards) do
               if pseudorandom("hsr_cocomelon_rng") < 1/2 then
                  table.insert(poolCards,v)
               end
            end

            BalatroSR.enhanceCard(nil,poolCards,"m_glass")
         end

         if context.after then
            if G.GAME["hsr_cocolia_blind"].hsr_cocolia_joker_destroyed then
               G.GAME["hsr_cocolia_blind"].hsr_cocolia_joker_destroyed = false
               ease_chips(G.GAME.chips - (G.GAME.chips/2))
            end
         end

         if context.final_scoring_step and numOfLances > 0 then
            for _ = 1,numOfLances do
               SMODS.calculate_effect({xmult = 0.5},G.GAME.blind)
            end
         end
      end

      if G.GAME.current_round.phases_beaten == 2 then
         function hsr_cocolia_nuke_countdown()
            if (G.GAME["hsr_cocolia_blind"].hsr_cocolia_nukecountdown or 0) >= 7 then
               G.GAME["hsr_cocolia_blind"].hsr_cocolia_nukecountdown = 0

               local pool = {}
               local half = math.floor(#(G.playing_cards or {})/2)
               repeat
                  local toGrab = {}
                  for _,v in ipairs(G.playing_cards) do
                     local exist = false
                     if pool ~= {} then
                        for _,v2 in ipairs(pool) do
                           if v2 == v then exist = true break end
                        end
                     end

                     if not exist then
                        table.insert(toGrab,v)
                     end
                  end

                  pool[#pool+1] = pseudorandom_element(toGrab,pseudoseed("hsr_cocolia_nuke_choose"))
               until #pool >= half

               for _,v in ipairs(pool) do
                  local cardToBeDestroyed = v
                  G.E_MANAGER:add_event(Event({
                     trigger = "before",
                     delay = 0.1,
                     func = function()
                        cardToBeDestroyed:start_dissolve()
                        return true
                     end
                  }))
               end

               for _,v in ipairs(G.hand.cards) do
                  local cardToBeDestroyed = v
                  G.E_MANAGER:add_event(Event({
                     trigger = "before",
                     delay = 0.1,
                     func = function()
                        cardToBeDestroyed:start_dissolve()
                        return true
                     end
                  }))
               end

               G.E_MANAGER:add_event(Event({
                  func = (function()
                     local text = localize("hsr_cocolia_nuke")
                     attention_text({
                         scale = 1.4, text = text, hold = 5, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                     })
                     return true
                  end)
               }))

               G.GAME["hsr_cocolia_blind"].hsr_cocolia_nuked = true
            end
            G.GAME["hsr_cocolia_blind"].hsr_cocolia_nukecountdown = (G.GAME["hsr_cocolia_blind"].hsr_cocolia_nukecountdown or 0) + 1
            if not G.GAME["hsr_cocolia_blind"].hsr_cocolia_nuked then
               G.E_MANAGER:add_event(Event({
                  func = (function()
                     local text = tostring(G.GAME["hsr_cocolia_blind"].hsr_cocolia_nukecountdown)
                     attention_text({
                         scale = 1.4, text = text, hold = 5, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                     })
                     return true
                  end)
               }))
            end
         end

         if context.before or context.pre_discard then
            hsr_cocolia_nuke_countdown()
         end

         if context.pre_discard then
            ease_discard(1)
         end

         if context.final_scoring_step then
            return{
               xmult = 0.3,
               xchips = 0.3
            }
         end

         if context.after and G.GAME["hsr_cocolia_blind"].hsr_cocolia_nuked then
            G.GAME["hsr_cocolia_blind"].hsr_cocolia_nuked = false

            if to_big(G.GAME.chips) < to_big(G.GAME.blind.chips) then
               ease_chips(0)
            end
         end
      end
   end,
}

--[[SMODS.Blind({ fwiend's blind
   key = 'better_roller',
   loc_txt = {
       name = 'The Better Roller',
       text = {
           'Roll a number between 1 and 6.',
           'Blind rolled: #1#',
           'You rolled: #2#'
       }
   },
   pos = { x = 0, y = 40 },
   dollars = 5,
   mult = 2,
   boss = { min = 1, max = 10 },
   boss_colour = HEX('FFD700'), -- Gold to represent luck
   config = { extra = { blind_roll = 0, player_roll = 0 } },

   -- Function to dynamically update the displayed rolls
   loc_vars = function(self)
       return { vars = { self.config.extra.blind_roll, self.config.extra.player_roll } }
   end,

   cry_cap_score = function(self,score)
      local supposedScore = score
      if self.config.extra.player_roll < self.config.extra.blind_roll then supposedScore = -supposedScore end
      if self.config.extra.player_roll == self.config.extra.blind_roll then supposedScore = 0 end
      return supposedScore
   end,

   -- Function to handle the rolling mechanic
   press_play = function(self)
       print("[DEBUG] Better Roller Blind triggered.")

       local blind_roll = math.random(1, 6)
       self.config.extra.blind_roll = blind_roll
       print("[DEBUG] Blind rolled:", blind_roll)

       local player_roll = math.random(1, 6)
       self.config.extra.player_roll = player_roll
       print("[DEBUG] Player rolled:", player_roll)

       G.GAME.blind:set_text()

       local scored_chips = to_big(context and context.d_scored_chips or 0)
       print(string.format("[DEBUG] Initial d_scored_chips: %s", scored_chips))

       if player_roll > blind_roll then
           print("[DEBUG] Player wins the roll! Chips are added.")
           G.GAME.blind.triggered = true
           print(string.format("[DEBUG] d_scored_chips remains positive: %s", scored_chips))
       elseif player_roll < blind_roll then
           print("[DEBUG] Blind wins the roll! Chips are subtracted.")
           G.GAME.blind.triggered = true
           if context then
               print(string.format("[DEBUG] d_scored_chips set to negative: %s", context.d_scored_chips))
           end
       else
           print("[DEBUG] It's a tie! No chips are gained or lost.")
           G.GAME.blind.triggered = false
           print(string.format("[DEBUG] d_scored_chips unchanged on tie: %s", scored_chips))
       end
   end
})]]