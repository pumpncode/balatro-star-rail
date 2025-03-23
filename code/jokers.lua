BalatroSR = SMODS.current_mod

local CardStats = returnText("CardStats")
local RelicSetEffects = returnText("RelicSetEffects")
local AllSuits = {
   "Hearts", "Clubs", "Spades", "Diamonds"
}
--SetRunningAnimations({"j_hsr_Trash", 0.1, 1, 0, "loop"}, {"j_hsr_Yanqing", 0.1, 1, 0, "loop"})

--Jokers' functions.

function getHSRJokerName(card) --Grab the name of a HSR Joker from its key.
   return card.config.center.key:gsub("j_hsr_","")
end

function isHSRJoker(card) --Check if the joker is from Balatro Star Rail.
   if string.find(card.config.center.key,"j_hsr_") then
      return true
   else
      return false
   end
end

function loadStats(card) --Load stats for Playing Cards and HSR Jokers.
   if card.ability then
      for i,v in pairs(CardStats) do
         if v == "Characters" then
            for d,p in pairs(v) do
               for e,g in pairs(p) do
                  if not card.ability[g] then
                     card.ability[g] = nil
                  end
               end
            end
         else
            for d,p in pairs(v) do
               if not card.ability[p] then
                  card.ability[p] = nil
               end
            end
         end
      end
   end
end

function calculateBaseMulti(card, element, num, _, isDot, is_x_gain, cardInHand) --Calculation stuff for HSR Joker.
   if is_x_gain and num == 1 then return 1 end
   if num == 0 then return 0 end

   local debug = false
   if card.ability then
      local cardAbility = card.ability
      local extraStuff = cardAbility.extra
      local cardInHandAbility = cardInHand.ability
      loadStats(card)
      local elementMulti = (BalatroSR.readBuffs(card))["elementMulti"]
      local atkMulti = (BalatroSR.readBuffs(card))["atkMulti"]

      local def_reduction = cardInHandAbility.def_reduction or 0
      local dmg_taken_multi = cardInHandAbility.dmg_taken or 0
      local dot_multi = cardInHandAbility.dotMulti or 0

      if not isDot then
         if debug then
            print(element.."_res_pen:"..(((cardInHandAbility[element.."_res_pen"] or 0) + (cardInHandAbility.all_type_res_pen or 0))/100).." (all_type_res_pen:"..(((cardInHandAbility.all_type_res_pen or 0))/100)..")")
            print("def_reduction:"..((def_reduction or 0))/100)
            print("dmg_taken_multi:"..((dmg_taken_multi or 0))/100)
            print("elementMulti:"..(elementMulti or 1))
            print("gainEfficiency:"..(extraStuff["gainEfficiency"] or 1))
            print("---------------------------------------------------------")
         end
         local FinalRes = BalatroSR.multiplyAll(num, {
            (1 + (((cardInHandAbility[element.."_res_pen"] or 0) + (cardInHandAbility.all_type_res_pen or 0))/100)), --Element Res Penetration
            atkMulti, --Attack Multiplier
            elementMulti, --Element Multiplier
            (1 + ((def_reduction or 0)/100)), --Def Reduction
            (1 + ((dmg_taken_multi or 0)/100)), --DMG Taken
            (extraStuff["gainEfficiency"] or 1), --Gain Efficiency
         })
         return FinalRes
      elseif isDot then
         if debug then
            print(element.."_res_pen:"..(((cardInHandAbility[element.."_res_pen"] or 0) + (cardInHandAbility.all_type_res_pen or 0))/100).." (all_type_res_pen:"..(((cardInHandAbility.all_type_res_pen or 0))/100)..")")
            print("def_reduction:"..((def_reduction or 0))/100)
            print("dmg_taken_multi:"..((dmg_taken_multi or 0))/100)
            print("dotMulti:"..((dot_multi or 0)/100))
            print("elementMulti:"..(elementMulti or 1))
            print("gainEfficiency:"..(extraStuff["gainEfficiency"] or 1))
            print("---------------------------------------------------------")
         end
         local FinalRes = BalatroSR.multiplyAll(num, {
            (1 + (((cardInHandAbility[element.."_res_pen"] or 0) + (cardInHandAbility.all_type_res_pen or 0))/100)), --Element Res Penetration
            atkMulti, --Attack Multiplier
            elementMulti, --Element Multiplier
            (1 + ((def_reduction or 0)/100)), --Def Reduction
            (1 + ((dmg_taken_multi or 0)/100)), --DMG Taken
            (1 + (dot_multi or 0)/100), --DOT Multiplier
            (extraStuff["gainEfficiency"] or 1), --Gain Efficiency
         })
         return FinalRes
      end
   end
end

function loadRelics(card) --Load Relic names/descriptions/effects into a HSR Joker.
   local alike = {}
   local hasSetBonus = false

   function addIntoTable(a)
      if alike[a] then
         alike[a] = alike[a] + 1
      else
         alike[a] = 1
      end
   end

   local extra = card.ability.extra
   local bodyParts = {
      "head", "body", "hands", "feet"
   } --freaky ahh table name :sob:

   for i = 1, #bodyParts do
      local part = bodyParts[i]
      local relic = extra[part]

      if relic then
         extra[part.."Name"] = RelicSetEffects["config"][relic]["Name"]
         extra[part.."Effect"] = RelicSetEffects["config"][relic]["Effect"]
         addIntoTable(relic)
      else
         extra[part.."Name"] = "None"
         extra[part.."Effect"] = "None"
      end
   end

   for i,v in pairs(alike) do
      if v >= 2 then
         hasSetBonus = true
      end
   end

   if hasSetBonus then
      local twoEffect = extra.twopcssetEffect
      local fourEffect = extra.fourpcssetEffect
      twoEffect = ""
      fourEffect = ""

      for i,v in pairs(alike) do
         if v >= 2 then
            if twoEffect == "" then
               twoEffect = BalatroSR.toNormalString(RelicSetEffects["2pcs"][i],RelicSetEffects["config"][i]["twopcsBonus"])
            else
               twoEffect = twoEffect.." | "..BalatroSR.toNormalString(RelicSetEffects["2pcs"][i],RelicSetEffects["config"][i]["twopcsBonus"])
            end
         end

         if v >= 4 then
            if fourEffect == "" then
               fourEffect = BalatroSR.toNormalString(RelicSetEffects["4pcs"][i],RelicSetEffects["config"][i]["fourpcsBonus"])
            else
               twoEffect = twoEffect.." | "..BalatroSR.toNormalString(RelicSetEffects["4pcs"][i],RelicSetEffects["config"][i]["fourpcsBonus"])
            end
         end
      end

      if fourEffect == "" then
        fourEffect = "None"
      end

      card.ability.extra.twopcssetEffect = twoEffect
      card.ability.extra.fourpcssetEffect = fourEffect
   else
      card.ability.extra.twopcssetEffect = "None"
      card.ability.extra.fourpcssetEffect = "None"
   end

end

function addEidolon(self,card,context) --Eidolon handler for HSR Jokers.
   if context.ending_shop and not context.blueprint then
      G.E_MANAGER:add_event(Event({
         blockable = true,
         trigger = "before",
         delay = 0.3,
         func = function()
            local pos = nil
            local incremental = 1
            if card.ability.extra.currentEidolon >= 6 then return true end
            for i = 1,#G.jokers.cards do
               local targetcard = G.jokers.cards[i]
               if targetcard == card then
                  pos = i
                  break
               end
            end

            if pos then
               local targetcard = G.jokers.cards[pos+incremental]
               repeat
                  targetcard = G.jokers.cards[pos+incremental]
                  if targetcard then
                  if targetcard ~= card and targetcard.config.center.key == card.config.center.key then --Check for the card on the right.
                     card:juice_up(0.8, 0.8)
                     targetcard:start_dissolve({G.C.RED}, nil, 1.6)
                     card.ability.extra.currentEidolon = card.ability.extra.currentEidolon + targetcard.ability.extra.currentEidolon + 1
                     if card.ability.extra.currentEidolon >= 6 then
                        card.ability.extra.currentEidolon = 6
                     end
                  end
                  incremental = incremental + 1
               end
               until not targetcard or card.ability.extra.currentEidolon >= 6
            end
            return true
         end
        }))
   end
end

function HSRContextHandler(self,card,context,contextTable,specificDestroyContext) --Put this in every HSR Joker. contextTable is used to tell HSRContextHandler to ignore certain automated contexts, useful for adding your own context.
   local ret = nil
   local speedIncrease = 0
   local cardAbility = card.ability
   local ability = cardAbility.extra

   local allBuffs = CardStats["CharacterBuffs"]
   for _, character in pairs(allBuffs) do --Load buffs relating to Speed and Retriggers.
      for buffName, buff in pairs(character) do
         if cardAbility[buffName] then
            for spcBuffName, spcBuff in pairs(buff) do --Add buff's effects accordingly.
               if spcBuffName == "speed" then
                  speedIncrease = speedIncrease + spcBuff * (cardAbility[buffName.."_stack"] or 1)
               elseif spcBuffName == "retrigger" then
                  card.ability.extra["self_retriggers"] = card.ability.extra["self_retriggers"] + spcBuff * (cardAbility[buffName.."_stack"] or 1)
               end
            end
         end
      end
   end

   if ability.handUsage then
      IncreaseHandUsage(self,card,context,ability.handUsage)
   end

   local speed = ability["speed"]
   local speed_calc = (ability["speed"] + speedIncrease) - 100

   if speed_calc < 0 then speed_calc = 0 end

   if not contextTable or (contextTable and not contextTable["destroy_card"]) then
      if context.destroying_card then
         if context.destroying_card["hsr_to_be_destroyed"] then
            return {
               remove = true
            }
         end
      end

      if context.destroy_card then
         if context.destroy_card["hsr_to_be_destroyed"] then
            return {
               remove = true
            }
         end
      end
   end

   if context.before and context.cardarea == G.jokers and not context.retrigger_joker then --Remove self_retriggers at the start of each hand.
      card.ability.extra["self_retriggers"] = 0

      if card.ability.extra["self_retriggers"] < 1 then card.ability.extra["excess_action_value"] = card.ability.extra["excess_action_value"] + speed_calc end
      if card.ability.extra["excess_action_value"] >= 100 then
         for i = 1, math.floor(card.ability.extra["excess_action_value"]/100) do
            card.ability.extra["excess_action_value"] = card.ability.extra["excess_action_value"] - 100
            card.ability.extra["self_retriggers"] = card.ability.extra["self_retriggers"] + 1
         end
      end

      local RB = BalatroSR.readBuffs(card)
      if RB and RB["alike"] and (RB["alike"]["passerby"] or 0) >= 4 then
         card.ability.extra["self_retriggers"] = card.ability.extra["self_retriggers"] + 1
      end
   end

   if context.joker_main then
      ret = HSRJokerMain(self,card,context)
   end

   if context.retrigger_joker_check and context.other_card == card then
      if card.ability.extra["self_retriggers"] >= 1 then
         local retriggerTimes = card.ability.extra["self_retriggers"]

         ret = {
            repetitions = retriggerTimes
         }
      end
   end

   if context.ending_shop and not context.blueprint then
      ret = addEidolon(self,card,context)
   end

   if ret then
      return ret
   end
end

local CheckBuffDebug = false
function HSRJokerMain(self,card,context) --joker_main for HSR Jokers. 
   local cardAbility = card.ability
   local extraStuff = cardAbility.extra
   
   local extraMult = 0
   local extraChips = 0
   local extraxMult = 0
   local extraxChip = 0
   local bee = 1
   local elementMulti = 1
   local alike = (BalatroSR.readBuffs(card))["alike"]

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

   if card.ability and card.ability.extra then --Load jokerGains, eidolonGains.
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

      for _,v in pairs(stuffToCheck) do
         if card.ability.extra[v] then
            jokerGains[v] = card.ability.extra[v]
         end
      end
   end
   --turned out, jokerGains is fucking used in calculateRelics, what.

   local allBuffs = CardStats["CharacterBuffs"]
   if CheckBuffDebug then
     print("Begin Checking Buffs:")
   end
   for _,character in pairs(allBuffs) do --Load buffs.
      for buffName, buff in pairs(character) do
         if cardAbility[buffName] then
            if cardAbility[buffName.."_duration"] and tonumber(cardAbility[buffName.."_duration"]) and tonumber(cardAbility[buffName.."_duration"]) > 0 then --Reduce buff duration.
               cardAbility[buffName.."_duration"] = cardAbility[buffName.."_duration"] - 1
               if cardAbility[buffName.."_duration"] <= 0 then --Remove buff if duration is below 0.
                  clearBuffJoker(card,card,buffName)
               end
            end

            --[[for spcBuffName, spcBuff in pairs(buff) do --Add buff's effects accordingly.
               if CheckBuffDebug then
                  print("---")
                  print("Buff Name: "..buffName)
                  print("Buff Stacks: "..(cardAbility[buffName.."_stack"] or "None"))
               end
               if spcBuffName == "mult" then
                  extraMult = extraMult + spcBuff * (cardAbility[buffName.."_stack"] or 1)
               elseif spcBuffName == "chip" then
                  extraChips = extraChips + spcBuff * (cardAbility[buffName.."_stack"] or 1)
               elseif spcBuffName == "xMult" then
                  extraxMult = (extraxMult or 1) * (1 + (spcBuff - 1) * (cardAbility[buffName.."_stack"] or 1))
               elseif spcBuffName == "xChip" then
                  extraxChip = (extraxChip or 1) * (1 + (spcBuff - 1) * (cardAbility[buffName.."_stack"] or 1))
               elseif spcBuffName == "bee" then
                  bee = (bee or 1) * (1 + (spcBuff - 1) * (cardAbility[buffName.."_stack"] or 1))
               elseif spcBuffName == "elementMulti" then
                  elementMulti = (elementMulti or 1) * (1 + (spcBuff - 1) * (cardAbility[buffName.."_stack"] or 1))
               end
            end]]
         end
      end
   end

   extraMult = (BalatroSR.readBuffs(card))["mult"]
   extraChips = (BalatroSR.readBuffs(card))["chip"]
   extraxMult = (BalatroSR.readBuffs(card))["xMult"]
   extraxChip = (BalatroSR.readBuffs(card))["xChip"]
   bee = (BalatroSR.readBuffs(card))["bee"]
   elementMulti = (BalatroSR.readBuffs(card))["elementMulti"]

   if context.joker_main and not extraStuff["noGains"] then
      -----------------------------------
      --Some stuff to make sure x_mult and x_chips will not break themselves under certain circumstances which I will probably already forget if you (or me) are reading this.
      local xMult = extraxMult
      if xMult ~= 1 then
         xMult = xMult * bee * elementMulti * (extraStuff["gainEfficiency"] or 1)
         if xMult < 1 then --...You wouldn't want Jokers to give x0.1 Mult, would you?
            xMult = 1
         end
      end

      local xChip = extraxChip
      if xChip ~= 1 then
         xChip = xChip * bee * elementMulti * (extraStuff["gainEfficiency"] or 1)
         if xChip < 1 then
            xChip = 1
         end
      end
      -----------------------------------

      if extraMult ~= 0 or extraChips ~= 0 or xMult ~= 1 or xChip ~= 1 then
         return{
            card = card,
            chips = extraChips * bee * elementMulti * (extraStuff["gainEfficiency"] or 1),
            x_mult = xMult,
            xchips = xChip,
            mult = extraMult * bee * elementMulti * (extraStuff["gainEfficiency"] or 1),
            --no_retrigger = true,
         }
      end
   end

