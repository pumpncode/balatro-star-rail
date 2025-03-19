--Welcome to where I store ALL of my (maybe) useful functions!
--Feel free to grab anything here :3

BalatroSR.enhanceCard = function(card,other_card,enhancement,after,immediate,no_effects,haltunhighlight) --Enhance cards.
    if not no_effects then
        for _,othercard in ipairs(other_card) do
           G.E_MANAGER:add_event(Event({
              trigger = (after and 'after') or (immediate and "immediate") or 'before',
              delay = 0.2,
              func = function()
                 othercard:flip()
                 othercard:juice_up()
                 if not haltunhighlight then
                    G.hand:add_to_highlighted(othercard)
                 end
                 return true
               end
           }))
        end
     end

     for _,othercard in ipairs(other_card) do
        local e = enhancement
        if type(enhancement) == "table" then
           e = pseudorandom_element(enhancement)
        end
        othercard:set_ability(G.P_CENTERS[e],nil,true)
     end

     if not no_effects then
        for _,othercard in ipairs(other_card) do
           G.E_MANAGER:add_event(Event({
              trigger = (after and 'after') or (immediate and "immediate") or 'before',
              delay = 0.2,
              func = function()
                 othercard:flip()
                 if not haltunhighlight then
                    G.hand:remove_from_highlighted(othercard)
                 end
                 return true
               end
           }))
        end
    end    
end
 
BalatroSR.unenhanceCard = function(card,other_card,after,immediate,no_effects,haltunhighlight) --Unenhance cards.
    BalatroSR.enhanceCard(card,other_card,"c_base",after,immediate,no_effects,haltunhighlight)
end

BalatroSR.animatedChangeBase = function(card, suit, rank, after, immediate, no_effects, haltunhighlight, immediateSuitChange)
    if immediateSuitChange then
        for _,othercard in ipairs(card) do
            local chosenRank = rank
            local chosenSuit = suit
        
            if type(chosenRank) == "table" then
                chosenRank = pseudorandom_element(chosenRank)
            end
        
            if type(chosenSuit) == "table" then
                chosenSuit = pseudorandom_element(chosenSuit)
            end
    
            SMODS.change_base(othercard,chosenSuit,chosenRank)
        end
    end

    if not no_effects then
        for _,othercard in ipairs(card) do
           G.E_MANAGER:add_event(Event({
              trigger = (after and 'after') or (immediate and "immediate") or 'before',
              delay = 0.2,
              func = function()
                 othercard:flip()
                 othercard:juice_up()
                 if not haltunhighlight then
                    G.hand:add_to_highlighted(othercard)
                 end
                 return true
               end
           }))
        end
    end

    --[[for _,othercard in ipairs(card) do

    end]]

    if not no_effects then
        for _,othercard in ipairs(card) do
           G.E_MANAGER:add_event(Event({
              trigger = (after and 'after') or (immediate and "immediate") or 'before',
              delay = 0.2,
              func = function()
                if not immediateSuitChange then
                    local chosenRank = rank
                    local chosenSuit = suit
                
                    if type(chosenRank) == "table" then
                        chosenRank = pseudorandom_element(chosenRank)
                    end
                
                    if type(chosenSuit) == "table" then
                        chosenSuit = pseudorandom_element(chosenSuit)
                    end
            
                    SMODS.change_base(othercard,chosenSuit,chosenRank) 
                end

                 othercard:flip()
                 if not haltunhighlight then
                    G.hand:remove_from_highlighted(othercard)
                 end
                 return true
               end
           }))
        end
    end    
end
 
