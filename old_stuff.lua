--[[This is where I archive unused/old assets which went unused.

i immediately forgot to archive yanqing lmfao oh well

SMODS.Joker{ --Arlan
   key = 'Arlan', 
   config = { 
      extra = CardStats["config"]["Arlan"]
   },
   loc_txt = { 
        name = 'Arlan',
        text = {
          'cute blacc boi'
        },
   },
   atlas = 'Jokers', 
   rarity = 3, 
   cost = 1, 
   unlocked = true, 
   discovered = true, 
   blueprint_compat = true, 
   eternal_compat = true, 
   perishable_compat = false, 
   in_pool = false,
   pos = {x = 1, y = 0}, 

   update = function(self, card, dt)
      loadRelics(card)
    end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      local outsideVars = calculateRelics(extraStuff, nil, card.ability.extra.element, card)

      if context.individual and context.cardarea == G.play then
            if card.ability.extra.currentEidolon >= 6 then
               if context.other_card:is_suit("Spades") or context.other_card:is_suit("Clubs") then
                  local currentMoney = G.GAME.dollars
                  local multi = math.floor(currentMoney/5)
                  local MultMulti = 1 + (0.02 * multi)
                  if MultMulti >= card.ability.extra.e4cap then MultMulti = card.ability.extra.e4cap end
                  return {
		         		mult = calculateBaseMulti(card,card.ability.extra.element,15,outsideVars,false,nil,context.other_card),
                     x_mult = calculateBaseMulti(card,card.ability.extra.element,MultMulti,outsideVars,false,nil,context.other_card),
                     chips = calculateBaseMulti(card,card.ability.extra.element,50,outsideVars,false,nil,context.other_card), 
                     dollars = 1,
                     card = card,
		            }
                end 
            else
                if card.ability.extra.currentEidolon >= 5 then
                   if context.other_card:is_suit("Spades") then
                        local currentMoney = G.GAME.dollars
                        local multi = math.ceil(currentMoney/5)
                        local MultMulti = 1 + (0.02 * multi)
                        if MultMulti >= card.ability.extra.e4cap then MultMulti = card.ability.extra.e4cap end
                      	return {
                           mult = calculateBaseMulti(card,card.ability.extra.element,15,outsideVars,false,nil,context.other_card),
                           x_mult = calculateBaseMulti(card,card.ability.extra.element,MultMulti,outsideVars,false,nil,context.other_card),
                           chips = calculateBaseMulti(card,card.ability.extra.element,50,outsideVars,false,nil,context.other_card), 
                           dollars = 1,
                           card = card,
	          	       	}
                    end 
                elseif card.ability.extra.currentEidolon >= 4 then
                    if context.other_card:is_suit("Spades") then
                      	local currentMoney = G.GAME.dollars
                        local multi = math.ceil(currentMoney/5)
                        local MultMulti = 1 + (0.02 * multi)
                        if MultMulti >= card.ability.extra.e4cap then MultMulti = card.ability.extra.e4cap end
                      	return {
                           mult = calculateBaseMulti(card,card.ability.extra.element,15,outsideVars,false,nil,context.other_card),
                           x_mult = calculateBaseMulti(card,card.ability.extra.element,MultMulti,outsideVars,false,nil,context.other_card),
                           chips = calculateBaseMulti(card,card.ability.extra.element,50,outsideVars,false,nil,context.other_card), 
                           card = card,
	          	       	}
                    end 
                elseif card.ability.extra.currentEidolon >= 2 then
                    if context.other_card:is_suit("Spades") then
                     return {
                        mult = calculateBaseMulti(card,card.ability.extra.element,15,outsideVars,false,nil,context.other_card),
                        card = card,
	          	     	}
                    end 
                else
                    if context.other_card:is_suit("Spades") then
                     return {
                        mult = calculateBaseMulti(card,card.ability.extra.element,card.ability.extra.multGain,outsideVars,false,nil,context.other_card),
                        card = card,
	         	     	}
                    end 
                end
            end
        end

        local ret = HSRContextHandler(self,card,context) 
        if ret then
           return ret
        end
     end,
  
     generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
        local speedIncrease = 0
        local cardAbility = center.ability
     
        local allBuffs = CardStats["CharacterBuffs"]
        for _, character in pairs(allBuffs) do --Load buffs relating to Speed and Retriggers.
           for buffName, buff in pairs(character) do
              if cardAbility[buffName] then
                 for spcBuffName, spcBuff in pairs(buff) do --Add buff's effects accordingly.
                    if spcBuffName == "speed" then
                       speedIncrease = speedIncrease + spcBuff * (cardAbility[buffName.."_stack"] or 1)
                    end
                 end
              end
           end
        end
  
        local returnVar = {
           center.ability.extra.currentEidolon, --1
           center.ability.extra.type, --2
           center.ability.extra.element, --3
           center.ability.extra.head, --4
           center.ability.extra.body, --5
           center.ability.extra.hands, --6
           center.ability.extra.feet, --7
           center.ability.extra.headName,--8 
           center.ability.extra.bodyName, --9
           center.ability.extra.handsName, --10
           center.ability.extra.feetName,--11
           center.ability.extra.headEffect,--12
           center.ability.extra.bodyEffect,--13
           center.ability.extra.handsEffect,--14
           center.ability.extra.feetEffect,--15
           center.ability.extra.twopcssetEffect,--16
           center.ability.extra.fourpcssetEffect,--17
           center.ability.extra.page,--18
           center.ability.extra.max_page,--19
           ---Stats
           (center.ability.extra.speed + speedIncrease), --20
         center.ability.extra.excess_action_value, --21
         center.ability.extra.j_atk, --22
         center.ability.extra.j_bee, --23
         center.ability.extra.j_elementMulti, --24
         center.ability.extra.otherStats, --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --
         center.ability.extra.chip, 
         center.ability.extra.multGain,
         center.ability.extra.e3mult, 
         center.ability.extra.e4cap, 
      }
      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,

}

]]