end

function IncreaseHandUsage(self,card,context,num) --For HSR Jokers which use more Hands, like Arlan and Blade.
   local currentHand = G.GAME.current_round.hands_left
   local maxHand = G.GAME.round_resets.hands
   local handConsumption = num

   if context.before and context.cardarea == G.jokers and not context.blueprint then --Drain More Hands
      if currentHand <= handConsumption then --Preventing situations where you have 3 hands, but it consumes 3 more hands so it drains you down to -1 hands.
         handConsumption = currentHand
      end
      G.GAME.current_round.hands_left = currentHand - handConsumption
   end
end

function clearDebuff() --Clear all debuffs on Playing Cards. (usually reserved for end of round stuffs)
   for _, v in ipairs(G.playing_cards) do
      SMODS.Stickers["hsr_pc_debuff"]:apply(v,false)
      for _,c in pairs(CardStats.CharacterDebuffs) do
         for p,_ in pairs(c) do
            if v.ability then
               if v.ability[p] then
                  v.ability[p] = nil
                  if v.ability[p.."_duration"] then
                     v.ability[p.."_duration"] = nil
                  end
                  for _,d in pairs(CardStats.ElementReductionStats) do
                     v.ability[d] = 0
                  end
                  for _,d in pairs(CardStats.Debuffs) do
                     v.ability[d] = 0
                  end
               end
            end
         end
      end
   end
end

function clearJokerBuffs() --Clear all buffs from Jokers at the end of round.
   local allBuffs = CardStats["CharacterBuffs"]

   for _,card in ipairs(G.jokers.cards) do
      if isHSRJoker(card) then
         local cardAbility = card.ability

         for buffName,_ in pairs(cardAbility) do
            for _,chr in pairs(allBuffs) do
               if chr[buffName] and (not chr[buffName]["remain_end_of_round"] or (chr[buffName]["remain_end_of_round"] and chr[buffName]["remain_end_of_round"] == false)) then
                  clearBuffJoker(card,card,buffName)
               end
            end
         end
      end
   end
end

function cardHasDebuff(cardInHand, debuffs) --Check if a card has debuffs, or specific debuffs if declared.
   if debuffs then
      if type(debuffs) == "string" then
         for i,_ in pairs(cardInHand.ability) do
            if BalatroSR.checkForIdenticalDebuff(i,debuffs) then
               return true
            end
         end

         return false
      elseif type(debuffs) == "table" then
         for i,v in pairs(debuffs) do
            local passed = false
            for i2,_ in pairs(cardInHand.ability) do
               if BalatroSR.checkForIdenticalDebuff(i2,v) then
                  passed = true
                  break
               end
            end
            if not passed then return false end
         end
         return true
      end
   else
      for i,v in pairs(CardStats["CharacterDebuffs"]) do
         for i2,v2 in pairs(v) do
            if cardInHand.ability[i2] then return true end
         end
      end
   
      return false
   end
end

function clearCardDebuff(cardInHand, debuff, stack_to_remove) --To clear specific debuffs from playing cards. If stack is declared, reduces by that amount of stacks. Else, removes the debuff entirely.
   if cardInHand.ability and cardHasDebuff(cardInHand,debuff) then
      local findDebuff = nil
      for i,v in pairs(CardStats["CharacterDebuffs"]) do
         for i2,v2 in pairs(v) do
            if i2 == debuff then
               findDebuff = v2
               break
            end
         end
      end
      if not findDebuff then print("Debuff can't be found. [function: clearCardDebuff]") return end

      local stats = CardStats["Debuffs"]
      local elementstats = CardStats["ElementReductionStats"]
   
      local stack = 1
      if type(cardInHand.ability[debuff]) == "number" then
         stack = cardInHand.ability[debuff]
      end

      if not stack_to_remove then
         for _,stat in pairs(stats) do
            if findDebuff[stat] then
               cardInHand.ability[stat] = cardInHand.ability[stat] - (findDebuff[stat] * stack)
            end
         end
   
         for _,stat in pairs(elementstats) do
            if findDebuff[stat] then
               cardInHand.ability[stat] = cardInHand.ability[stat] - (findDebuff[stat] * stack)
            end
         end

         cardInHand.ability[debuff] = nil
      else
         if type(cardInHand.ability[debuff]) ~= "number" then print("Debuff isn't a stackable debuff. [function: clearCardDebuff]") return end

         for _,stat in pairs(stats) do
            if findDebuff[stat] then
               cardInHand.ability[stat] = cardInHand.ability[stat] - (findDebuff[stat] * math.min(stack_to_remove,stack))
            end
         end
   
         for _,stat in pairs(elementstats) do
            if findDebuff[stat] then
               cardInHand.ability[stat] = cardInHand.ability[stat] - (findDebuff[stat] * math.min(stack_to_remove,stack))
            end
         end

         local stackReduction = math.max(stack - stack_to_remove,0)
         if stackReduction == 0 then
            cardInHand.ability[debuff] = nil
            if cardInHand.ability[debuff.."_duration"] then
               cardInHand.ability[debuff.."_duration"] = nil
            end
         end
      end

   end
end

function inflictDebuff(card, cardInHand, debuff, d_message, message_immediate, alt_message, ignore_priority) --Inflict debuffs on Playing Cards (and maybe Jokers soon)
-- I forgot to fucking comment my code, now I don't understand what half of them do.
   SMODS.Stickers["hsr_pc_debuff"]:apply(cardInHand,true)

   local findDebuff = nil
   for i,v in pairs(CardStats["CharacterDebuffs"]) do
      for i2,v2 in pairs(v) do
         if i2 == debuff then
            findDebuff = v2
            break
         end
      end
   end
   if not findDebuff then print("Debuff can't be found. [function: inflictDebuff]") return end

   local maxStack = findDebuff.max_stack or "boolean"

   if findDebuff["priority"] and not ignore_priority then --Priority Stuff.
      if findDebuff["priority"] == 0 then
         local found = false

         if findDebuff["related_debuffs"] then
            for _,v in pairs(findDebuff["related_debuffs"]) do
               if cardInHand.ability[v] then
                  found = true
                  break
               end
            end            
         end

         if findDebuff["adv_related_debuffs"] then
            for i,v in pairs(findDebuff["adv_related_debuffs"]) do
               if found then
                  break
               end

               if cardInHand.ability[i] then
                  if v["min_stack"] then
                     if (cardInHand.ability[i] or 0) >= v["min_stack"] then
                        found = true
                        break
                     end
                  end
               end
            end  
         end

         if found then return end
      elseif findDebuff["priority"] == 1 then
         local allFound = true
         for _,v in pairs(findDebuff["related_debuffs"]) do
            if not cardInHand.ability[v] then
               allFound = false
               break
            end
         end

         if findDebuff["adv_related_debuffs"] then
            for i,v in pairs(findDebuff["adv_related_debuffs"]) do
               if allFound then
                  break
               end

               if cardInHand.ability[i] then
                  if v["min_stack"] then
                     if (cardInHand.ability[i] or 0) < v["min_stack"] then
                        allFound = false
                        break
                     end
                  end
               end
            end  
         end

         if not allFound then return end
      elseif findDebuff["priority"] == 2 then
         local allFound = true
         for _,v in pairs(findDebuff["related_debuffs"]) do
            if not cardInHand.ability[v] then
               allFound = false
               break
            end
         end

         if findDebuff["adv_related_debuffs"] then
            for i,v in pairs(findDebuff["adv_related_debuffs"]) do
               if not allFound then
                  break
               end

               if cardInHand.ability[i] then
                  if v["min_stack"] then
                     if (cardInHand.ability[i] or 0) < v["min_stack"] then
                        allFound = false
                        break
                     end
                  end
               end
            end  
         end

         if not allFound then 
            if findDebuff["related_debuffs"] then
               for i,v in pairs(findDebuff["related_debuffs"]) do
                  inflictDebuff(card,cardInHand,v,alt_message or d_message,message_immediate)
               end
            elseif findDebuff["adv_related_debuffs"] then
               for i,v in pairs(findDebuff["adv_related_debuffs"]) do
                  inflictDebuff(card,cardInHand,i,alt_message or d_message,message_immediate)
               end
            end
            return 
         else
            if findDebuff["related_debuffs"] then
               for i,v in pairs(findDebuff["related_debuffs"]) do
                  clearCardDebuff(cardInHand,v)
               end
            elseif findDebuff["adv_related_debuffs"] then
               for i,v in pairs(findDebuff["adv_related_debuffs"]) do
                  clearCardDebuff(cardInHand,i)
               end
            end
         end
      end
   end

   if findDebuff["priority_clear"] and findDebuff["related_debuffs"] then --priority_clear code.
      for i,v in pairs(findDebuff["related_debuffs"]) do
         clearCardDebuff(cardInHand,v)
      end
   end

   for i,v in pairs(CardStats["CharacterDebuffs"]) do --priority_block code.
      for i2,v2 in pairs(v) do
         if v2["priority_block"] and v2["related_debuffs"] then
            for i3,v3 in pairs(v2["related_debuffs"]) do
               if v3 == debuff and cardInHand.ability[i2] then
                  return
               end
            end
         end
      end
   end

   --[[for i,v in pairs(findDebuff) do
      local matching_debuff = nil
      for _,d in pairs(CardStats["ElementReductionStats"]) do
         if d == i then
            matching_debuff = d
            break
         end
      end

      if not matching_debuff then
         for _,d in pairs(CardStats["Debuffs"]) do
            if d == i then
               matching_debuff = d
               break
            end
         end
      end

      --Increase playing card's stats.
      if (matching_debuff and not cardInHand.ability[debuff] and maxStack == "boolean") or (maxStack ~= "boolean" and ((not cardInHand.ability[debuff]) or (cardInHand.ability[debuff] and cardInHand.ability[debuff] < maxStack)) and matching_debuff) then
         if not cardInHand.ability[matching_debuff] then
            cardInHand.ability[matching_debuff] = 0
         end
         cardInHand.ability[matching_debuff] = cardInHand.ability[matching_debuff] + findDebuff[matching_debuff]
      end
   end]]


   if not findDebuff["max_stack"] and cardInHand.ability[findDebuff] then return end
   if findDebuff["max_stack"] and (cardInHand.ability[findDebuff] or 0) >= findDebuff["max_stack"] then return end

   for i,v in pairs(findDebuff) do --Load stats from debuffs
      for _,d in pairs(CardStats["ElementReductionStats"]) do
         if d == i then
            cardInHand.ability[d] = (cardInHand.ability[d] or 0) + v
         end
      end

      for _,d in pairs(CardStats["Debuffs"]) do
         if d == i then
            cardInHand.ability[d] = (cardInHand.ability[d] or 0) + v
         end
      end
   end

--If max_stacks is found, then it increases the thingy by 1. (giggidy)
   if type(maxStack) == "number" and (cardInHand.ability[debuff] or 0) < maxStack and maxStack ~= "boolean" then
      cardInHand.ability[debuff] = (cardInHand.ability[debuff] or 0) + 1
   end

--Else, set it to true.
   if type(maxStack) ~= "number" and maxStack == "boolean" then
      cardInHand.ability[debuff] = true
   end

   if findDebuff["duration"] then
      if not cardInHand.ability[debuff.."_duration"] or (cardInHand.ability[debuff.."_duration"] and not findDebuff["keep_duration_on_inflict"]) then
         cardInHand.ability[debuff.."_duration"] = findDebuff["duration"]
      end
   end

   if findDebuff["text"] then
      cardInHand.ability[debuff.."_text"] = findDebuff["text"]
   end

   --[[if message then
      card_eval_status_text(cardInHand, 'extra', nil, nil, nil, {message = d_message})
   end]]

   if d_message and message_immediate then
      card_eval_status_text(cardInHand, 'extra', nil, nil, nil, {message = d_message})
   end

   G.E_MANAGER:add_event(Event({
      trigger = 'before',
      delay = 0.0,
      func = function()
         card:juice_up()
         cardInHand:juice_up()
         if d_message and not message_immediate then
            card_eval_status_text(cardInHand, 'extra', nil, nil, nil, {message = d_message})
         end
         return true
       end
   }))
end

function hsr_turn_pass() --Runs when a turn passes (aka the "draw cards" phase after a hand is played). 
   for _,cardInHand in ipairs(G.hand.cards) do
      for dName, dVal in pairs(cardInHand.ability) do
         for _,chr in pairs(CardStats["CharacterDebuffs"]) do
            for debuffName,debuffVal in pairs(chr) do
               if debuffName == dName and debuffVal["duration"] then
                  cardInHand.ability[dName.."_duration"] = (cardInHand.ability[dName.."_duration"] or 1) - 1

                  if cardInHand.ability[dName.."_duration"] <= 0 then
                     clearCardDebuff(cardInHand,dName)
                  end
               end
            end
         end
      end
   end
end

function buffJoker(card, other_joker, buff) --Grant Jokers buffs.
   local buffConfig = nil
   for i,v in pairs(CardStats["CharacterBuffs"]) do
      for i2,v2 in pairs(v) do
         if i2 == buff then
            buffConfig = v2
            break
         end
      end
   end
   if not buffConfig then print("Buff is not found in CharacterBuffs.") return true end
   local duration = buffConfig["duration"] or 1
   local permBuff = buffConfig["permBuff"] or false
   local max_stack = buffConfig["max_stack"] or nil

   if other_joker.ability then
      if not other_joker.ability[buff] then
         other_joker.ability[buff] = true
         if max_stack then
            if not other_joker.ability[buff.."_stack"] then
               other_joker.ability[buff.."_stack"] = 0
            end
            if other_joker.ability[buff.."_stack"] < max_stack then
               other_joker.ability[buff.."_stack"] = other_joker.ability[buff.."_stack"] + 1
            end
         end
         if not permBuff then
            other_joker.ability[buff.."_duration"] = duration
         end
      elseif other_joker.ability[buff] then
         if not permBuff then
            other_joker.ability[buff.."_duration"] = duration --Reset duration.
         end
         if max_stack then
            if not other_joker.ability[buff.."_stack"] then
               other_joker.ability[buff.."_stack"] = 0
            end
            if other_joker.ability[buff.."_stack"] < max_stack then
               other_joker.ability[buff.."_stack"] = other_joker.ability[buff.."_stack"] + 1
            end
         end
      end
   end

   G.E_MANAGER:add_event(Event({
      trigger = 'before',
      delay = 0.0,
      func = function()
         card:juice_up()
         other_joker:juice_up()

         return true
       end
   }))