BalatroSR.addToTable = function(a,b) --Add all content from table b to table a which are not already in table a.
    if type(a) ~= "table" or type(b) ~= "table" then
       return {}
    end
 
    local ret = a
 
    for i,v in ipairs(b) do
       local alreadyExisting = false
       for g,h in ipairs(ret) do if h == v then alreadyExisting = true break end end --Ignore content from table b if it already exists in table a.
       
       if not alreadyExisting then
          ret[#ret+1] = v
       end
    end
 
    return ret
end
 
BalatroSR.selectRandomCards = function(b,c) --In its name.
    local min = 1
    local max = b or 1
 
    local area = {}
    for _,v in ipairs(c) do
       area[#area+1] = v
    end
 
    local ret = {}
 
    for i = min,max do
       ret[#ret+1] = pseudorandom_element(area)
       for index,v in ipairs(area) do
          if v == ret[#ret] then
             area[index] = nil
          end
       end
    end
 
    return ret
end

BalatroSR.tableIsUnique = function(a,b,c) --If table a has no elements similar to table b, return true. Else, return false. If c is declared, only return false if both table a and table b have c.
    if c then
       if type(c) == "table" then
          for _,v in ipairs(c) do
             for _,v2 in pairs(a) do
                if v2 == v then
                   for _,v3 in pairs(b) do
                      if v3 == v then
                         return false
                      end
                   end
                end
             end
          end
 
       else
          for _,v2 in pairs(a) do
             if v2 == c then
                for _,v3 in pairs(b) do
                   if v3 == v then
                      return false
                   end
                end
             end
          end
 
       end
    else
 
       for _,v1 in pairs(a) do
          for _,v2 in pairs(b) do
             if v2 == v1 then
                return false
             end
          end
       end
       
    end
 
    return true 
end

BalatroSR.convertFromPercentage = function(i) --...yeah.
    return i/100
end

BalatroSR.incrementAll = function(table) --Increase the individual number by all numbers in a table.
    if table and type(table) == "table" then
        local a = 0
        for _,v in pairs(table) do
            if type(v) == "number" then
                a = a + v
            end
        end
        return a
    elseif table and type(table) == "number" then
        return table
    else
        print("Unreadable numbers [function: incrementAll]")
        return false
    end
end

BalatroSR.multiplyAll = function(num,table) --Multiply the individual number with all numbers in a table.
    local a = 0
    if num and table and type(num) == "number" and type(table) == "table" then
        a = num
        for _,v in pairs(table) do
            if type(v) == "number" then
                a = a * v
            end
        end
    elseif num and table and type(num) == "number" and type(table) == "number" then
        a = num * table
    else
        print("Unreadable numbers [function: multiplyAll]")
        return 0
    end
    return a
end

BalatroSR.findPart = function(str,startPos,endCharacter) --Find certain parts of a string.
    local endPos = 0

    for i = startPos, #str do
        local character = str:sub(i,i)
        if character == endCharacter then
            endPos = i
            break
        end
    end

    local foundPart = string.sub(str,startPos,endPos)
    return foundPart
end

function removeParts(b,replace) --Remove certain parts of a string.
    local partToRemove = {
        "{C:",
        "{X:",
        "{s:",
    } 

    if type(b) == "string" then    
        local finalStr = b            
        for _,part in pairs(partToRemove) do
            local additionalSpace = 0
            for i = 1,#finalStr do
                local threeChars = string.sub(finalStr, i + additionalSpace, i + additionalSpace + 2)
                if threeChars == part then
                    local startPos = i + additionalSpace
                    local foundPart = BalatroSR.findPart(finalStr,startPos,"}")
                    additionalSpace = additionalSpace + (#finalStr + (#foundPart - #finalStr))
                    finalStr = finalStr:gsub(foundPart,"")
                end
            end
        end
        finalStr = finalStr:gsub("{}","")

        local startPos = 0
        if replace then
            for g = 1, #finalStr do
                local character = finalStr:sub(g,g)
                if character == "#" then
                    startPos = g
                    break
                end
            end

            finalStr = finalStr:gsub("#"..BalatroSR.findPart(finalStr,startPos + 1,"#"),replace)
        end

        return finalStr
    end
end

BalatroSR.firstToUpper = function(str) --Uppercase the first letter.
    return (str:gsub("^%l", string.upper))
end

BalatroSR.toNormalString = function(a,replace) --Convert colored strings to normal strings.
    local returnStr = nil

    if a and type(a) == "table" then
        returnStr = {}
        for i,str in pairs(a) do
            if type(str) == "string" then                
               local result = removeParts(str,replace)
               returnStr[i] = result
            end
        end
    elseif a and type(a) == "string" then
        if type(a) == "string" then                
            local result = removeParts(a,replace)
            returnStr = result
        end
    else
        print("Unreadable string [function: toNormalString]")
        return ""
    end

    return returnStr
end

function string.insert(str1, str2, pos) --...need I explain?
    return str1:sub(1,pos)..str2..str1:sub(pos+1)
end

BalatroSR.trueIfNumber = function(a) --Return true if the input value is a number.
    if a and (tonumber(a) or type(a) == "number") then return true end
end

BalatroSR.automaticColoring = function(a, fullModify) --spaghetti code :sob: But basically, it automatically colors certain parts of a string.
    if a and type(a) == "string" then
        local returnStr = a
        local additionalSpace = 0 --Since we will be adding {}, {C:mult},... a lot into the string, we will need this to let the code know the string has been expanded, or vice versa.

        local modifications = {
            ["s"] = nil, --The entire string will change its size accordingly to this.
            ["C"] = nil, --The entire string will change its color accordingly to this except gains, though it can be changed.
            ["X"] = nil, --The entire string will change its background accordingly to this. Not sure why you would want that, but it's an option.
            ["V"] = nil,
            ["E"] = nil,
            ["change_gains"] = true, --Allows X1.5, +30.4, etc. to change colour to their presets respective to its buff (Chips, Mult, Xchips,...)
            ["override_gains_modifications"] = false, --Allows gains to be changed with modifications["s"] and modifications["C"]. ignoring its preset if true. For consistency, Size is still changed accordingly regardless of whether this is enabled or not.
            ["force_keep_gains_size"] = false, --If enabled, gains will be the same size regardless of modifications["s"].
            ["override_keywords"] = false,

            --All of those are presets for what gains should look like in a Joker's description which I don't really suggest changing. Though, you do you.
            --Also, you can add ["s"] in here and it will also work individually for only a specific gain type.
            ["mult"] = {
                ["C"] = "mult",
            },
            ["chips"] = {
                ["C"] = "chips",
            }, 
            ["Xmult"] = {
                ["X"] = "mult",
                ["C"] = "white",
            },
            ["Xchips"] = {
                ["X"] = "chips",
                ["C"] = "white",
            },   

            ["additional_keywords"] = (fullModify["additional_keywords"] or {})

            --[[How to add keywords, as an example:
            ["additional_keywords"] = {
                ["Hello World!"] = {
                    ["C"] = "white",
                },
            }
            ]]
        }

        --Change modifications if input (fullModify) is made.
        if fullModify and type(fullModify) == "table" then
            for i,v in pairs(fullModify) do
                modifications[i] = v
            end
        end

        if not modifications["change_gains"] then goto continue end --Basically, skip the entire thing.
        for i = 1,#returnStr do --Check for gains.
            local character = returnStr:sub(i+additionalSpace,i+additionalSpace) --Check for each character in the string.
            if character == "X" or character == "+" then --This will help me choose parts which start with X and +.
                local startPosForColoring = i+additionalSpace-1 --Tell the code where to start with finding the gain. (Ex: X3.5)
                local endPosForColoring = i+additionalSpace --Placeholder, tell the code where to end. In the middle of startPosForColoring and endPosForColoring is where the gain is.
                local color = nil --Either "chips" or "mult".
                local canBeColored = false --...yeah
                local ogCharacter = character --Basically telling whether it's "X" or "+", made a big oopsie down there so I made this variable.

                for g = i+additionalSpace+1,#returnStr do
                    character = returnStr:sub(g,g)
                    if tonumber(character) or character == "." then
                        endPosForColoring = g
                        canBeColored = true
                    else
                        break
                    end
                end --This loop is to help knowing the exact location of the gain.

                if not canBeColored then goto inside_continue end --So that if it's just a normal +, X without numbers behind then the code will not consider it as a gain.

                for g = endPosForColoring,#returnStr do
                    local keyword = returnStr:sub(g,g+3)
                    if string.lower(keyword) == "chip" then
                        color = "chips"
                        break
                    elseif string.lower(keyword) == "mult" then
                        color = "mult"
                        break
                    end
                end

                local coloredPart = string.sub(returnStr,startPosForColoring+1,endPosForColoring) --The gain itself.

                local a = string.sub(returnStr,1,startPosForColoring)
                local b = string.sub(returnStr,endPosForColoring+1,#returnStr) 
                --Cutting the string into two halves with the gain being the middle part. So, the whole string is technically "a..coloredPart..b".
                local addon = "{"

                function modify(x,y)
                    local returnStr = addon

                    if not modifications["force_keep_gains_size"] and x == "s" and modifications[x] and BalatroSR.trueIfNumber(modifications[x]) then
                        returnStr = returnStr..x..":"..modifications[x]..","
                    end

                    if modifications["override_gains_modifications"] then
                        if modifications[x] then
                            if x == "s" and not modifications["force_keep_gains_size"] then
                                returnStr = returnStr..x..":"..modifications[x]..","
                            else
                                returnStr = returnStr..x..":"..modifications[x]..","
                            end
                        end
                    end
        
                    if not string.find(returnStr,x..":") then 
                        if x == "s" or x == "V" or x == "E" then
                            if modifications[y][x] and BalatroSR.trueIfNumber(modifications[y][x]) and ((not modifications["override_gains_modifications"]) or (modifications["override_gains_modifications"] and not modifications[x])) then
                                returnStr = returnStr..x..":"..modifications[y][x]..","
                            end
                        else
                            if modifications[y][x] and ((not modifications["override_gains_modifications"]) or (modifications["override_gains_modifications"] and not modifications[x])) then
                                returnStr = returnStr..x..":"..modifications[y][x]..","
                            end
                        end 
                    end
        
                    addon = returnStr
                end

                if ogCharacter == "X" then
                    modify("s","X"..color) --Size handler
                    modify("C","X"..color) --Text color handler
                    modify("X","X"..color) --Background color handler
                    modify("V","X"..color) 
                    modify("E","X"..color) 
                elseif ogCharacter == "+" then
                    modify("s",color) --Size handler
                    modify("C",color) --Text color handler
                    modify("X",color) --Background color handler
                    modify("V",color) 
                    modify("E",color) 
                end

                addon = string.sub(addon,1,#addon-1)
                addon = addon.."}"

                --addon is basically "{s:0.5,C:mult}".
                
                local ending = "{}"
                local newString = a..addon..coloredPart..ending..b --Fusing everything together into one string.
                additionalSpace = additionalSpace + (#newString - #returnStr)
                returnStr = newString
            end
            ::inside_continue::
        end
        ::continue::

        if modifications["additional_keywords"] ~= {} then
            for i,v in pairs(modifications["additional_keywords"]) do
                local placeholderStr = returnStr
                local start,ending = nil, nil
                local addSpace = 0
                local awaitingKeywords = {}

                repeat
                    if string.find(placeholderStr,i) then
                        start,ending = string.find(placeholderStr,i)

                        local cut1 = string.sub(placeholderStr,1,start)
                        local cut2 = string.sub(placeholderStr,ending+1,#placeholderStr)

                        placeholderStr = cut1..cut2

                        if not awaitingKeywords[i] then
                            awaitingKeywords[i] = {{
                                ["startPos"] = (start + addSpace),
                                ["endPos"] = (ending + addSpace),
                            },}
                        else
                            awaitingKeywords[i][#awaitingKeywords[i]+1] = {
                                ["startPos"] = (start + addSpace),
                                ["endPos"] = (ending + addSpace),
                            }
                        end

                        addSpace = addSpace + #i - 1
                    end 
                until not string.find(placeholderStr,i)

                placeholderStr = returnStr

                if awaitingKeywords ~= {} then
                    for key,occurrences in pairs(awaitingKeywords) do
                        local newSpace = 0
                        for _,v in pairs(occurrences) do
                            local toAdd = "{"
                            local keywordConfig = modifications["additional_keywords"][key]
            
                            for cName, cVal in pairs(keywordConfig) do
                                toAdd = toAdd..cName..":"..cVal..","
                            end
        
                            local checkVars = {"s","X","C","V","E"}
                            for a,b in pairs(checkVars) do
                                if modifications[b] and not keywordConfig[b] then
                                    toAdd = toAdd..b..":"..modifications[b]..","
                                end 
                            end
            
                            if toAdd ~= "}" then
                                toAdd = string.sub(toAdd,1,#toAdd - 1)
                            end
                            toAdd = toAdd.."}"
            
                            local cut1 = string.sub(placeholderStr,1,v["startPos"]-1+newSpace)
                            local cut2 = string.sub(placeholderStr,v["endPos"]+1+newSpace,#placeholderStr)
            
                            placeholderStr = cut1..toAdd..key.."{}"..cut2
        
                            newSpace = newSpace + #toAdd + 2 --2 means the "{}" part.
                        end
                    end        
                    returnStr = placeholderStr
                end
        
            end            
        end

        if modifications["s"] or modifications["C"] or modifications["X"] or modifications["V"] or modifications["E"] then --If those variables are set, it will start going through the entire string to modify parts which aren't gains as well.
            additionalSpace = 0
            local placed = false --Whether addon (EX: {s:0.5}) has been placed, and if it was, it will place {} next.
            local halt = false --Stop the code from adding addon.
            local ending = "{}"
            local start = "{"

            function modify(x)
                local returnStr = start

                if modifications[x] then
                    if ((x == "s" or x == "V" or x == "E") and BalatroSR.trueIfNumber(modifications[x])) or (x ~= "s") then
                        returnStr = returnStr..x..":"..modifications[x]..","
                    end
                end
    
                start = returnStr
            end

            modify("s")
            modify("C")
            modify("X")
            modify("V")
            modify("E")

            start = string.sub(start,1,#start-1)
            start = start.."}"

            local f = 0 
            --[[I'm bad at naming variables, but here's the logic behind this:

            Basically, gains should be: 
                ...{s:0.5,C:mult}+5{}...
            
            ...and what I did is that if it finds the "{" part, then f will be set to 2, and it will only start placing addon if f is 0.
            Why did I do that? You can see that there's 2 "}" within the gain.
            ]]
            local i = 1
            repeat --this is so scuffed ngl
                local character = returnStr:sub(i+additionalSpace,i+additionalSpace)
                local characterBefore = returnStr:sub(i+additionalSpace-1,i+additionalSpace-1)
                local characterAfter = returnStr:sub(i+additionalSpace+1,i+additionalSpace+1)
                if not placed then
                    if (character == "s" or character == "C" or character == "X" or character == "V" or character == "E") and characterAfter == ":" and not halt then --{s:0.7}...{} <-- It will have to go through 2 "}" first before continuing.
                        f = 2 --Hence, this variable.
                        halt = true
                    elseif character ~= "{" and character ~= "}" and characterBefore ~= "{" and characterAfter ~= "}" and not halt then
                        local allowed = true

                        if allowed then
                            placed = true
                            returnStr = string.insert(returnStr,start,i + additionalSpace - 1)
                            additionalSpace = additionalSpace + #start 
                        end
                    elseif character == "}" and halt then
                        if f > 0 then
                            f = f - 1
                        end
                        if f <= 0 then
                            halt = false 
                        end
                    end
                elseif placed then
                    if character == "{" or (i + additionalSpace) == #returnStr then --It will place {} either at the correct position, or at the last character of the string where "{" isn't seen.
                        placed = false
                        if (i + additionalSpace) == #returnStr then
                            returnStr = string.insert(returnStr,ending,i + additionalSpace)                    
                        else
                            returnStr = string.insert(returnStr,ending,i + additionalSpace - 1)
                        end
                        additionalSpace = additionalSpace + #ending
                    end
                end
                i = i + 1
            until (i + additionalSpace) > #returnStr
        end

        return returnStr
    else
        print("Unreadable string [function: automaticColoring]")
        return ""
    end
end

function HelloWorld() --:3 Outdated, obsolete, power crept.
    print("Hello World!")
end

BalatroSR.debugTool = function(a) --Superior debugging function.
    if a then
        print(":3 i am sigma: "..a)
    else
        print(":3")
    end
end

BalatroSR.adjacentCards = function(card, area, ignoreMainCard, radius, random) --Useful for grabbing adjacent cards to a card.
    local pos = nil
    local unOrdered = {}
    local existingPos = {}
    local ret = {}
    for i,v in ipairs(area.cards) do
        if v == card then
            pos = i
            break
        end
    end

    if not pos then
        print("The card doesn't exist in the area. [function: adjacentCards]")
        return 
    end

    local increasedRadius = 0
    for i = 1,(radius or 1) do
        increasedRadius = increasedRadius + 1
        if (pos - increasedRadius) >= 1 and area.cards[pos - increasedRadius] ~= card then
            unOrdered[#unOrdered+1] = {
                ["pos"] = (pos - increasedRadius),
                ["card"] = area.cards[(pos - increasedRadius)]
            }
            existingPos[#existingPos+1] = (pos - increasedRadius)
        end

        if (pos + increasedRadius) <= #area.cards and area.cards[pos + increasedRadius] ~= card then
            unOrdered[#unOrdered+1] = {
                ["pos"] = (pos + increasedRadius),
                ["card"] = area.cards[(pos + increasedRadius)]
            }
            existingPos[#existingPos+1] = (pos + increasedRadius)
        end
    end
    
    if not ignoreMainCard then
        unOrdered[#unOrdered + 1] = {
            ["pos"] = pos,
            ["card"] = card
        }
        existingPos[#existingPos+1] = pos
    end

    table.sort(existingPos) 

    if not random then
        for _,v in ipairs(existingPos) do
            for _,b in pairs(unOrdered) do
                if b["pos"] == v then
                    ret[#ret+1] = b["card"]
                end
            end
        end

    else
        ret = unOrdered
    end

    return ret
end

BalatroSR.turnIDToText = function(a) --Convert ID to Rank for visualization purposes.
    if a <= 10 then
        return a
    else
        if a == 11 then
            return "Jack"
        elseif a == 12 then
            return "Queen"
        elseif a == 13 then
            return "King"
        elseif a == 14 then
            return "Ace"
        end
    end
end

BalatroSR.findLocation = function(card,area)
    local pos = nil
    for i,v in ipairs(area.cards) do
        if card == v then
            pos = i
        end
    end

    if not pos then print("Card wasn't found in the given area. [function: findLocation]") return end
    return pos
end