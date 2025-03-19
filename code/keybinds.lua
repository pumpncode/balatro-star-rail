local hoveredCard = nil

local hoverCardRef = Card.hover
function Card:hover()
    G.GAME.hoveredCard = self
    hoveredCard = G.GAME.hoveredCard
    local ret = hoverCardRef(self)
    return ret
end

local stop_hoverCardRef = Card.stop_hover
function Card:stop_hover()
    G.GAME.hoveredCard = G.GAME.hoveredCard ~= self and G.GAME.hoveredCard or nil
    hoveredCard = G.GAME.hoveredCard
    local ret = stop_hoverCardRef(self)
    return ret
end
--Above is to figure out what card is being hovered on.

function hsr_right_page_switch(card)
    if not card and BalatroSR.config.hover and hoveredCard then
        local card = hoveredCard
        if not card.ability.extra then return end
        if card.config.center.key == "c_hsr_starrailspecialpass" then
            if not G.GAME.current_banner then
                G.GAME.current_banner = 1
            end
            G.GAME.current_banner = G.GAME.current_banner + 1
            if (card.ability.extra["max_banner"] and G.GAME.current_banner >= card.ability.extra["max_banner"] + 1) then
                G.GAME.current_banner = 1
            end
            --[[G.jokers:unhighlight_all()
            G.jokers:add_to_highlighted(card)]]
        else
            if not card.ability.extra["page"] then card.ability.extra["page"] = 1 end
            card.ability.extra["page"] = card.ability.extra["page"] + 1
            if card.ability.extra["max_page"] then
                if card.ability.extra["page"] >= (card.ability.extra["max_page"] + 1) then
                    card.ability.extra["page"] = 1
                end
            elseif card.ability.extra["page"] >= 5 then
                card.ability.extra["page"] = 1
            end
            --[[G.jokers:unhighlight_all()
            G.jokers:add_to_highlighted(card)]]
            if hoveredCard and hoveredCard == card then
                card:stop_hover()
                card:hover()
            end 
        end
    else
        if not card.ability.extra then return end
        if card.config.center.key == "c_hsr_starrailspecialpass" then
            if not G.GAME.current_banner then
                G.GAME.current_banner = 1
            end
            G.GAME.current_banner = G.GAME.current_banner + 1
            if (card.ability.extra["max_banner"] and G.GAME.current_banner >= card.ability.extra["max_banner"] + 1) then
                G.GAME.current_banner = 1
            end
            --[[G.jokers:unhighlight_all()
            G.jokers:add_to_highlighted(card)]]
        else
            if not card.ability.extra["page"] then card.ability.extra["page"] = 1 end
            card.ability.extra["page"] = card.ability.extra["page"] + 1

            if card.ability.extra["max_page"] then
                if card.ability.extra["page"] >= (card.ability.extra["max_page"] + 1) then
                    card.ability.extra["page"] = 1
                end
            elseif card.ability.extra["page"] >= 5 then
                card.ability.extra["page"] = 1
            end

            --[[G.jokers:unhighlight_all() this was a bad choice
            G.jokers:add_to_highlighted(card)]]
            if hoveredCard and hoveredCard == card then
                card:stop_hover()
                card:hover()
            end 
        end
    end
end

function hsr_left_page_switch(card)
    if not card and BalatroSR.config.hover and hoveredCard then
        local card = hoveredCard
        if not card.ability.extra then return end
        if card.config.center.key == "c_hsr_starrailspecialpass" then
            if not G.GAME.current_banner then
                G.GAME.current_banner = 1
            end
            G.GAME.current_banner = G.GAME.current_banner - 1
            if G.GAME.current_banner <= 0 then
                G.GAME.current_banner = card.ability.extra["max_banner"]
            end
        else
            if not card.ability.extra["page"] then card.ability.extra["page"] = 1 end
            card.ability.extra["page"] = card.ability.extra["page"] - 1
            if card.ability.extra["page"] <= 0 then
                card.ability.extra["page"] = (card.ability.extra["max_page"] or 3)
            end
            if hoveredCard and hoveredCard == card then
                card:stop_hover()
                card:hover()
            end
        end
    else
        if not card.ability.extra then return end
        if card.config.center.key == "c_hsr_starrailspecialpass" then
            if not G.GAME.current_banner then
                G.GAME.current_banner = 1
            end
            G.GAME.current_banner = G.GAME.current_banner - 1
            if G.GAME.current_banner <= 0 then
                G.GAME.current_banner = card.ability.extra["max_banner"]
            end
        else
            if not card.ability.extra["page"] then card.ability.extra["page"] = 1 end
            card.ability.extra["page"] = card.ability.extra["page"] - 1
            if card.ability.extra["page"] <= 0 then
                card.ability.extra["page"] = (card.ability.extra["max_page"] or 3)
            end
            if hoveredCard and hoveredCard == card then
                card:stop_hover()
                card:hover()
            end
        end
    end