end

function clearBuffJoker(card, other_joker, buff) --Clear certain buffs from a Joker.
   if other_joker and buff then
      if type(buff) == "string" then
         for existing_buff,_ in pairs(other_joker.ability or {}) do
            if existing_buff == buff then
               other_joker.ability[buff] = nil
               if other_joker.ability[buff.."_duration"] then
                  other_joker.ability[buff.."_duration"] = nil
               end
               if other_joker.ability[buff.."_stack"] then
                  other_joker.ability[buff.."_stack"] = nil
               end
            end
         end
      elseif type(buff) == "table" then
         for i,v in pairs(buff) do
            if other_joker.ability and other_joker.ability[v] then
               other_joker.ability[v] = nil
               if other_joker.ability[v.."_duration"] then
                  other_joker.ability[v.."_duration"] = nil
               end
               if other_joker.ability[v.."_stack"] then
                  other_joker.ability[v.."_stack"] = nil
               end
            end
         end
      end
   end
end

function calculateDOT(card, context, specificDOT, specificCard, multi) --For Jokers who calculate using DOT.
   local cardInHand = specificCard or context.other_card
   local atkMulti = (BalatroSR.readBuffs(card))["atkMulti"]

   local ret = {
      card = card,
      mult = 0,
      chips = 0,
      x_mult = 1,
      xchips = 1,
      needToCalculate = false
   } --Collecting all gains before returning.

   function addToRet(a,b) --I'm a sucker for functions.
      ret[a] = ret[a] + b
   end

   --A bunch of DOT calculation for each individual character.

   function WindShearCalculate(retCard)
      local gains = {
         element = "Wind",
         chips = 0,
         baseincrease = 0,
         multi = {
         },
      }

      local retgains = {}

      function tempAddToRet(a,b,c)
         if c and c == "stack" then
            gains["multi"]["stack"] = a
         else
            if b == "multi" then
               gains["multi"][#gains["multi"]+1] = a
            elseif b == "element" then
               gains["element"] = a
            elseif string.find(b,"x") then
               gains[b] = (gains[b] or 1) + (a - 1)
            else
               gains[b] = (gains[b] or 0) + a
            end
         end
      end

      local sampoConfig = CardStats["config"]["Sampo"]
      local wsConfig = CardStats["CharacterDebuffs"]["Other"]["wind_shear_dot"]
      local ignoreBaseCalc = false

      if cardInHand.ability then
         for i,v in pairs(cardInHand.ability) do
            if BalatroSR.checkForIdenticalDebuff(i,"wind_shear_dot") then
               if i == "sampo_wind_shear_dot" and cardInHand.ability[i] and cardInHand.ability[i] > 0 then
                  local Eidolon = (cardInHand.ability["sampo_wind_shear_dot_eidolon"] or 0)
                  if getHSRJokerName(retCard) == "Sampo" then
                     Eidolon = card.ability.extra.currentEidolon
                  end
                  ignoreBaseCalc = true
                  tempAddToRet(sampoConfig.element,"element")
                  if not gains["multi"]["stack"] then
                     gains["multi"]["stack"] = cardInHand.ability[i]
                  end
      
                  if Eidolon >= 5 then
                     tempAddToRet(wsConfig.chip,"chips")
                     tempAddToRet(sampoConfig.e5Buff,"mult")
                     tempAddToRet(sampoConfig.e4Buff,"baseincrease")
                     tempAddToRet(2, "multi")
                     tempAddToRet((1 + sampoConfig.e3Buff/100), "multi")
                  elseif Eidolon >= 4 then
                     tempAddToRet(wsConfig.chip,"chips")
                     tempAddToRet(sampoConfig.e4Buff,"baseincrease")
                     tempAddToRet(2, "multi")
                     tempAddToRet((1 + sampoConfig.e3Buff/100), "multi")
                  elseif Eidolon >= 3 then
                     tempAddToRet(wsConfig.chip,"chips")
                     tempAddToRet(2, "multi")
                     tempAddToRet((1 + sampoConfig.e3Buff/100), "multi")
                  elseif Eidolon >= 1 then
                     tempAddToRet(wsConfig.chip,"chips")
                     tempAddToRet(2, "multi")
                  else
                     tempAddToRet(wsConfig.chip,"chips")
                  end
               end
   
               if not ignoreBaseCalc then
                  tempAddToRet(wsConfig.chip,"chips")
                  if (gains["multi"]["stack"] or -1) ~= cardInHand.ability.wind_shear_dot then
                     tempAddToRet(cardInHand.ability.wind_shear_dot,nil,"stack")   
                  end
               end
            end
         end

         local thingies = {"mult","chips","x_mult","xchips"}
         if gains["multi"]["stack"] then
            for i,v in pairs(thingies) do
               if gains[v] then
                  if gains["multi"] ~= {} then
                     if v ~= "chips" then
                        retgains[v] = (retgains[v] or 0) + calculateBaseMulti(retCard,gains["element"],BalatroSR.multiplyAll((gains[v]),gains["multi"]),_,true,nil,cardInHand)
                     else
                        retgains[v] = (retgains[v] or 0) + calculateBaseMulti(retCard,gains["element"],BalatroSR.multiplyAll((gains[v] + gains["baseincrease"]),gains["multi"]),_,true,nil,cardInHand)
                     end
                  else
                     if v ~= "chips" then
                        retgains[v] = (retgains[v] or 0) + calculateBaseMulti(retCard,gains["element"],gains[v],_,true,nil,cardInHand)
                     else
                        retgains[v] = (retgains[v] or 0) + calculateBaseMulti(retCard,gains["element"],gains[v] + gains["baseincrease"],_,true,nil,cardInHand)
                     end
                  end
               end
            end
   
            for i,v in pairs(thingies) do
               if retgains[v] then
                  if string.find(retgains[v],"x") then
                     ret[v] = ret[v] + (retgains[v] - 1)
                  else
                     ret[v] = ret[v] + retgains[v]
                  end 
               end
            end
         end
      end
   end

   function BurnCalculate(retCard)
      for i,v in pairs(cardInHand.ability) do
         if BalatroSR.checkForIdenticalDebuff(i,"burn_dot") then
            local stack = v or 1
            if type(stack) ~= "number" then stack = 1 end

            local burnConfig = CardStats["CharacterDebuffs"]["Other"]["burn_dot"]
            addToRet("mult", calculateBaseMulti(retCard,"Fire",burnConfig.mult * stack, nil,true,nil,cardInHand))
         end
      end
   end

   function ShockCalculate(retCard)
      for i,v in pairs(cardInHand.ability) do
         if BalatroSR.checkForIdenticalDebuff(i,"shock_dot") then
            local stack = v or 1
            if type(stack) ~= "number" then stack = 1 end

            local shockConfig = CardStats["CharacterDebuffs"]["Other"]["shock_dot"]
            addToRet("mult", calculateBaseMulti(retCard,"Lightning",shockConfig.mult * stack, nil,true,nil,cardInHand))
         end
      end
   end

   function KafkaCalculate()
      local shockConfig = CardStats["CharacterDebuffs"]["Other"]["shock_dot"]

      if cardInHand.ability then
         if not cardInHand.ability.dotMulti then cardInHand.ability.dotMulti = 0 end

         WindShearCalculate(card)
         BurnCalculate(card)

         for i,v in pairs(cardInHand.ability) do
            if BalatroSR.checkForIdenticalDebuff(i,"shock_dot") then
               local kafkaConfig = CardStats["config"]["Kafka"]

               if card.ability.extra.currentEidolon >= 5 then
                  addToRet("mult", calculateBaseMulti(card,kafkaConfig.element,(shockConfig.mult + kafkaConfig.e5Buff),nil,true,nil,cardInHand))
                  addToRet("x_mult", kafkaConfig.e4Buff)
               elseif card.ability.extra.currentEidolon >= 4 then
                  addToRet("mult", calculateBaseMulti(card,kafkaConfig.element,shockConfig.mult,nil,true,nil,cardInHand))
                  addToRet("x_mult", kafkaConfig.e4Buff)
               else
                  addToRet("mult", calculateBaseMulti(card,kafkaConfig.element,shockConfig.mult,nil,true,nil,cardInHand))
               end

               if i == "kafka_dot" then
                  addToRet("x_mult", 0.5)
               end
            end

         end   
      end
   end

   if specificDOT then
      if specificDOT == "Burn" then
         BurnCalculate(card)
      elseif specificDOT == "Wind Shear" then
         WindShearCalculate(card)
      elseif specificDOT == "Shock" then
         ShockCalculate(card)
      end
   else
      if getHSRJokerName(card) == "Kafka" then
         KafkaCalculate()
      elseif getHSRJokerName(card) == "Sampo" then
         WindShearCalculate(card)
      elseif getHSRJokerName(card) == "Asta" then
         BurnCalculate(card)
      end
   end

   --Calling the calculation respective to the card's name.

   for i,v in pairs(ret) do
      if ((i == "mult" or i == "chips") and v ~= 0) or ((i == "xchips" or i == "x_mult") and v ~= 1) then
         ret["needToCalculate"] = true
         break
      end
   end

   if ret.needToCalculate then
      local returnXMult = calculateBaseMulti(card,card.ability.extra.element,ret.x_mult,nil,true,"x_mult",cardInHand)
      if returnXMult ~= 1 then returnXMult = returnXMult * atkMulti * (multi or 1) end

      local returnXChips = calculateBaseMulti(card,card.ability.extra.element,ret.xchips,nil,true,"x_mult",cardInHand)
      if returnXChips ~= 1 then returnXChips = returnXChips * atkMulti * (multi or 1) end

      return{
         card = ret.card,
         mult = ret.mult * (multi or 1),
         chips = ret.chips* (multi or 1),
         x_mult = returnXMult,
         xchips = returnXChips
      }
   end --Returning everything.

end

function addToDestroy(card, a) --"a" must be a table of playing cards.
   for _,v in ipairs(a) do
      v["hsr_to_be_destroyed"] = true
   end
end

BalatroSR.checkForBuff = function(card,specificBuff) --Used to check if a HSR Joker has the listed buffs (can be table or string), or if specificBuff is left empty, simply check if it has buffs.
   local cardAbility = card.ability
   local allBuffs = CardStats["CharacterBuffs"]
   if not specificBuff then --Check if the Joker has any buff at all.
      local hasBuff = false

      for buffName,value in pairs(cardAbility) do
         if hasBuff then break end
         for _,chr in pairs(allBuffs) do
            if hasBuff then break end
            for chrBuffName,_ in pairs(chr) do
               if buffName == chrBuffName and value then
                  hasBuff = true
                  break
               end
            end
         end
      end

      if hasBuff then
         return true
      else
         return false
      end
   elseif specificBuff then --Check if the Joker has the listed buffs.
      if type(specificBuff) == "table" then
         local found = {}

         for buffName,_ in ipairs(specificBuff) do
            if cardAbility[buffName] then
               found[#found+1] = buffName
            end
         end

         if found == specificBuff then
            return true
         else
            return false
         end
      elseif type(specificBuff) == "string" then
         if cardAbility[specificBuff] then
            return true
         else
            return false
         end
      end
   end
end

--UI-related functions.

local Card_generate_UIBox_ability_table = Card.generate_UIBox_ability_table;
function Card:generate_UIBox_ability_table()
	local ret = Card_generate_UIBox_ability_table(self)

	local center_obj = self.config.center

	if string.find(center_obj.key or "", "_hsr_") and center_obj and center_obj.discovered and ((center_obj.set and G.localization.descriptions[center_obj.set] and G.localization.descriptions[center_obj.set][center_obj.key].subtitle) or center_obj.subtitle) then

		if ret.name and ret.name ~= true then
			local text = ret.name

			text[1].config.object.text_offset.y = text[1].config.object.text_offset.y - 14
			ret.name = {{n=G.UIT.R, config={align = "cm"},nodes={
				{n=G.UIT.R, config={align = "cm"}, nodes=text},
				{n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.O, config={object = DynaText({string = (center_obj.set and G.localization.descriptions[center_obj.set] and G.localization.descriptions[center_obj.set][center_obj.key].subtitle) or center_obj.subtitle, colours = {G.C.WHITE},float = true, shadow = true, offset_y = 0.1, silent = true, spacing = 1, scale = 0.33*0.7})}}
				}}
			}}}
		end

	end

	return ret
end

