SMODS.Atlas{
    key = 'misc_stickers', --atlas key
    path = 'funjevil.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 90, --width of one card
    py = 96 -- height of one card
}

local CardStats = returnText("CardStats")

--To be reminded: Stickers don't show any text, at all. It's literally what they are only here for.

SMODS.Sticker{ -- Sticker to show debuffs on Playing Cards. (pc stands for playing cards :3)
    key = 'pc_debuff', --WHY DOSESNT THIS WORK
    atlas = 'misc_stickers',
    pos = { x = 99, y = 99}, --Invisible sticker.

    apply = function(self, card, val)
        card.ability[self.key] = val
    end,

    loc_vars = function(self, info_queue, card)
        --if not card.ability.extra.collectedDebuffs then card.ability.extra.collectedDebuffs = "" end
        --info_queue[#info_queue + 1] = G.P_CENTERS.e_negative THIS IS NOT IT IM GOING FUCKING CRAZY RAHHHHHHHHHHHHHHHHHHHHHHHH
		--return { vars = { card.ability.extra.collectedDebuffs } }


        --LAST PUSH, COME ON...
        local var = "None"
        local var2 = ""

        local def_reduction = (BalatroSR.readDebuffs(card))["def_reduction"]
        local dmg_taken = (BalatroSR.readDebuffs(card))["dmg_taken"]
        local dotMulti = (BalatroSR.readDebuffs(card))["dotMulti"]
        local elementStuffs = {            
            "Ice_res_pen",
            "Fire_res_pen",
            "Wind_res_pen",
            "Lightning_res_pen",
            "Quantum_res_pen",
            "Imaginary_res_pen",
            "Physical_res_pen",
            "all_type_res_pen",
        }
        local retElementStuffs = (BalatroSR.readDebuffs(card))["elements"]
        local debuff_text = (BalatroSR.readDebuffs(card))["text"]

        if def_reduction ~= 0 then
            var = "DEF Reduction: "..(def_reduction * 100).."%"
        end

        if dmg_taken ~= 0 then
            local addText = "DMG Taken: "..(dmg_taken * 100).."%"
            if var == "None" then
                var = addText
            else
                var = var.." | "..addText
            end
        end

        if dotMulti ~= 0 then
            local addText = "DOT Multi: "..(dotMulti * 100).."%"
            if var == "None" then
                var = addText
            else
                var = var.." | "..addText
            end
        end

        for i,v in ipairs(elementStuffs) do
            if retElementStuffs[v] then
                if v == "all_type_res_pen" then
                    local addText = "All-Type Res Reduction: "..(retElementStuffs[v] * 100).."%"
                    if var == "None" then
                        var = addText
                    else
                        var = var.." | "..addText
                    end
                else
                    local element = string.gsub(v,"_res_pen","")
                    local addText = element.." Res Reduction: "..(retElementStuffs[v] * 100).."%"
                    if var == "None" then
                        var = addText
                    else
                        var = var.." | "..addText
                    end
                end
            end
        end

        for i,v in ipairs(debuff_text) do
            local supposedText = v

            if var == "None" then
                var = supposedText
            else
                var = var.." | "..supposedText
            end
        end

        local _,numOfSections = var:gsub("|","")
        if numOfSections >= 2 then
            local pos = 1
            local diffSections = {}
            local divided = {}
            for i = 1, #var do
                local letter = var:sub(i,i)
                if letter == "|" then
                    diffSections[#diffSections+1] = {
                        ["min"] = pos,
                        ["max"] = i-2,
                    }
                    pos = i+2
                end
            end

            diffSections[#diffSections+1] = {
                ["min"] = pos,
                ["max"] = #var,
            }

            for _,v in ipairs(diffSections) do
                divided[#divided+1] = var:sub(v["min"],v["max"])
            end

            local p_var = nil
            local p_var2 = nil

            local p_var_sections = math.ceil((numOfSections + 1)/2)
            local p_var2_sections = (numOfSections + 1) - p_var_sections

            for i = 1,p_var_sections do
                if not p_var then
                    p_var = divided[i]
                else
                    p_var = p_var.." | "..divided[i]
                end
            end

            for i = 1,p_var2_sections do
                if not p_var2 then
                    p_var2 = divided[i + p_var_sections]
                else
                    p_var2 = p_var2.." | "..divided[i + p_var_sections]
                end
            end

            var = p_var
            var2 = p_var2
        end
        
		return { vars = {var or "None", var2} }
        --so like, how is your day
        --i want to kill myself
	end,

    default_compat = true,
    no_collection = true,
    order = 5,

    calculate = function(self, card, context) --YIPEEEEE
        --BalatroSR.debugTool()
        if context.end_of_round then
            SMODS.Stickers["hsr_pc_debuff"]:apply(card,false)
        end
    end
}

--i genuinely wish you die, bepis.