end

function toJoker(card)
    BalatroSR.hsr_to_joker(card)
end

function gacha(card)
    if G.GAME.dollars >= card.config.center.cost then
        ease_dollars(-card.config.center.cost)
        BalatroSR.hsr_gacha_roll(card)
    end
end

SMODS.Keybind{
    key_pressed = string.lower(BalatroSR.config.keybinds["hsr_turn_page_left"]), 
    event = 'pressed',
    action = function(self)
        if BalatroSR.config.enable and G and G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 then
            hsr_left_page_switch(G.jokers.highlighted[#G.jokers.highlighted])
        elseif BalatroSR.config.enable and G and G.consumeables and G.consumeables.highlighted and #G.consumeables.highlighted == 1 then
            hsr_left_page_switch(G.consumeables.highlighted[#G.consumeables.highlighted])
        elseif BalatroSR.config.enable and G and G.jokers and BalatroSR.config.hover and hoveredCard and (string.find(hoveredCard.config.center.key,"j_hsr_") or (hoveredCard.config.center.key == "c_hsr_starrailspecialpass" or hoveredCard.config.center.key == "c_hsr_starrailpass"))then
            hsr_left_page_switch()
        end
    end
}

SMODS.Keybind{
    key_pressed = string.lower(BalatroSR.config.keybinds["hsr_turn_page_right"]), 
    event = 'pressed',
    action = function(self)
        if BalatroSR.config.enable and G and G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 then
            hsr_right_page_switch(G.jokers.highlighted[#G.jokers.highlighted])
        elseif BalatroSR.config.enable and G and G.consumeables and G.consumeables.highlighted and #G.consumeables.highlighted == 1 then
            hsr_right_page_switch(G.consumeables.highlighted[#G.consumeables.highlighted])
        elseif BalatroSR.config.enable and G and G.jokers and BalatroSR.config.hover and hoveredCard and (string.find(hoveredCard.config.center.key,"j_hsr_") or (hoveredCard.config.center.key == "c_hsr_starrailspecialpass" or hoveredCard.config.center.key == "c_hsr_starrailpass")) then
            hsr_right_page_switch()
        end
    end
}

SMODS.Keybind{
    key_pressed = string.lower(BalatroSR.config.keybinds["hsr_interact_keybind"]), 
    event = 'pressed',
    action = function(self)
        if BalatroSR.config.enable and G and G.hsr_gacha_results_area and G.hsr_gacha_results_area.highlighted and #G.hsr_gacha_results_area.highlighted == 1 then
            toJoker(G.hsr_gacha_results_area.highlighted[#G.hsr_gacha_results_area.highlighted])
        elseif BalatroSR.config.enable and G and G.hsr_gacha_shop_area and G.hsr_gacha_shop_area.highlighted and #G.hsr_gacha_shop_area.highlighted == 1 then
            gacha(G.hsr_gacha_shop_area.highlighted[#G.hsr_gacha_shop_area.highlighted])
        elseif BalatroSR.config.enable and G and G.hsr_gacha_results_area and BalatroSR.config.hover and hoveredCard then
            if string.find(hoveredCard.config.center.key,"j_hsr_") then
                toJoker(hoveredCard)
            elseif hoveredCard.config.center.key == "c_hsr_starrailspecialpass" or hoveredCard.config.center.key == "c_hsr_starrailpass" then
                gacha(hoveredCard)
            end
        end
    end
}