function hsr_generate_UI(self, info_queue, center, desc_nodes, specific_vars, full_UI_table, returnVar, specific_info_queue) --where in the living FUCK is GENERATE_UIIIIIIIIII
   if desc_nodes == full_UI_table.main then
      if not center.ability.extra["page"] then
         center.ability.extra["page"] = 1
      end

      local toAdd = {}
      toAdd[#toAdd+1] = {}
      local loc_vars = {scale = 1, vars = returnVar}
      if G.localization.descriptions["Joker"][center.config.center.key..(center.ability.extra["page"] or 1)] and G.localization.descriptions["Joker"][center.config.center.key..(center.ability.extra["page"] or 1)]["boxes"] then
         loc_vars["boxes"] = G.localization.descriptions["Joker"][center.config.center.key..(center.ability.extra["page"] or 1)]["boxes"]
      end
      localize {type = 'descriptions', key = "hsr_page", set = 'Joker', nodes = toAdd[#toAdd], vars = loc_vars.vars, scale = (loc_vars.scale - 0.2), text_colour = loc_vars.text_colour, shadow = loc_vars.shadow}
      if center.ability.extra["page"] >= (center.ability.extra["max_page"] or 4) then
         localize {type = 'descriptions', key = "hsr_relic_box", set = 'Joker', nodes = toAdd[#toAdd], vars = loc_vars.vars, scale = loc_vars.scale, text_colour = loc_vars.text_colour, shadow = loc_vars.shadow}
      elseif center.ability.extra["page"] >= (center.ability.extra["max_page"] - 1 or 3) then
         localize {type = 'descriptions', key = "hsr_stats_page", set = 'Joker', nodes = toAdd[#toAdd], vars = loc_vars.vars, scale = loc_vars.scale, text_colour = loc_vars.text_colour, shadow = loc_vars.shadow}
      else
         localize {type = 'descriptions', key = center.config.center.key..(center.ability.extra["page"] or 1), set = 'Joker', nodes = toAdd[#toAdd], vars = loc_vars.vars, scale = loc_vars.scale, text_colour = loc_vars.text_colour, shadow = loc_vars.shadow}
      end

      if loc_vars["boxes"] then
         --toAdd[#toAdd] = desc_from_rows(toAdd[#toAdd], true)
         local last_line_number = 0
         local box = {}
         for i,v in ipairs(loc_vars["boxes"]) do
            local t = {}
            for current_subline_number= 1,v do
                t[#t+1] = {
                    n=G.UIT.R,
                    config={
                        align = "cm"
                    },
                    nodes = toAdd[#toAdd][last_line_number + current_subline_number]
                }
            end
            box[#box+1]={
               n=G.UIT.R,
               config={
                   align = "cm",
                   colour = G.C.UI.BACKGROUND_WHITE,
                   r = 0.05,
                   padding = 0.03,
                   minh = 0.8,
                   emboss = 0.05
               },
               nodes=t
            }
           last_line_number = last_line_number + v
         end
         toAdd[#toAdd] = {
            n=G.UIT.R,
            config={
                align = "cm",
                padding = 0.04,
                filler = true
            },
            nodes=box
         }
      else
         toAdd[#toAdd] = desc_from_rows(toAdd[#toAdd], true)
      end

      desc_nodes[#desc_nodes+1] = {
         {
            n = G.UIT.C,
            config = {align = "cm", padding = 0.05},
            nodes = toAdd,
         }
      }
   end

   if specific_info_queue then
      for onPage, stuff in ipairs(specific_info_queue) do
         if not stuff["ignore"] then
            for _,iq in pairs(stuff) do
               if (center.ability.extra["page"] or 1) == onPage and iq then
                  info_queue[#info_queue+1] = iq
               end
            end
         else
         end
      end
   end

   full_UI_table["name"] = localize {type = 'name', set = 'Joker', key = center.config.center.key, nodes = {} }
end

function collectStats(card) --Mostly for generateUI, the stats board.
   local retspeed = 0
   local retatkMulti = 0
   local retbee = 0
   local retelementmulti = 0
   local retotherstats = "None"

   local cardAbility = card.ability
   local allStats = BalatroSR.readBuffs(card)

   local relicBuffs = BalatroSR.calculateRelics(card.ability.extra,nil,card.ability.extra.element,card)
   retbee = retbee + (allStats["bee"] - 1) + relicBuffs["bee"]
   retatkMulti = retatkMulti + (allStats["atkMulti"] - 1) + relicBuffs["atkMulti"]
   retelementmulti = retelementmulti + (allStats["elementMulti"] - 1) + relicBuffs["elementMulti"]
   retspeed = allStats["speed"] + relicBuffs["speed"]

   return {
      ["speed"] = cardAbility.extra.speed + retspeed,
      ["atkMulti"] = retatkMulti,
      ["bee"] = retbee,
      ["elementMulti"] = retelementmulti,
      ["otherStats"] = retotherstats
   }
end

--Ultimate related stuff down here.

function generalCooldownRegen(card) --Cooldown Regeneration handler.
   local extraStuff = card.ability.extra   
   local CooldownRegenBonus = 0
   local alike = (BalatroSR.readBuffs(card))["alike"]

   if alike and alike["eagle"] and alike["eagle"] >= 4 then
      CooldownRegenBonus = CooldownRegenBonus + RelicSetEffects["config"]["eagle"]["fourpcsBonus"]
   end

   local cardAbility = card.ability

   local allBuffs = CardStats["CharacterBuffs"]
   for _, character in pairs(allBuffs) do --Load buffs relating to Speed and Retriggers.
      for buffName, buff in pairs(character) do
         if cardAbility[buffName] then
            for spcBuffName, spcBuff in pairs(buff) do --Add buff's effects accordingly.
               if spcBuffName == "cooldownRegenBonus" then
                  CooldownRegenBonus = CooldownRegenBonus + spcBuff * (cardAbility[buffName.."_stack"] or 1)
               end
            end
         end
      end
   end

   return CooldownRegenBonus
end

function UltCooldownHandler(cd,maxcd,card,newVal)
   local a = cd
   local b = maxcd

   if a < b then
      local CooldownRegenBonus = generalCooldownRegen(card)
      a = (a or 0) + (newVal or 1) + CooldownRegenBonus
      if a >= b then
         a = b
      end
   end

   return a
end

function UltCooldownContext(card, condition, cd, context) --To automatically increase a Joker's Ultimate Regeneration.
   local availableConditions = {
      "onHandPlay", --Called when a Hand is played.
      "onDiscard", --Called when a Discard is used.
      "discardCards" --Called when a card is discarded.
   } --When to increase the regeneration.

   --Both "condition" and "cd" can be tables, to make the code shorter :3

   if (type(condition) == "table" and type(cd) == "table" and #condition ~= #cd) or (type(condition) ~= type(cd)) then
      print("Condition and CD don't match. [function: UltCooldownContext]")
   end

   if type(condition) == "table" then --Conditions can be tables.
      for _,v in ipairs(condition) do --Check whether all conditions in here exist in availableConditions.
         local exist = false
         for _,v2 in ipairs(availableConditions) do
            if v == v2 then exist = true break end
         end
         if not exist then
            print("The given Condition doesn't exist. [function: UltCooldownContext]")
         end
      end

      for order,v in ipairs(condition) do
         local div1 = string.sub(cd[order],1,3)
         local div3 = string.sub(cd[order],4,#cd[order])
         local div2 = "Required"

         local combined = div1..div2..div3

         if v == "onHandPlay" then
            if context.before and context.cardarea == G.jokers and not context.blueprint then --Ultimate Cooldown (Hands)
               card.ability.extra[cd[order]] = UltCooldownHandler(card.ability.extra[cd[order]],card.ability.extra[combined],card)
            end
         elseif v == "onDiscard" then
            if context.pre_discard and context.main_eval and not context.blueprint then --Ultimate Cooldown (Discard)
               card.ability.extra[cd[order]] = UltCooldownHandler(card.ability.extra[cd[order]],card.ability.extra[combined],card)
            end
         elseif v == "discardCards" then
            if context.discard then
               card.ability.extra[cd[order]] = UltCooldownHandler(card.ability.extra[cd[order]],card.ability.extra[combined],card)
            end
         end
      end
   else --But condition can also just be a string.
      local exist = false
      for _,v in ipairs(availableConditions) do
         if v == condition then exist = true break end
      end
      if not exist then
         print("The given Condition doesn't exist. [function: UltCooldownContext]")
      end

      local div1 = string.sub(cd,1,3)
      local div3 = string.sub(cd,4,#cd)
      local div2 = "Required"

      local combined = div1..div2..div3

      if condition == "onHandPlay" then
         if context.before and context.cardarea == G.jokers and not context.blueprint then --Ultimate Cooldown (Hands)
            card.ability.extra[cd] = UltCooldownHandler(card.ability.extra[cd],card.ability.extra[combined],card)
         end
      elseif condition == "onDiscard" then
         if context.pre_discard and context.main_eval and not context.blueprint then --Ultimate Cooldown (Discard)
            card.ability.extra[cd] = UltCooldownHandler(card.ability.extra[cd],card.ability.extra[combined],card)
         end
      elseif condition == "discardCards" then
         if context.discard then
            card.ability.extra[cd] = UltCooldownHandler(card.ability.extra[cd],card.ability.extra[combined],card)
         end
      end
   end

end

--Functions on Joker add/remove

function HDUpdate(card)
   if G and G.GAME and card.ability and card.ability.extra and card.ability.extra.currentEidolon then
      local cardAbility = card.ability
      local cardExtra = cardAbility.extra

      for e = 1,6 do --Adding Hands and Discards for Eidolons.
         for i,v in pairs(cardExtra) do
            if i == "e"..e.."hand" and cardExtra.currentEidolon >= v and not cardAbility["e"..e.."hand"] then
               cardAbility["e"..e.."hand"] = true
               G.GAME.round_resets.hands = G.GAME.round_resets.hands + v
               cardAbility["given_hand"] = (cardAbility["given_hand"] or 0) + v
               ease_hands_played(v)
            elseif i == "e"..e.."discard" and cardExtra.currentEidolon >= v and not cardAbility["e"..e.."discard"] then
               cardAbility["e"..e.."discard"] = true
               G.GAME.round_resets.discards = G.GAME.round_resets.discards + v
               cardAbility["given_discard"] = (cardAbility["given_discard"] or 0) + v
               ease_discard(v)
            end
         end
      end
   end
end

function HDAdd(card) --Fun fact: H stands for Hands, while D stands for Discards :3
   local cardAbility = card.ability
   local cardExtra = cardAbility.extra

   cardAbility["given_hand"] = 0
   cardAbility["given_discard"] = 0

   for i,v in pairs(cardExtra) do
      if (i == "hand") then
         G.GAME.round_resets.hands = G.GAME.round_resets.hands + v
         cardAbility["given_hand"] = (cardAbility["given_hand"] or 0) + v
         ease_hands_played(v)
      elseif (i == "discard") then
         G.GAME.round_resets.discards = G.GAME.round_resets.discards + v
         cardAbility["given_discard"] = (cardAbility["given_discard"] or 0) + v
         ease_discard(v)
      end
   end
end

function HDRemove(card) --Fun fact: H stands for Hands, while D stands for Discards :3
   local cardAbility = card.ability

   if cardAbility["given_hand"] and card.ability["given_hand"] ~= 0 then
      G.GAME.round_resets.hands = G.GAME.round_resets.hands - cardAbility["given_hand"]
      ease_hands_played(-cardAbility["given_hand"])
   end

   if cardAbility["given_discard"] and card.ability["given_hand"] ~= 0 then
      G.GAME.round_resets.discards = G.GAME.round_resets.discards - cardAbility["given_discard"]
      ease_discard(-cardAbility["given_discard"])
   end
end

function scoreCheck(x,y) --Check whether current score is higher/lower than (or equal) (x)% of score requirement. Yes, y should be like 100% or something.
   local a = BalatroSR.convertFromPercentage(y)
   if x == "high" then
      local valueToPutInIf = Talisman and to_big and (to_big(G.GAME.chips)/to_big(a)):gte(G.GAME.blind.chips) or G.GAME.chips / to_big(a) >= G.GAME.blind.chips
      if valueToPutInIf then
         return true
      else
         return false
      end
   elseif x == "low" then
      local valueToPutInIf = Talisman and to_big and (to_big(G.GAME.chips)/to_big(a)):lte(G.GAME.blind.chips) or G.GAME.chips / to_big(a) <= G.GAME.blind.chips
      if valueToPutInIf then
         return true
      else
         return false
      end
   else
      print("Wrong (x). [function: scoreCheck]")
   end
end

-- v:set_ability(G.P_CENTERS.m_wild, nil, true) <-- this is to change the card enhancement or smt
--[[
  code to, like, change ur scoring hand to wild cards before scoring
        if context.before and context.cardarea == G.jokers then
         print("a")
         for i,v in ipairs(context.scoring_hand) do
            print("b")
            v:set_ability(G.P_CENTERS.m_wild,nil,true)
         end
        end

THEY ACTUALLY ADDED "xchips", LETS GOOOOOOOOOOOOOOOOOOOOOOOOOOo

    Turning a random Joker to negative after beating a boss blind
      if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss and not context.blueprint then
         local pool = {}
         for i,v in pairs(G.jokers.cards) do                                                          
            if not v:get_edition() and v ~= card then
               pool[#pool + 1] = v
            end
         end
         local randomJokerChosen = pool[math.random(1,#pool)]
         if randomJokerChosen then
            randomJokerChosen:set_edition('e_negative',true)
         end
      end
]]

SMODS.Atlas{
   key = 'Jokers', --atlas key
   path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
   px = 71, --width of one card
   py = 95 -- height of one card
}

SMODS.Atlas{
   key = 'Jevil', --atlas key
   path = 'funjevil.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
   px = 90, --width of one card
   py = 96 -- height of one card
}

---3-Star
SMODS.Joker{ --Literal Trash
   key = 'Trash',
   config = {
      extra = CardStats["config"]["Trash"]
   },
   loc_txt = {
      name = 'Literal Trash',
      text = {
         'the beloved of trailblazer'
      },
   },
   atlas = 'Jokers',
   rarity = 1,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = false,
   pos = {x = 0, y = 0},
   --soul_pos = {x = 0, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calc_dollar_bonus = function(self, card)
      local bonus = card.ability.extra.money * card.ability.extra.currentEidolon
	   if bonus > 0 then return bonus end
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      local ret = HSRContextHandler(self,card,context)
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.money,
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
  end,
}
---4-Star
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
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      if context.before and context.cardarea == G.jokers and not context.blueprint then --Passive
         local currentHand = G.GAME.current_round.hands_left
         local maxHand = G.GAME.round_resets.hands

         clearBuffJoker(card,card,{"arlan_passive6","arlan_passive0","arlan_xmult"})

         if currentHand <= 2 and card.ability.extra.currentEidolon >= 4 then
            buffJoker(card,card,"arlan_xmult")
         end

         local check = math.floor(maxHand - currentHand)
         if check >= 1 then
            for i = 1,check do
               if card.ability.extra.currentEidolon >= 6 then
                  buffJoker(card,card,"arlan_passive6")
               else
                  buffJoker(card,card,"arlan_passive0")
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

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
      }
      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,

}

SMODS.Joker{ --March 7th (my beloved)
   key = 'M7',
   config = {
      extra = CardStats["config"]["M7"]
   },
   loc_txt = {
        name = 'March 7th',
        text = {
          'you complete me(ss)'
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
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra      --

      if context.before and context.cardarea == G.jokers and not context.blueprint then
         local CooldownRegenBonus = generalCooldownRegen(card)

         if G.GAME.current_round.hands_left <= 2 and card.ability.extra.currentEidolon >= 5 then
            CooldownRegenBonus = CooldownRegenBonus + 1
         end

         card.ability.extra.ultCooldown = card.ability.extra.ultCooldown + 1 + CooldownRegenBonus

         if card.ability.extra.ultCooldown >= card.ability.extra.ultRequiredCooldown then
            card.ability.extra.ultCooldown = 0
            local numToConvert = 2
            if card.ability.extra.currentEidolon >= 6 then
               numToConvert = numToConvert + 1
            end
            local allCards = BalatroSR.selectRandomCards(numToConvert,G.play.cards)

            BalatroSR.enhanceCard(card,allCards,"m_glass",nil,nil,nil,true)

            if not card.ability["m7_ult_cards"] then card.ability["m7_ult_cards"] = {} end
            card.ability["m7_ult_cards"] = BalatroSR.addToTable(card.ability["m7_ult_cards"],allCards)

            if card.ability.extra.currentEidolon >= 2 then
               buffJoker(card,card,"M7_e2")
            end

            if card.ability.extra.currentEidolon >= 4 then
               buffJoker(card,card,"M7_e4")
            end

            G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 1
            return{
               message = localize("hsr_m7_message"),
            }
         end
      end

      if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
         if card.ability["m7_ult_cards"] and #card.ability["m7_ult_cards"] >= 1 then
            local revertCards = card.ability["m7_ult_cards"]
            card.ability["m7_ult_cards"] = {}

            return{
               func = function()
                  G.E_MANAGER:add_event(Event({
                     trigger = 'after',
                     delay = 0,
                     func = function()
                        BalatroSR.unenhanceCard(card,revertCards,nil,true,true)
                        return true
                      end
                  }))
               end
            }
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

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.ultCooldown,
         center.ability.extra.ultRequiredCooldown
    }
    hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,

}

SMODS.Joker{ --Dan Heng
   key = 'DanHeng',
   config = {
      extra = CardStats["config"]["DanHeng"]
   },
   loc_txt = {
      name = 'Dan Heng',
      text = {
         'still waiting for that kiss'
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
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      if context.end_of_round and not context.blueprint then
         card.ability["danheng_passive2_used"] = false
         card.ability["danheng_e4_used"] = false
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint then
         local passive2_message_return = false

         local a = 0
         if card.ability.extra.currentEidolon >= 2 then
            a = a + 1
         end

         if card.ability.extra.currentEidolon >= 6 and not BalatroSR.checkForBuff(card,"danheng_e6") then
            buffJoker(card,card,"danheng_e6")
         end

         if card.ability.extra.currentEidolon >= 1 and scoreCheck("low",50) then
            buffJoker(card,card,"danheng_e1")
         else
            clearBuffJoker(card,card,"danheng_e1")
         end

         if BalatroSR.checkForBuff(card,"danheng_passive2") then
            clearBuffJoker(card,card,"danheng_passive2")
         end

         if G.GAME.current_round.hands_left <= (1 + a) then
            if not card.ability["danheng_passive2_used"] then
               buffJoker(card,card,"danheng_passive2")
               card.ability["danheng_passive2_used"] = true
               passive2_message_return = true
            end
         end

         if BalatroSR.checkForBuff(card) and not card.ability["danheng_e4_used"] and card.ability.extra.currentEidolon >= 4 then
            buffJoker(card,card,"danheng_e4")
            card.ability["danheng_e4_used"] = true
         end

         if passive2_message_return then
            return{
               message = localize("hsr_danheng_message"),
            }
         end
      end

      if context.individual and context.cardarea == G.play then
         if context.other_card:is_suit("Spades") then
            local cardChips = 0
            local extraMult = 0
            if BalatroSR.checkForBuff(card,"danheng_passive2") then
               cardChips = cardChips + 20
            end
            if card.ability.extra.currentEidolon >= 3 then
               extraMult = extraMult + 2
            end

            if card.ability.extra.currentEidolon >= 5 then
               extraMult = extraMult + 3
            end

            return {
               mult = calculateBaseMulti(card,card.ability.extra.element,(5 + extraMult),nil,false,nil,context.other_card),
               chips = calculateBaseMulti(card,card.ability.extra.element,cardChips,nil,false,nil,context.other_card),
               card = card,
            }
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

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.ultCooldown,
         center.ability.extra.ultRequiredCooldown
    }
    hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,

}

SMODS.Joker{ --Sampo
   key = 'Sampo',
   config = {
      extra = CardStats["config"]["Sampo"]
   },
   loc_txt = {
      name = 'Sampo',
      text = {
         'watdahellboi'
      },
   },
   atlas = 'Jokers',
   rarity = 3,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = false,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra      

      if context.before and context.cardarea == G.jokers then
         local inflictNumber = 5
         for i = 1,inflictNumber do
            local cardInHand = pseudorandom_element(G.hand.cards,pseudoseed("sampo_card_in_hand"))
            if cardInHand then
               cardInHand.ability.sampo_wind_shear_dot_eidolon = card.ability.extra.currentEidolon

               if not cardInHand.ability.sampo_e6 and card.ability.extra.currentEidolon >= 6 and not context.blueprint then inflictDebuff(card,cardInHand,"sampo_e6") end
               if not cardInHand.ability.sampo_wind_shear_dot or cardInHand.ability.sampo_wind_shear_dot < CardStats["CharacterDebuffs"]["Sampo"]["sampo_wind_shear_dot"]["max_stack"] then inflictDebuff(card,cardInHand,"sampo_wind_shear_dot", "Wind Shear!",true) end
            end
         end
      end

      if context.individual and context.cardarea == G.hand and not context.end_of_round then
         return(calculateDOT(card,context))
      end

      local ret = HSRContextHandler(self,card,context)
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.windShearMaxStacks,
         center.ability.extra.windShearChips,
         center.ability.extra.e3Buff,
         center.ability.extra.e4Buff,
         center.ability.extra.e5Buff,
         center.ability.extra.e6Buff,
      }

      info_queue[#info_queue+1] = {set = 'Other', key = 'hsr_dot_wind_shear'}

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Pela
   key = 'Pela',
   config = {
      extra = CardStats["config"]["Pela"]
   },
   loc_txt = {
      name = 'Pela',
      text = {
         'funni clumsy girl',
      }
   },
   atlas = 'Jokers',
   rarity = 3,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = false,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      UltCooldownContext(card,"onHandPlay","ultCooldown",context)

      if context.discard and card.ability.extra.currentEidolon >= 1 then
         local CooldownRegenBonus = generalCooldownRegen(card)
         card.ability.extra.discardedCards = card.ability.extra.discardedCards + 1 + CooldownRegenBonus
         local recalc = math.ceil(card.ability.extra.discardedCards/5)
         if recalc >= 1 then
            for i = 1, recalc do
               if card.ability.extra.discardedCards >= 5 then
                  card.ability.extra.discardedCards = card.ability.extra.discardedCards - 5
                  if card.ability.extra.ultCooldown < card.ability.extra.ultRequiredCooldown then
                     card.ability.extra.ultCooldown = card.ability.extra.ultCooldown + 1
                  end
               end
            end
         end

      end

      if context.individual and context.cardarea == G.hand and card.ability.extra.ultCooldown >= card.ability.extra.ultRequiredCooldown and not context.end_of_round and not context.blueprint then
         card.ability.extra.ultCooldown = 0
         for i,v in pairs(G.hand.cards) do
            local cardInHand = v
            local e = 1

            if card.ability.extra.currentEidolon >= 6 then
               e = 6
            elseif card.ability.extra.currentEidolon >= 5 then
               e = 5
            elseif card.ability.extra.currentEidolon >= 3 then
               e = 3
            else
               e = 1
            end

            if card.ability.extra.currentEidolon >= 4 then
               inflictDebuff(card,cardInHand,"pela_e4")
            end
            inflictDebuff(card,cardInHand,"pela_exposed"..e)
         end
         return {
            card = card,
            message = localize("hsr_pela_message")
         }
      end

      local ret = HSRContextHandler(self,card,context)
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.mult,
         center.ability.extra.e2mult,
         center.ability.extra.ultCooldown,
         center.ability.extra.discardedCards,
         center.ability.extra.ultRequiredCooldown,
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Natasha
   key = 'Natasha',
   config = {
      extra = CardStats["config"]["Natasha"]
   },
   loc_txt = {
      name = 'Natasha',
      text = {
        'mommy nurse'
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
   pos = {x = 1, y = 0},
   in_pool = function(self, args)
      return false
   end,

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
		--G.hand:change_size(-card.ability.extra.hand_size)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra

      if context.joker_main then
         if G.GAME.current_round.hands_left <= 2 and card.ability.extra.currentEidolon >= 4 and not card.ability["natasha_e4"] then
            card.ability["natasha_e4"] = true
            ease_hands_played(1)
         end
      end

      if context.discard then
         local CooldownRegenBonus = generalCooldownRegen(card)

         if G.GAME.current_round.hands_left <= 2 and card.ability.extra.currentEidolon >= 1 then
            CooldownRegenBonus = CooldownRegenBonus + 1
         end

         card.ability.extra.ultCooldown = card.ability.extra.ultCooldown + 1 + CooldownRegenBonus
         local ultTime = math.ceil(card.ability.extra.ultCooldown/card.ability.extra.ultRequiredCooldown)
         if ultTime >= 1 then --Activate Ultimate.
            for i = 1,ultTime do
               if card.ability.extra.ultCooldown >= card.ability.extra.ultRequiredCooldown then
                  card.ability.extra.ultCooldown = card.ability.extra.ultCooldown - card.ability.extra.ultRequiredCooldown
                  G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 1
                  if card.ability.extra.currentEidolon >= 2 then
                     buffJoker(card,card,"natasha_e2_temp")
                  end
                  if card.ability.extra.currentEidolon >= 6 and not card.ability["natasha_e6"] then
                     card.ability["natasha_e6"] = true
                     ease_discard(1)
                  end
               end
            end
         end
      end

      if context.end_of_round and context.cardarea == G.hand and not context.blueprint then
         card.ability["natasha_e4"] = nil
         card.ability["natasha_e6"] = nil
      end

      local ret = HSRContextHandler(self,card,context)
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.hand,
         center.ability.extra.ultCooldown,
         center.ability.extra.ultRequiredCooldown,
         center.ability.extra.e2Gain,
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
  end,
}

SMODS.Joker{ --Tingyun
   key = 'Tingyun',
   config = {
      extra = CardStats["config"]["Tingyun"]
   },
   loc_txt = {
      name = 'Tingyun',
      text = {
        'cute fox lady'
      },
   },
   atlas = 'Jokers',
   rarity = 3,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = true,
   eternal_compat = true,
   in_pool = function(self, args)
      return false
   end,
   perishable_compat = false,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra      local e = 0
      if card.ability.extra.currentEidolon >= 6 then
         e = 6
      elseif card.ability.extra.currentEidolon >= 5 then
         e = 5
      elseif card.ability.extra.currentEidolon >= 4 then
         e = 4
      elseif card.ability.extra.currentEidolon >= 2 then
         e = 2
      elseif card.ability.extra.currentEidolon >= 1 then
         e = 1
      end

      if context.before then
         local other_joker = nil --Rightmost Joker
         local lastPos = #G.jokers.cards
         local lastJoker = G.jokers.cards[lastPos]
         if lastJoker and lastJoker ~= card and lastJoker.ability and string.find(lastJoker.config.center.key,"j_hsr_") then
            other_joker = lastJoker
         else
            repeat
               lastPos = lastPos - 1
               if lastPos >= 1 then
                  lastJoker = G.jokers.cards[lastPos]
                  if lastJoker and lastJoker ~= card and lastJoker.ability and string.find(lastJoker.config.center.key,"j_hsr_") then
                     other_joker = lastJoker
                  end
               end
            until other_joker or lastPos <= 0
         end

         if not card.ability["tingyun_e3"] and card.ability.extra.currentEidolon >= 3 then
            buffJoker(card,card,"tingyun_e3")
         end

         if other_joker then
            if (card.ability["last_target"] and other_joker and card.ability["last_target"] ~= other_joker) or (card.ability["last_target"] and other_joker and card.ability["last_target"] == other_joker and e ~= card.ability["last_eidolon_application"]) then
               for i = 0,6 do
                  clearBuffJoker(card,card.ability["last_target"],"tingyun_benediction"..i)
               end
            end

            card.ability["last_target"] = other_joker
            card.ability["last_eidolon_application"] = e

            buffJoker(card,other_joker,"tingyun_benediction"..e)
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

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         (center.ability.extra.atkMulti - 1) * 100,
         (center.ability.extra.bee - 1) * 100,
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Asta
   key = 'Asta',
   config = {
      extra = CardStats["config"]["Asta"]
   },
   loc_txt = {
      name = 'Asta',
      text = {
        'ACTION ADVANCE, GO!'
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
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      if context.before and context.cardarea == G.jokers and card.ability.extra.currentEidolon >= 1 then
         local inflictNumber = 5
         for i = 1,inflictNumber do
            local cardInHand = pseudorandom_element(G.hand.cards,pseudoseed("sampo_card_in_hand"))
            if cardInHand then
               if (cardInHand.ability.burn_dot or 0) < CardStats["CharacterDebuffs"]["Other"]["burn_dot"]["max_stack"] then inflictDebuff(card,cardInHand,"burn_dot", "Burn!", true) end
            end
         end
      end

      if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint and card.ability.extra.currentEidolon >= 1 then --Asta inflicting Burn DOT (>=E1)
         return(calculateDOT(card,context))
      end

      if context.cardarea == G.play and context.individual and not context.blueprint and not context.retrigger_joker then --Calculating Suits for Astrometry.
         --print(context.retrigger_joker and 'yes' or 'no')
         local isDifferentSuit = false
         for i,v in pairs(AllSuits) do
            if context.other_card:is_suit(v) and not card.ability[v.."_played"] then
               isDifferentSuit = true
               card.ability[v.."_played"] = true
            end
         end

         if isDifferentSuit then
            card:juice_up()
            card.ability.extra["astrometryStack"] = card.ability.extra["astrometryStack"] + 1
            return {
               message = localize("hsr_asta_message1"),
               card = card,
               --no_retrigger = true,
            }
         end
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint then --Buffing Jokers with Astrometry and Astral Blessing.
         for i,v in ipairs(G.jokers.cards) do
            clearBuffJoker(card,v,"asta_astrometry")
            if isHSRJoker(v) then
               local numberOfStacks = card.ability.extra["astrometryStack"]
               if numberOfStacks > 0 then
                  for i = 1, numberOfStacks do
                     buffJoker(card,v,"asta_astrometry")
                  end
               end
            end
         end

         if card.ability.extra.ultCooldown1 >= card.ability.extra.ultRequiredCooldown1 and card.ability.extra.ultCooldown2 >= card.ability.extra.ultRequiredCooldown2 then
            card.ability.extra.ultCooldown1 = 0
            card.ability.extra.ultCooldown2 = 0

            for i,v in ipairs(G.jokers.cards) do
               if isHSRJoker(v) then
                  buffJoker(card,v,"asta_astral_blessing")
               end
            end

            return {
               card = card,
               message = localize("hsr_asta_message2")
            }
         end
      end

      UltCooldownContext(card,"onDiscard","ultCooldown2",context)
      UltCooldownContext(card,"onHandPlay","ultCooldown1",context)

      if context.end_of_round and not context.blueprint then --Reseting Astrometry at end of round.
         for i,v in pairs(AllSuits) do
            card.ability[v.."_played"] = false
         end
         card.ability.extra["astrometryStack"] = 0
      end

      local ret = HSRContextHandler(self,card,context)
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         (center.ability.extra.atkMulti - 1) * 100,
         center.ability.extra.multBuff,
         center.ability.extra.astrometryStack,
         center.ability.extra.ultCooldown1,
         center.ability.extra.ultRequiredCooldown1,
         center.ability.extra.ultCooldown2,
         center.ability.extra.ultRequiredCooldown2,
      }

      local siq = {
         {
            {
               set = 'Other',
               key = 'hsr_dot_wind_shear'
            }
         },
         {
            {
               set = 'Other',
               key = 'hsr_dot_wind_shear'
            }
         },
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar,siq)
   end,
}

SMODS.Joker{ --Herta
   key = 'Herta',
   config = {
      extra = CardStats["config"]["Herta"]
   },
   loc_txt = {
      name = 'Herta',
      text = {
         'cute and funny doll'
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
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      if card.ability.extra.currentEidolon >= 3 and not card.ability["herta_e3"] then
         buffJoker(card,card,"herta_e3")
      end

      if card.ability.extra.currentEidolon >= 5 and not card.ability["herta_e5"] then
         buffJoker(card,card,"herta_e5")
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint and not context.retrigger_joker then
         card.ability["herta_fua"] = false

         if not card.ability["herta_fua_used"] and scoreCheck("high",50) then
            card.ability["herta_fua_used"] = true
            card.ability["herta_fua"] = true
         end

         if card.ability["herta_fua"] then
            if card.ability.extra.currentEidolon >= 2 then
               for i = 1, #G.hand.cards do
                  buffJoker(card,card,"herta_e2")
               end
            end

            return{
               message = localize("hsr_herta_message"),
               card = card,
            }
         end
      end

      if context.joker_main and card.ability["herta_fua"] then
         local he_chips = 0
         for _,cardInHand in ipairs(G.hand.cards) do
            local he_xchips = 1
            local increasePerPlay = 25
            if card.ability.extra.currentEidolon >= 4 then
               increasePerPlay = increasePerPlay + 10
            end

            if card.ability.extra.currentEidolon >= 1 then
               he_chips = he_chips + (increasePerPlay * 1.4)
            else
               he_chips = he_chips + increasePerPlay
            end

            if SMODS.has_enhancement(cardInHand,"m_glass") then
               if card.ability.extra.currentEidolon >= 1 then
                  he_xchips = he_xchips + (0.2 * 1.4)
               else
                  he_xchips = he_xchips + 0.2
               end
               if card.ability.extra.currentEidolon >= 6 then
                  he_xchips = (1.5 * 1.4)
               end
            end

            SMODS.calculate_effect({chips = calculateBaseMulti(card,card.ability.extra.element,he_chips,nil,false,nil,cardInHand), xchips = calculateBaseMulti(card,card.ability.extra.element,he_xchips,nil,false,true,cardInHand)}, cardInHand)
         end
      end

      if context.after then
         clearBuffJoker(card,card,"herta_e2")
      end

      if context.end_of_round then
         card.ability["herta_fua_used"] = false
      end

      local ret = HSRContextHandler(self,card,context)
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
    }
    hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,

}

SMODS.Joker{ --Qingque
   key = 'Qingque',
   config = {
      extra = CardStats["config"]["Qingque"]
   },
   loc_txt = {
      name = 'Qingque',
      text = {
         'gambling goblin'
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
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      if card.ability.extra.currentEidolon >= 3 and not card.ability["qingque_e3"] then
         buffJoker(card,card,"qingque_e3")
      end
      if card.ability.extra.currentEidolon >= 5 and not card.ability["qingque_e5"] then
         buffJoker(card,card,"qingque_e5")
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint and not context.retrigger_joker then
         if card.ability["qq_cherryontop_triggered"] then
            card.ability["qq_cherryontop"] = false
            card.ability["qq_cherryontop_triggered"] = false
         end

         if context.scoring_name == "Four of a Kind" then
            local suitChanged = {}
            local fore6 = {}

            for _,v in ipairs(G.play.cards) do
               local randomSuit = pseudorandom_element(AllSuits,pseudoseed("qq_random_suit"))
               table.insert(suitChanged,randomSuit)
               table.insert(fore6,{["card"] = v, ["suit"] = randomSuit})
               BalatroSR.animatedChangeBase({v},randomSuit,nil,nil,nil,false,true)
            end

            if card.ability.extra.currentEidolon >= 6 then
               local highestSuit = nil
               local highestSuitNumber = 1
               local registeredSuits = {}

               for _,v in ipairs(suitChanged) do
                  if registeredSuits[v] then
                     registeredSuits[v] = registeredSuits[v] + 1
                  else
                     registeredSuits[v] = 1
                  end
               end

               for suitName, suitNum in pairs(registeredSuits) do
                  if suitNum >= highestSuitNumber then
                     highestSuitNumber = suitNum
                     highestSuit = suitName
                  end
               end

               if highestSuit then
                  local highest_cloned = {}

                  for _,v in ipairs(fore6) do
                     if v["suit"] == highestSuit then
                        table.insert(highest_cloned,v["suit"])
                     end
                  end

                  suitChanged = {}

                  for _,v in ipairs(highest_cloned) do
                     table.insert(suitChanged,v)
                  end

                  for _,v1 in ipairs(fore6) do
                     local can = true
                     for _,v2 in ipairs(highest_cloned) do
                        if v1["suit"] == v2 then can = false; print("Nope! Ignored "..v2) end
                     end

                     if can then
                        local randomSuit = pseudorandom_element(AllSuits,pseudoseed("qq_random_suit2"))
                        table.insert(suitChanged,randomSuit)
                        BalatroSR.animatedChangeBase({v1["card"]},randomSuit,nil,nil,nil,false,true)

                        table.insert(suitChanged,randomSuit)
                     end
                  end

               else
                  suitChanged = {}

                  for _,v in ipairs(G.play.cards) do
                     local randomSuit = pseudorandom_element(AllSuits,pseudoseed("qq_random_suit_3_and_why_do_i_have_so_many"))
                     table.insert(suitChanged,randomSuit)
                     BalatroSR.animatedChangeBase({v},randomSuit,nil,nil,nil,false,true)
                  end
               end
            end

            card.ability["qq_allSuits"] = suitChanged
         end
      end

      if context.joker_main and context.scoring_name == "Four of a Kind" and not context.blueprint and not context.retrigger_joker then
         local registeredSuits = {}
         local tileEarn = 0
         local qq_allSuits = card.ability["qq_allSuits"]

         buffJoker(card,card,"qingque_e2")

         for _,v in ipairs(qq_allSuits) do
            if registeredSuits[v] then
               registeredSuits[v] = registeredSuits[v] + 1
            else
               registeredSuits[v] = 1
            end
         end

         --[[for _,v in ipairs(G.play.cards) do
            local cardSuit = v.base.suit
            if registeredSuits[cardSuit] then
               registeredSuits[cardSuit] = registeredSuits[cardSuit] + 1
            else
               registeredSuits[cardSuit] = 1
            end
         end]]

         for _, suitAmount in pairs(registeredSuits) do
            if suitAmount >= 2 then
               tileEarn = tileEarn + suitAmount
            end
         end

         card.ability.extra.tile = card.ability.extra.tile + tileEarn
         if card.ability.extra.tile >= 4 then
            card.ability.extra.tile = 4
         end

         if card.ability.extra.tile < 4 then
            SMODS.calculate_effect({message = "["..card.ability.extra.tile.."/4!]"},card)
         elseif card.ability.extra.tile >= 4 and not card.ability["qq_cherryontop"] then
            SMODS.calculate_effect({message = localize("hsr_qingque_message")},card)
            card.ability["qq_cherryontop"] = true
         end
      end

      if context.individual and context.cardarea == G.play then
         local qq_xmult = 1
         local qq_xchips = 1
         local qq_money = 0

         if card.ability["qq_cherryontop"] then
            card.ability["qq_cherryontop_triggered"] = true
            if card.ability.extra.currentEidolon >= 6 then
               qq_xmult = qq_xmult + 4
            else
               qq_xmult = qq_xmult + 3
            end

            qq_xchips = qq_xchips + 1
            qq_money = qq_money + 1

            if card.ability.extra.currentEidolon >= 1 then
               qq_xmult = qq_xmult * 1.1
               qq_xchips = qq_xchips * 1.1
            end
         end

         if qq_money > 0 then
            return {
               xmult = calculateBaseMulti(card,card.ability.extra.element,qq_xmult,nil,false,true,context.other_card),
               xchips = calculateBaseMulti(card,card.ability.extra.element,qq_xchips,nil,false,true,context.other_card),
               dollars = qq_money,
               card = card,
            }
         else
            return {
               xmult = calculateBaseMulti(card,card.ability.extra.element,qq_xmult,nil,false,true,context.other_card),
               xchips = calculateBaseMulti(card,card.ability.extra.element,qq_xchips,nil,false,true,context.other_card),
               card = card,
            }
         end
      end

      if context.final_scoring_step and context.cardarea == G.jokers and not context.blueprint and not context.retrigger_joker then
         if card.ability["qq_cherryontop_triggered"] then
            card.ability.extra.tile = 0
         end
      end

      if context.cardarea == G.play and context.repetition and card.ability["qingque_cherryontop"] and card.ability.extra.currentEidolon >= 4 and pseudorandom("qingque_e4") <= 3/4 then
         return {
            card = card,
            message = localize("k_again_ex"),
            repetitions = 1,
         }
      end

      local ret = HSRContextHandler(self,card,context)
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other Vars
         center.ability.extra.tile
    }
    hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,

}

SMODS.Joker{ --Serval
   key = 'Serval',
   config = {
      extra = CardStats["config"]["Serval"]
   },
   loc_txt = {
      name = 'Serval',
      text = {
         'cool guitarist older sister :3'
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
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      local ret = HSRContextHandler(self,card,context)

      UltCooldownContext(card,"discardCards","ultCooldown",context)

      if card.ability.extra.currentEidolon >= 3 and not card.ability["serval_e3"] then
         buffJoker(card,card,"serval_e3")
      end
      if card.ability.extra.currentEidolon >= 5 and not card.ability["serval_e5"] then
         buffJoker(card,card,"serval_e5")
      end

      if context.before and context.cardarea == G.jokers and card.ability.extra.ultCooldown >= card.ability.extra.ultRequiredCooldown then
         card.ability.extra.ultCooldown = 0
         for _,v in ipairs(G.hand.cards) do
            if card.ability.extra.currentEidolon >= 4 and pseudorandom("hsr_serval_rng_e4") <= 1/2 then
               inflictDebuff(card,v,"serval_e4")
            end
            if not v.ability["shock_dot"] then
               inflictDebuff(card,v,"shock_dot","Shock!",true)
               if card.ability.extra.currentEidolon >= 2 then
                  buffJoker(card,card,"serval_e2")
               end
            end
         end
      end

      if context.before and context.cardarea == G.jokers then
         for _,v in ipairs(G.hand.cards) do
            if pseudorandom("hsr_serval_rng") <= G.GAME.probabilities.normal/card.ability.extra.shockChance and not v.ability["shock_dot"] then
               if card.ability.extra.currentEidolon >= 2 then
                  buffJoker(card,card,"serval_e2")
               end
               inflictDebuff(card,v,"shock_dot","Shock!",true)
            end
         end
      end

      if context.individual and context.cardarea == G.hand then
         if cardHasDebuff(context.other_card,"shock_dot") then
            local baseMult = 15
            if card.ability.extra.currentEidolon >= 6 then
               baseMult = baseMult * 1.3
            end
            
            if card.ability.extra.currentEidolon >= 1 then
               local adjCards = BalatroSR.adjacentCards(context.other_card,G.hand,true,1)
               for _,v in ipairs(adjCards) do
                  if cardHasDebuff(v,"shock_dot") and pseudorandom("hsr_serval_rng_e1") <= G.GAME.probabilities.normal/2 then
                     SMODS.calculate_effect({mult = calculateBaseMulti(card,card.ability.extra.element,baseMult,nil,false,nil,v)},v)
                  end
               end
            end
            return {
               mult = calculateBaseMulti(card,card.ability.extra.element,baseMult,nil,false,nil,context.other_card),
            }
         end
      end

      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other Vars
         (G.GAME.probabilities.normal or 1),
         center.ability.extra.shockChance,
         center.ability.extra.ultCooldown,
         center.ability.extra.ultRequiredCooldown,
      }

      local siq = {
         {
            {
               set = 'Other',
               key = 'hsr_dot_shock'
            },
         },
         {
            {
               set = 'Other',
               key = 'hsr_dot_shock'
            },
         },
      }
   
      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar,siq)
   end,

}

SMODS.Joker{ --Hook
   key = 'Hook',
   config = {
      extra = CardStats["config"]["Hook"]
   },
   loc_txt = {
      name = 'Hook',
      text = {
         'underrated character ngl'
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
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      local ret = HSRContextHandler(self,card,context)

      if context.before and context.cardarea == G.jokers and not context.blueprint then --Ultimate Cooldown (Hands)
         local adjCards = BalatroSR.adjacentCards(pseudorandom_element(G.hand.cards,pseudoseed("hook_random_card")),G.hand,false,1)
         if adjCards then
            for _,v in ipairs(adjCards) do
               inflictDebuff(card,v,"burn_dot","Burn!")
            end
         end
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint and not context.retrigger_joker then
         local destroyingCards = {}

         for i,v in ipairs(G.play.cards) do
            for i2,v2 in pairs(v.ability) do
               if BalatroSR.checkForIdenticalDebuff(i2,"burn_dot") then
                  if (v2 or 0) >= 2 then
                     destroyingCards[#destroyingCards+1] = v
                     card.ability.extra.mult = card.ability.extra.mult + 5
                     break
                  end
               end
            end
         end

         if #destroyingCards >= 1 then
            addToDestroy(card,destroyingCards)
         end
      end

      if context.pre_discard and context.main_eval and not context.blueprint then --Ultimate Cooldown (Discard)
         local cloneTable = {}
         for _,v in ipairs(G.hand.cards) do
            local isHighlighted = false

            for _,v2 in ipairs(G.hand.highlighted) do
               if v2 == v then
                  isHighlighted = true
                  break
               end
            end

            if not isHighlighted then
               cloneTable[#cloneTable+1] = v
            end
         end
         local adjCards = BalatroSR.adjacentCards(pseudorandom_element(cloneTable,pseudoseed("hook_random_card_discard")),G.hand,false,1)
         if adjCards then
            for _,v in ipairs(adjCards) do
               inflictDebuff(card,v,"burn_dot","Burn!")
            end
         end
      end

      if context.individual and context.cardarea == G.play then
         local multi = 1
         if card.ability.extra.currentEidolon >= 1 then multi = multi + 1.2 end
         if card.ability.extra.currentEidolon >= 6 then multi = multi + 1.3 end

         if card.ability.extra.currentEidolon >= 4 then
            local adjCards = BalatroSR.adjacentCards(context.other_card,G.play,false,1)
            for _,v in ipairs(adjCards) do
               local hasBurn = false
               
               for debuffName,_ in pairs(v.ability or {}) do
                  if BalatroSR.checkForIdenticalDebuff(debuffName,"burn_dot") then
                     hasBurn = true
                     break
                  end
               end

               if hasBurn then
                  SMODS.calculate_effect(calculateDOT(card,context,"Burn",v,multi),v)
               end
            end
         end

         return(calculateDOT(card,context,"Burn",nil,multi))
      end

      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other Vars
         center.ability.extra.mult
      }

    local siq = {
      {
         {
            set = 'Other',
            key = 'hsr_dot_burn'
         },
      },
      {
         {
            set = 'Other',
            key = 'hsr_dot_burn'
         },
      },
   }

   hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar,siq)
   end,

}
---5-Star
SMODS.Joker{ --Yanqing
   key = 'Yanqing',
   config = {
      extra = CardStats["config"]["Yanqing"]
   },
   loc_txt = {
      name = 'Yanqing',
      text = {
        'genuinely hate this guy with every cell in my body'
      },
   },
   atlas = 'Jokers',
   rarity = 4,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 0, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
      buffJoker(card,card,"yanqing_soulsteel_sync")
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self,card,context)
      local extraStuff = card.ability.extra
      if context.first_hand_drawn then
         buffJoker(card,card,"yanqing_soulsteel_sync")
         if card.ability.extra.currentEidolon >= 5 then
            buffJoker(card,card,"yanqing_e5")
         end
         if card.ability.extra.currentEidolon >= 2 then
            buffJoker(card,card,"yanqing_soulsteel_synce2")
         end
         if card.ability.extra.currentEidolon >= 4 then
            buffJoker(card,card,"yanqing_soulsteel_synce4")
         end
         if card.ability.extra.currentEidolon >= 6 then
            buffJoker(card,card,"yanqing_soulsteel_synce6")
         end
         return{
            card = card,
            message = localize("hsr_yanqing_message"),
         }
      end

      if card.ability["yanqing_soulsteel_sync"] then
         if context.discard then
            clearBuffJoker(card,card,{"yanqing_soulsteel_sync", "yanqing_e5", "yanqing_soulsteel_synce2", "yanqing_soulsteel_synce4", "yanqing_soulsteel_synce6"})
            return{
               card = card,
               message = localize("hsr_yanqing_message2"),
            }
         end

         if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades") then
               local addChips = 0
               if card.ability.extra.currentEidolon >= 1 then
                  addChips = 20
               end

               return {
                  xchips = calculateBaseMulti(card,card.ability.extra.element,1.1,nil,false,true,context.other_card),
                  chips = calculateBaseMulti(card,card.ability.extra.element,addChips,nil,false,nil,context.other_card),
                  dollars = 1,
               }
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

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Welt
   key = 'Welt',
   config = {
      extra = CardStats["config"]["Welt"]
   },
   loc_txt = {
      name = 'Welt',
      text = {
        'the hi3 guy'
      },
   },
   atlas = 'Jokers',
   rarity = 4,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self,card,context)
      local extraStuff = card.ability.extra
      function weltChips(a)
         card.ability.extra.chip = card.ability.extra.chip + a
         card.ability.extra.xChip = 1 + (math.floor(card.ability.extra.chip/100) * 0.1)
      end

      if card.ability.extra.currentEidolon >= 3 and not card.ability["welt_e3"] then
         card.ability["welt_e3"] = true
         weltChips(100)
      end

      if card.ability.extra.currentEidolon >= 5 and not card.ability["welt_e5"] then
         card.ability["welt_e5"] = true
         weltChips(200)
      end

      if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
         local remain = 0
         if card.ability.extra.currentEidolon >= 3 then
            remain = remain + 100
         end
         if card.ability.extra.currentEidolon >= 5 then
            remain = remain + 200
         end

         card.ability.extra.chip = 0
         card.ability.extra.xChip = 1

         weltChips(remain)

         return {
            message = localize("k_reset"),
         }
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint then
         local toCopy = G.play.cards
         local copied = {}
         local randomTime = 3
         if card.ability.extra.currentEidolon >= 6 then
            randomTime = randomTime + 1
         end
         local copied2 = {}
         for i,v in ipairs(toCopy) do
            copied[i] = v
         end
         local uniqueUsed = {}

         for i = 1,randomTime do
            copied2[#copied2+1] = pseudorandom_element(copied,pseudoseed("welt_random_card"))
         end

         for _,v in ipairs(copied2) do
            local multi = 1
            local isUnique = true
            local card_chip = v:get_chip_bonus()
            if v:get_edition() and v.edition.key == "e_foil" then
               card_chip = card_chip + G.P_CENTERS.e_foil.config.extra
            end

            for _,check in pairs(uniqueUsed) do
               if check == v then
                  isUnique = false
                  break
               end
            end
            uniqueUsed[#uniqueUsed+1] = v

            if card.ability.extra.currentEidolon >= 1 then
               buffJoker(card,card,"welt_e1")
            end

            if isUnique and card.ability.extra.currentEidolon >= 2 then
               multi = multi * 2
            end
            if card.ability.extra.currentEidolon >= 6 then
               multi = multi * 2
            end

            card_chip = card_chip * multi

            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+"..card_chip})

            weltChips(card_chip)

            if card.ability.extra.currentEidolon >= 4 then
               inflictDebuff(card,v,"welt_debuffe4")
            else
               inflictDebuff(card,v,"welt_debuff")
            end

            G.E_MANAGER:add_event(Event({
               trigger = 'before',
               delay = 0,
               func = function()
                  v:juice_up()
                  return true
                end
            }))
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

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.chip,
         center.ability.extra.xChip,
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Himeko
   key = 'Himeko',
   config = {
      extra = CardStats["config"]["Himeko"]
   },
   loc_txt = {
      name = 'Himeko',
      text = {
        'never let you goooo'
      },
   },
   atlas = 'Jokers',
   rarity = 4,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self,card,context)
      local extraStuff = card.ability.extra
      if card.ability.extra.currentEidolon >= 5 and not card.ability["himeko_e5"] then
         buffJoker(card,card,"himeko_e5")
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint then
         clearBuffJoker(card,card,{"himeko_fua"})
         card.ability["himeko_e3_proc"] = false
         local toCopy = G.play.cards
         local copied = {}

         local differentSuits = {}
         local differentRanks = {}

         for i,v in ipairs(toCopy) do
            copied[i] = v
         end

         for i,v in ipairs(copied) do
            for _,suit in ipairs(AllSuits) do --Check for Unique Suits
               local uniqueSuit = true
               for _,foundSuit in ipairs(differentSuits) do
                  if foundSuit == suit then
                     uniqueSuit = false
                     break
                  end
               end

               if uniqueSuit and v:is_suit(suit) then
                  differentSuits[#differentSuits+1] = suit
               end
            end

            for i = 1,14 do
               local uniqueRank = true
               for _,foundRank in ipairs(differentRanks) do
                  if foundRank == i then
                     uniqueRank = false
                     break
                  end
               end

               if uniqueRank and v:get_id() == i then
                  differentRanks[#differentRanks+1] = i
               end
            end
         end

         if card.ability.extra.currentEidolon >= 2 and G.GAME.chips >= G.GAME.blind.chips/2 then
            buffJoker(card,card,"himeko_e2")
         else
            clearBuffJoker(card,card,"himeko_e2")
         end

         local requirement = 3
         if card.ability.extra.currentEidolon >= 4 then
            requirement = requirement - 1
         end

         if #differentSuits >= requirement or #differentRanks >= requirement then
            buffJoker(card,card,"himeko_fua")

            local lowestRank = nil
            local cardInRank = {}

            for i = 1,14 do
               for _,card in ipairs(G.play.cards) do
                  if card:get_id() == i and i < (lowestRank or math.huge) then
                     lowestRank = i
                  end
              end
            end

            if lowestRank then
               for _,card in ipairs(G.play.cards) do
                  if card:get_id() == lowestRank then
                     cardInRank[#cardInRank+1] = card
                  end
               end

               local randomCard = pseudorandom_element(cardInRank,pseudoseed("himeko_lowest_rank"))
               if randomCard then
                  addToDestroy(card,{randomCard})
               end
            end

            if card.ability.extra.currentEidolon >= 1 then
               buffJoker(card,card,"himeko_e1")
            end
            if #differentSuits >= 4 and card.ability.extra.currentEidolon >= 3 then
               card.ability["himeko_e3_proc"] = true
            end
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("hsr_himeko_message")})
         end
      end

      if context.individual and context.cardarea == G.play and card.ability["himeko_fua"] then
         local clone = {}
         for _,v in ipairs(G.play.cards) do
            clone[#clone+1] = v
         end
         card.ability.extra["himeko_registeredHand"] = clone

         local xMult = 1.2
         if card.ability["himeko_e3_proc"] then
            xMult = 2
         end
         return {
            xchips = calculateBaseMulti(card,card.ability.extra.element,1.2,nil,false,true,context.other_card),
            xmult = calculateBaseMulti(card,card.ability.extra.element,xMult,nil,false,true,context.other_card),
         }
      end

      if context.cardarea == G.play and context.repetition and card.ability["himeko_fua"] then
         local rep = 0
         local himekoFUA = false
         if card.ability.extra.currentEidolon >= 6 then
            himekoFUA = true
            rep = rep + 1
         end

         if rep > 0 then
            return {
               message = (himekoFUA and 'Trailblaze!') or ('Again!'),
               repetitions = rep,
               card = card
            }
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

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Bailu
   key = 'Bailu',
   config = {
      extra = CardStats["config"]["Bailu"]
   },
   loc_txt = {
      name = 'Bailu',
      text = {
        'they stole our potentially best girl...'
      },
   },
   atlas = 'Jokers',
   rarity = 4,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self,card,context)
      local extraStuff = card.ability.extra
      UltCooldownContext(card,{"onHandPlay", "onDiscard"}, {"ultCooldown1","ultCooldown2"},context)

      --[[ That day when I replaced 6 lines of code with 1 line of a function with 75 lines :3
      if context.pre_discard and context.main_eval and not context.blueprint then --Ultimate Cooldown (Discard)
         card.ability.extra.ultCooldown2 = UltCooldownHandler(card.ability.extra.ultCooldown2,card.ability.extra.ultRequiredCooldown2,card)
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint then --Ultimate Cooldown (Hands)
         card.ability.extra.ultCooldown1 = UltCooldownHandler(card.ability.extra.ultCooldown1,card.ability.extra.ultRequiredCooldown1,card)
      end]]

      if context.end_of_round and G.GAME.blind.boss and card.ability["bailu_e6_proc"] then
         card.ability["bailu_e6_proc"] = nil
      end

      if context.end_of_round then
         card.ability["bailu_ult_proc"] = false
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint then
         if G.GAME.current_round.hands_left <= 0 and card.ability.extra.currentEidolon >= 6 and not card.ability["bailu_e6_proc"] then
            card.ability["bailu_e6_proc"] = true
            ease_hands_played(G.GAME.round_resets.hands)
         end
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint and card.ability.extra.ultCooldown2 >= card.ability.extra.ultRequiredCooldown2 and card.ability.extra.ultCooldown1 >= card.ability.extra.ultRequiredCooldown1 and not card.ability["bailu_ult_proc"] then
         card.ability.extra.ultCooldown1 = 0
         card.ability.extra.ultCooldown2 = 0
         card.ability["bailu_ult_proc"] = true
         local toCopy = G.play.cards
         local copied = {}
         local randomTime = 3

         local copied2 = {}
         for i,v in ipairs(toCopy) do
            copied[i] = v
         end

         local placeholderTable = {}

         local uniques = 0
         local repeated = 0

         for i = 1,randomTime do
            copied2[#copied2+1] = pseudorandom_element(copied,pseudoseed("bailu_rng"))
         end

         if card.ability.extra.currentEidolon >= 1 then
            for _,joker in ipairs(G.jokers.cards) do
               buffJoker(card,joker,"bailu_e1")
            end
         end

         if card.ability.extra.currentEidolon >= 2 then
            buffJoker(card,card,"bailu_e2")
         end

         for _,v in ipairs(copied2) do
            local isUnique = BalatroSR.tableIsUnique(copied2, placeholderTable, {v})
            if BalatroSR.tableIsUnique(copied2, placeholderTable, {v}) then
               uniques = uniques + 1
            else
               repeated = repeated + 1
            end

            placeholderTable[#placeholderTable+1] = v

            G.E_MANAGER:add_event(Event({
               trigger = 'before',
               delay = 0.2,
               func = function()
                  if isUnique then
                     ease_hands_played(1,true)
                  else
                     ease_discard(1,true)
                  end
                  v:juice_up()
                  return true
                end
            }))
         end

         if uniques >= 1 and card.ability.extra.currentEidolon >= 4 then
            for i = 1,uniques do
               for _,joker in ipairs(G.jokers.cards) do
                  buffJoker(card,joker,"bailu_e4")
               end
            end
         end

         return {
            message = localize("hsr_bailu_message"),
         }
      end

      local ret = HSRContextHandler(self,card,context)
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.ultCooldown1,
         center.ability.extra.ultRequiredCooldown1,
         center.ability.extra.ultCooldown2,
         center.ability.extra.ultRequiredCooldown2,
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Jing Yuan
   key = 'JingYuan',
   config = {
      extra = CardStats["config"]["JingYuan"]
   },
   loc_txt = {
      name = 'Jing Yuan',
      text = {
         'stop getting buffed like every version wtf'
      },
   },
   atlas = 'Jokers',
   rarity = 4,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self,card,context)
      local extraStuff = card.ability.extra
      if context.before and context.cardarea == G.jokers and not context.blueprint and not context.retrigger_joker then
         clearBuffJoker(card,card,"jy_e4")
         if card.ability.extra.currentEidolon >= 3 then
            card.ability.extra.hpa = 2
         else
            card.ability.extra.hpa = 0
         end

         local toCopy = G.play.cards
         local copied = {}

         local differentSuits = {}
         local differentRanks = {}

         for i,v in ipairs(toCopy) do
            copied[i] = v
         end

         for i,v in ipairs(copied) do
            for _,suit in ipairs(AllSuits) do --Check for Unique Suits
               local uniqueSuit = true
               for _,foundSuit in ipairs(differentSuits) do
                  if foundSuit == suit then
                     uniqueSuit = false
                     break
                  end
               end

               if uniqueSuit and v:is_suit(suit) then
                  differentSuits[#differentSuits+1] = suit
               end
            end

            for i = 1,14 do
               local uniqueRank = true
               for _,foundRank in ipairs(differentRanks) do
                  if foundRank == i then
                     uniqueRank = false
                     break
                  end
               end

               if uniqueRank and v:get_id() == i then
                  differentRanks[#differentRanks+1] = i
               end
            end
         end

         if #differentRanks > 0 then
            card.ability.extra.hpa = card.ability.extra.hpa + #differentRanks
         end
      end

      if context.joker_main then
         if card.ability.extra.hpa > 0 then
            local cardsToDestroy = {}
            if card.ability.extra.currentEidolon >= 4 then
               for _ = 1, card.ability.extra.hpa do
                  buffJoker(card,card,"jy_e4")
               end
            end

            for _ = 1,card.ability.extra.hpa do
               local radCard = pseudorandom_element(G.hand.cards,pseudoseed("jingyuan_ll_rng"))
               radCard = BalatroSR.adjacentCards(radCard,G.hand,false)

               card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("hsr_jingyuan_message")})

               for _,cardInHand in ipairs(radCard) do
                  local jy_Mult = 5
                  local jy_xMult = 1
                  local jy_xChips = 1

                  if SMODS.has_enhancement(cardInHand, 'm_lucky') then
                     if pseudorandom("hsr_jy_luckycheck") <= 1/2 then
                        jy_xMult = jy_xMult + 0.2
                     end
                  end

                  if SMODS.has_enhancement(cardInHand, 'm_mult') then
                     jy_xMult = jy_xMult + 0.1
                  end

                  if SMODS.has_enhancement(cardInHand, 'm_glass') then
                     jy_xChips = jy_xChips + 0.5
                     table.insert(cardsToDestroy,cardInHand)
                  end

                  if card.ability.extra.currentEidolon >= 1 then
                     jy_Mult = jy_Mult * 1.25
                     if jy_xMult ~= 1 then
                        jy_xMult = jy_xMult * 1.25
                     end
                     if jy_xChips ~= 1 then
                        jy_xChips = jy_xChips * 1.25
                     end
                  end

                  if card.ability.extra.currentEidolon >= 2 then
                     buffJoker(card,card,"jy_e2")
                  end

                  if card.ability.extra.currentEidolon >= 6 then
                     inflictDebuff(card,cardInHand,"jy_e6")
                  end

                  SMODS.calculate_effect({mult = calculateBaseMulti(card,card.ability.extra.element,jy_Mult,nil,false,nil,cardInHand), xmult = calculateBaseMulti(card,card.ability.extra.element,jy_xMult,nil,false,true,cardInHand), xchips = calculateBaseMulti(card,card.ability.extra.element,jy_xChips,nil,false,true,cardInHand)}, cardInHand)
                  G.E_MANAGER:add_event(Event({
                     trigger = 'before',
                     blockable = false,
                     delay = 0.0,
                     func = function()
                        cardInHand:juice_up()
                        return true
                      end
                  }))
               end
            end

            if #cardsToDestroy >= 1 then
               addToDestroy(card,cardsToDestroy)
            end

            clearBuffJoker(card,card,"jy_e4")
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

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.ultCooldown1,
         center.ability.extra.ultRequiredCooldown1,
         center.ability.extra.ultCooldown2,
         center.ability.extra.ultRequiredCooldown2,
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Clara
   key = 'Clara',
   config = {
      extra = CardStats["config"]["Clara"]
   },
   loc_txt = {
      name = 'Clara',
      text = {
        'oh mah gotto robboto girlo :O'
      },
   },
   atlas = 'Jokers',
   rarity = 4,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self,card,context)
      local extraStuff = card.ability.extra
      if card.ability.extra.currentEidolon >= 4 then
         card.ability.extra.xMult = 1 + (0.1 * math.floor(card.ability.extra.mult/100))
      end

      if context.destroy_card then
         if card.ability["card_to_destroy"] then
            for index,destroyingCard in pairs(card.ability["card_to_destroy"]) do
               if context.destroy_card == destroyingCard then
                  local adjacentCards = BalatroSR.adjacentCards(context.destroy_card,G.hand,true,3)

                  if card.ability.extra.currentEidolon >= 1 and adjacentCards then
                     for _,cardInHand in ipairs(adjacentCards) do
                        if cardInHand.ability and not cardInHand.ability["clara_mark"] then inflictDebuff(card,cardInHand,"clara_mark","Marked!") end
                     end
                  end

                  if card.ability.extra.currentEidolon >= 2 then
                     buffJoker(card,card,"clara_e2")
                  end

                  card.ability["card_to_destroy"][index] = nil
                  return {
                     remove = true
                  }
               end
            end
         end
      end

      if context.first_hand_drawn or context.hand_drawn then
         local filteredCards = {}
         for _,v in ipairs(G.hand.cards) do
            if v.ability and not v.ability["clara_mark"] then
               filteredCards[#filteredCards+1] = v
            end
         end

         local radCard = pseudorandom_element(filteredCards,pseudoseed("clara_rng"))
         inflictDebuff(card,radCard,"clara_mark", "Marked!")
      end

      if context.joker_main and not context.blueprint_compat then
         local markedCards = {}
         for _,v in ipairs(G.hand.cards) do
            if v.ability and v.ability["clara_mark"] then
               markedCards[#markedCards+1] = v
            end
         end

         addToDestroy(card,markedCards)

         if #markedCards >= 1 then
            local multIncrease = 10

            if card.ability.extra.currentEidolon >= 6 then
               multIncrease = multIncrease + 40
            end

            card.ability.extra.mult = card.ability.extra.mult + (multIncrease * #markedCards)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("hsr_increase")})
         end
      end

      local ret = HSRContextHandler(self,card,context,{["destroy_card"] = true})
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.mult
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Seele
   key = 'Seele',
   config = {
      extra = CardStats["config"]["Seele"]
   },
   loc_txt = {
      name = 'Seele',
      text = {
        'hot yuri seggs with bronya... :3'
      },
   },
   atlas = 'Jokers',
   rarity = 4,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = true,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
      if #G.playing_cards > 0 then
         local randomCard = pseudorandom_element(G.playing_cards,pseudoseed("seele_rng"))
         if randomCard then
            card.ability.extra.repeatSuit = randomCard.base.suit
            card.ability.extra.chosenRank = randomCard.base.id
         end
      end
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self,card,context)
      local extraStuff = card.ability.extra
      if card.ability.extra.currentEidolon >= 2 and not card.ability["seele_e2"] then
         buffJoker(card,card,"seele_e2")
      end
      if card.ability.extra.currentEidolon >= 3 and not card.ability["seele_e3"] then
         buffJoker(card,card,"seele_e3")
      end
      if card.ability.extra.currentEidolon >= 5 and not card.ability["seele_e5"] then
         buffJoker(card,card,"seele_e5")
      end

      if context.before and context.cardarea == G.jokers and not context.blueprint and not context.retrigger_joker then
         if card.ability.extra.currentEidolon >= 1 then
            if scoreCheck("low",80) and not card.ability["seele_e1"] then
               buffJoker(card,card,"seele_e1")
            elseif not scoreCheck("low",80) and card.ability["seele_e1"] then
               clearBuffJoker(card,card,"seele_e1")
            end
         end

         if card.ability.extra.currentEidolon >= 6 then
            for _,cardInHand in ipairs(G.play.cards) do
               inflictDebuff(card,cardInHand,"seele_butterfly_flurry","Butterfly Flurry!",true)
            end
         end
      end

      if context.after and context.cardarea == G.jokers and not context.blueprint then
         if #G.playing_cards > 0 then
            local randomCard = pseudorandom_element(G.playing_cards,pseudoseed("seele_rng2"))
            if randomCard then
               card.ability.extra.repeatSuit = randomCard.base.suit
               card.ability.extra.chosenRank = randomCard.base.id
            end
         end
         --[[card.ability.extra.repeatSuit = pseudorandom_element(AllSuits)
         card.ability.extra.chosenRank = pseudorandom_element({2,3,4,5,6,7,8,9,10,11,12,13,14})]]
      end

      if context.individual and context.cardarea == G.play then
         local s_xMult = 1
         local s_xChips = 1
         if context.other_card:is_suit(card.ability.extra.repeatSuit) then
            s_xMult = s_xMult + 0.1
         end

         if context.other_card:get_id() == (card.ability.extra.chosenRank) then
            s_xChips = s_xChips + 0.1
         end

         if context.other_card:is_suit(card.ability.extra.repeatSuit) and context.other_card:get_id() == (card.ability.extra.chosenRank) and card.ability.extra.currentEidolon >= 4 then
            s_xMult = 1.5
            s_xChips = 1.5
         end

         return {
            xmult = calculateBaseMulti(card,card.ability.extra.element,s_xMult,nil,false,nil,context.other_card),
            xchips = calculateBaseMulti(card,card.ability.extra.element,s_xChips,nil,false,nil,context.other_card),
         }
      end

      if context.cardarea == G.play and context.repetition and context.other_card:is_suit(card.ability.extra.repeatSuit) and not context.retrigger_joker then
         print(context.retrigger_joker)
         return {
            card = card,
            message = localize("hsr_seele_message"),
            repetitions = 1,
         }
      end

      local ret = HSRContextHandler(self,card,context)
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         string.sub(center.ability.extra.repeatSuit,1,(#center.ability.extra.repeatSuit - 1)),
         BalatroSR.turnIDToText(center.ability.extra.chosenRank),
         colours = {G.C.SUITS[center.ability.extra.repeatSuit]}
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Bronya
   key = 'Bronya',
   config = {
      extra = CardStats["config"]["Bronya"]
   },
   loc_txt = {
      name = 'Bronya',
      text = {
        'basically blueprint but on steroids'
      },
   },
   atlas = 'Jokers',
   rarity = 4,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = false,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra
      local other_joker = nil
		local lastPos = #G.jokers.cards
      local lastJoker = G.jokers.cards[lastPos]
      if lastJoker and lastJoker ~= card and lastJoker.ability and string.find(lastJoker.config.center.key,"j_hsr_") then
         other_joker = lastJoker
      else
         repeat
            lastPos = lastPos - 1
            if lastPos >= 1 then
               lastJoker = G.jokers.cards[lastPos]
               if lastJoker and lastJoker ~= card and lastJoker.ability and string.find(lastJoker.config.center.key,"j_hsr_") and lastJoker.config.center.key ~= "j_hsr_Bronya" then
                  other_joker = lastJoker
               end
            end
         until other_joker or lastPos <= 0
      end

		if other_joker and other_joker ~= card then
         --[[ Blueprint context
			context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
			context.blueprint_card = context.blueprint_card or card

			if context.blueprint > #G.jokers.cards + 1 then
				return
			end

			local other_joker_ret, trig = other_joker:calculate_joker(context)
         context.blueprint = nil
			if other_joker_ret or trig then
				if not other_joker_ret then
					other_joker_ret = {}
				end
				other_joker_ret.card = context.blueprint_card or card
            context.blueprint_card = nil
				other_joker_ret.colour = G.C.GREEN
				other_joker_ret.no_callback = true
				return other_joker_ret
			end
         context.blueprint_card = nil]]

         if context.retrigger_joker_check and context.other_card ~= card and context.other_card == other_joker then
            return{
               repetitions = 1,
            }
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

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.xMult
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar)
   end,
}

SMODS.Joker{ --Kafka
   key = 'Kafka',
   config = {
      extra = CardStats["config"]["Kafka"]
   },
   loc_txt = {
      name = 'Kafka',
      text = {
         'dot queen, my beloved'
      },
   },
   atlas = 'Jokers',
   rarity = 4,
   cost = 1,
   unlocked = true,
   discovered = true,
   blueprint_compat = false,
   eternal_compat = true,
   perishable_compat = false,
   in_pool = function(self, args)
      return false
   end,
   pos = {x = 1, y = 0},

   update = function(self, card, dt)
      HDUpdate(card)
      loadRelics(card)
   end,

   add_to_deck = function(self, card, from_debuff)
		HDAdd(card)
	end,

	remove_from_deck = function(self, card, from_debuff)
		HDRemove(card)
	end,

   calculate = function(self, card, context)
      local extraStuff = card.ability.extra      

      UltCooldownContext(card,"discardCards","ultCooldown",context)

      if context.before and context.cardarea == G.jokers and card.ability.extra.ultCooldown >= card.ability.extra.ultRequiredCooldown then
         card.ability.extra.ultCooldown = 0
         for _,v in ipairs(G.hand.cards) do
            inflictDebuff(card,v,"kafka_dot","Amplified Shock!",true,nil,true) 
         end
      end

      if context.before and context.cardarea == G.jokers then
         local radius = 2
         local radCards = BalatroSR.adjacentCards(pseudorandom_element(G.hand.cards,pseudoseed("kafka_rng")),G.hand,false,radius)

         for _,cardInHand in ipairs(radCards) do
            cardInHand.ability.kafka_shock_dot_eidolon = card.ability.extra.currentEidolon

            if not cardInHand.ability.kafka_e6 and card.ability.extra.currentEidolon >= 6 and not context.blueprint then
               inflictDebuff(card,cardInHand,"kafka_e6")
            end

            if not cardInHand.ability.kafka_e3 and card.ability.extra.currentEidolon >= 3 and not context.blueprint then
               inflictDebuff(card,cardInHand,"kafka_e3")
            end

            if not cardInHand.ability.kafka_da_capo and card.ability.extra.currentEidolon >= 1 and not context.blueprint then
               inflictDebuff(card,cardInHand,"kafka_da_capo")
            end

            inflictDebuff(card,cardInHand,"kafka_dot","Amplified Shock!",true,"Shock!") 
         end
      end

      if context.individual and context.cardarea == G.hand and not context.end_of_round then
         return(calculateDOT(card,context))
      end

      if context.discard and card.ability.extra.currentEidolon >= 2 and not context.blueprint then
         for i,v in ipairs(G.hand.highlighted) do
            local cardInHand = G.hand.highlighted[i]
            
            if cardHasDebuff(cardInHand,"shock_dot") then
               return {
                  dollars = 5,
               }
            end
         end
      end

      if ((card:get_edition() and card.edition.key ~= "e_negative") or not card:get_edition()) and card.ability.extra.currentEidolon >= 6 then
         card:set_edition("e_negative",true)
      end

      local ret = HSRContextHandler(self,card,context)
      if ret then
         return ret
      end
   end,

   generate_ui = function(self, info_queue, center, desc_nodes, specific_vars, full_UI_table)
      local speedIncrease = 0
      local cardAbility = center.ability

      local allGains = collectStats(center)

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
         allGains["speed"], --20
         center.ability.extra.excess_action_value, --21
         allGains["atkMulti"] * 100 - 100, --22
         allGains["bee"] * 100 - 100, --23
         allGains["elementMulti"] * 100 - 100, --24
         allGains["otherStats"], --25
         ---Planar
         center.ability.extra.orbName, --26
         center.ability.extra.orbEffect, --27 
         center.ability.extra.ropeName, --28
         center.ability.extra.ropeEffect, --29 
         center.ability.extra.planarsetEffect, --30
         --Other vars
         center.ability.extra.shockMult,
         center.ability.extra.e4Buff,
         center.ability.extra.e5Buff,
         center.ability.extra.ultCooldown,
         center.ability.extra.ultRequiredCooldown
      }

      local siq = {
         {
            {
               set = 'Other',
               key = 'hsr_dot_shock'
            },
            {
               set = 'Other',
               key = 'hsr_dot_amplified_shock'
            },
         },
         {
            {
               set = 'Other',
               key = 'hsr_dot_shock'
            },
            {
               set = 'Other',
               key = 'hsr_dot_amplified_shock'
            },
         },
      }

      hsr_generate_UI(self,info_queue,center,desc_nodes,specific_vars,full_UI_table,returnVar,siq)
   end,
}

local hookTo = end_round
end_round = function() --Clear all buffs/debuffs at the end of round
   local ret = hookTo()
   clearDebuff()
   clearJokerBuffs()
   return ret
end

local hookTo = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e) --Test
   local ret = hookTo(e)
   --print("good morning sunshine")
   return ret
end

local hookTo = new_round
new_round = function() --Helping with new "Turn" handler
   local ret = hookTo()
   G.GAME["hsr_states"] = {}
   G.GAME["hsr_states"]["turn_elapsed_pass"] = true

   return ret
end

local hookTo = G.FUNCS.draw_from_deck_to_hand
G.FUNCS.draw_from_deck_to_hand = function(e) --To handle when a new "Turn" passes
   local ret = hookTo(e)

   if G.GAME["hsr_states"] and G.GAME["hsr_states"]["turn_elapsed_pass"] then
      G.GAME["hsr_states"]["turn_elapsed_pass"] = false
   else
      --BalatroSR.debugTool("Turn Elapsed!")
      hsr_turn_pass()
   end

   return ret
end
