local AsrielSkills = {
    {
       ["Name"] = "Shocker Breaker",
       ["Description"] = {
          "Every 3 seconds, marks a random card in hand.",
          "If its position is unchanged after 3s, destroys it",
       }
    }
 }
 
 ---...?
 local game_updateref = Game.update
 function Game.update(self, dt)
    if G and G.GAME and G.GAME.blind and (G.GAME.blind.name == "bl_hsr_Asriel") then
       --[[ Reminds me to use this when their skill changes.
       self.asriel_skill_text:remove()
       self.asriel_skill_text = nil
       ]]
 
       --Skill text stuff.
       if not self.asriel_skill_text then
          self.asriel_skill_text = UIBox {
             definition =
             {n = G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes = {
                {n = G.UIT.C, config = {align = 'cm', maxw = 1}, nodes = {
                   {n = G.UIT.C, config = {align = 'cm', maxw = 1}, nodes = {
                      {n = G.UIT.O, config = {object = DynaText({scale = 0.8, string = AsrielSkills[1]["Name"], maxw = 9, colours = { G.C.WHITE }, float = true, shadow = true, silent = true})}},
                   }},
                }},
             }},
             config = {
                align = 'cm',
                offset = {x = 0, y = -3.5},
                major = G.play,
             }
          }
          self.asriel_skill_text.attention_text = true
          self.asriel_skill_text.states.collide.can = false
       end
 
       if not self.asriel_skill_description1 then
          self.asriel_skill_description1 = UIBox {
             definition =
             {n = G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes = {
                {n = G.UIT.C, config = {align = 'cm', maxw = 1}, nodes = {
                   {n = G.UIT.C, config = {align = 'cm', maxw = 1}, nodes = {
                      {n = G.UIT.O, config = {object = DynaText({scale = 0.5, string = AsrielSkills[1]["Description"][1], maxw = 9, colours = { G.C.WHITE }, float = true, shadow = true, silent = true})}},
                   }},
                }},
             }},
             config = {
                align = 'cm',
                offset = {x = 0, y = -2.85},
                major = G.play,
             }
          }
          self.asriel_skill_description1.attention_text = true
          self.asriel_skill_description1.states.collide.can = false
       end
 
       if not self.asriel_skill_description2 then
          self.asriel_skill_description2 = UIBox {
             definition =
             {n = G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes = {
                {n = G.UIT.C, config = {align = 'cm', maxw = 1}, nodes = {
                   {n = G.UIT.C, config = {align = 'cm', maxw = 1}, nodes = {
                      {n = G.UIT.O, config = {object = DynaText({scale = 0.5, string = AsrielSkills[1]["Description"][2], maxw = 9, colours = { G.C.WHITE }, float = true, shadow = true, silent = true})}},
                   }},
                }},
             }},
             config = {
                align = 'cm',
                offset = {x = 0, y = -2.4},
                major = G.play,
             }
          }
          self.asriel_skill_description2.attention_text = true
          self.asriel_skill_description2.states.collide.can = false
       end
    else
       if self.asriel_skill_text then
          self.asriel_skill_text:remove()
          self.asriel_skill_text = nil
       end
       if self.asriel_skill_description1 then
          self.asriel_skill_description1:remove()
          self.asriel_skill_description1 = nil
       end
       if self.asriel_skill_description2 then
          self.asriel_skill_description2:remove()
          self.asriel_skill_description2 = nil
       end
    end
    game_updateref(self, dt)
 end
 
 SMODS.Blind{ --Asriel
    key = 'Asriel',
    loc_txt = {
       name = 'Asriel',
       text = {
          'God of Hyperdeath'
       }
    },
    config = {extra = {hsr_blindType = "Small"}},
    dollars = 5,
    mult = 5,
    boss_colour = darken(HEX('FFFFFF'),0.2),
    boss = {min = 5, max = 5},
    in_pool = function(self)
      return false
    end,
    set_blind = function(self)
       hsr_restart_music()
       G.GAME.asriel_current_skill = math.floor(pseudorandom("hsr_asriel_randomskill",1,#AsrielSkills))
    end,
 }
 
 local hookTo = G.FUNCS.play_cards_from_highlighted
 G.FUNCS.play_cards_from_highlighted = function(e) --To randomly choose skills.
    local ret = hookTo(e)
    G.GAME.asriel_current_skill = math.floor(pseudorandom("hsr_asriel_randomskill",1,#AsrielSkills))
    return ret
 end
 
 local test_asriel_window_move = true
 local animtimer = 0
 
 local loveupdateref = love.update --notmario code
 function love.update(dt)
    loveupdateref(dt)
    x, y, displayindex = love.window.getPosition()
    d_width, d_height = love.window.getDesktopDimensions(displayindex)
    w_width, w_height, flags = love.window.getMode()
 
    --Rainbow Background, perhaps.
    if G and G.GAME and G.GAME.blind and (G.GAME.blind.name == "bl_hsr_Asriel") then
       Rainbow()
 
       if G.hsr_asriel_bg_triggered then
          ease_background_colour{new_colour = HEX(BalatroSR.convert_to_hex(Ctbl.r..","..Ctbl.g..","..Ctbl.b)), special_colour = HEX(BalatroSR.convert_to_hex(Ctbl.r..","..Ctbl.g..","..Ctbl.b)), tertiary_colour = darken(HEX(BalatroSR.convert_to_hex(Ctbl.r..","..Ctbl.g..","..Ctbl.b)), 0.5), contrast = 3}
       else
          if (G.hsr_asriel_music_timer or 0) >= 22.5 then
             G.hsr_asriel_bg_triggered = true
          elseif (G.hsr_asriel_music_timer or 0) >= 15 then
             ease_background_colour{new_colour = HEX("FFFFFF"), special_colour = HEX("FFFFFF"), tertiary_colour = HEX("FFFFFF"), contrast = 0}
          else
             ease_background_colour{new_colour = HEX(BalatroSR.convert_to_hex("0,0,0")), special_colour = HEX(BalatroSR.convert_to_hex("0,0,0")), tertiary_colour = HEX(BalatroSR.convert_to_hex("0,0,0")), contrast = 0}
          end
 
          if not G.hsr_asriel_bg_triggered then G.hsr_asriel_music_timer = (G.hsr_asriel_music_timer or 0) + dt end
       end
    end
 
    if test_asriel_window_move and G and G.GAME and G.GAME.blind and (G.GAME.blind.name == "bl_hsr_Asriel") then
       --Skills.
       if G.GAME.asriel_current_skill then
          if G.GAME.asriel_current_skill == 1 then
             G.asriel_countdown1 = (G.asriel_countdown1 or 0) + dt
             if G.asriel_countdown1 >= 2 then
                G.asriel_countdown1 = 0
                print("use skill 1")
 
                local checkTable = {}
                for _,v in ipairs(G.hand.cards or {}) do
                   if cardHasDebuff(v,"asriel_skill1_mark") then
                      checkTable[#checkTable+1] = v
                      if v.ability["asriel_saved_position"] ~= BalatroSR.findLocation(v,G.hand) then
                         clearCardDebuff(v,"asriel_skill1_mark",nil,"Unmarked!",true)
                      else
                         G.E_MANAGER:add_event(Event({
                            trigger = "immediate",
                            delay = 0.0,
                            func = function()
                               play_sound('tarot1')
                               v.T.r = -0.2
                               v:juice_up(0.3, 0.4)
                               v.states.drag.is = true
                               v.children.center.pinch.x = true
 
                               G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                               func = function()
                                  v:remove()
                               return true; end})) 
                               return true
                            end
                         }))
                      end
                   end
                end
 
                for _,v in ipairs(G.playing_cards) do
                   local invalid = false
                   for _,v2 in ipairs(checkTable) do
                      if v2 == v then invalid = true break end
                   end
 
                   if not invalid and cardHasDebuff(v,"asriel_skill1_mark") then
                      clearCardDebuff(v,"asriel_skill1_mark",nil,"Unmarked!",true)
                   end
                end
 
                local validPool = {}
                for _,v in ipairs(G.hand.cards or {}) do
                   if not cardHasDebuff(v,"asriel_skill1_mark") then
                      validPool[#validPool+1] = v
                   end
                end
 
                if #validPool > 0 then
                   local selectedCard = pseudorandom_element(validPool,pseudoseed("hsr_asriel_skill1_choose"))
                   inflictDebuff(G.GAME.blind,selectedCard,"asriel_skill1_mark","Marked!",true)
                   selectedCard.ability["asriel_saved_position"] = BalatroSR.findLocation(selectedCard,G.hand)
                end
             end
          end
       end
 
       was_fighting_asriel = true
       --[[How to calculate x,y:
       w_width, w_height refer to the size of the window.
       d_width, d_height refer to the screen's size.
  
       finalx = d_width/2 - w_width/2 --Center X.
       finaly = d_height/2 - w_height/2 --Center Y.
 
       ]]
       animtimer = animtimer + dt * 2
       m_width = d_width - w_width
       m_height = d_height - w_height
       local animspeed = 0.5
       if not flags.fullscreen then
           --[[ Pendulum Movement
           local newX = (math.sin(animtimer) + 1) / 2 * (m_width - 64) + 32
           local newY = (math.cos(animtimer * 2) + 1) / 2 * (m_height - 64) + 32
           ]]
           --[[ Circling Movement
           local newX = (math.sin(animtimer) + 1) / 2 * (m_width - 64) + 32
           local newY = (math.cos(animtimer) + 1) / 2 * (m_height - 64) + 32
           ]]
 
          --Those are the ones.
          if G.STATE and G.STATE == 2 then
             local des_x = d_width/2 - w_width/2
             local des_y = d_height/2 - w_height/2
 
             local newX = x - (x - des_x)/5
             local newY = y - (y - des_y)/5
             love.window.setPosition(newX, newY)
 
             animtimer = 0
             asriel_go_back = 10
          else
             local des_x = (math.cos(animtimer * animspeed) + 1) / 2 * (m_width - 64) + 32
             local des_y = (math.sin(animtimer * 2 * animspeed) + 1) / 2 * (m_height - 64) + 32
 
             local newX = x - (x - des_x)/(asriel_go_back or 1.01)
             local newY = y - (y - des_y)/(asriel_go_back or 1.01)
 
             if asriel_go_back and asriel_go_back > 1.01 then
                asriel_go_back = asriel_go_back - 0.4
                if asriel_go_back <= 1.01 then asriel_go_back = 1.01 end
             end
 
             love.window.setPosition(newX, newY)
          end
       end
    else
       if was_fighting_asriel then
          was_fighting_asriel = false
          tween_go_back = 20
       end
 
       if (tween_go_back or 0) > 0 then
          local des_x = d_width/2 - w_width/2
          local des_y = d_height/2 - w_height/2
 
          local newX = x - (x - des_x)/5
          local newY = y - (y - des_y)/5
          love.window.setPosition(newX, newY)
 
          tween_go_back = math.max(tween_go_back - 1,0)
       end
 
    end
 end