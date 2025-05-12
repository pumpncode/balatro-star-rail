-------------------------------------------CONSUMABLES DOWN HERE----------------------------------------------------------------
local BalatroSR = SMODS.current_mod

--Actual "Consumables" down here.
SMODS.ConsumableType{
    key = 'WarpTickets', --consumable type key

    collection_rows = {4,5}, --amount of cards in one page
    primary_colour = G.C.PURPLE, --first color
    secondary_colour = G.C.DARK_EDITION, --second color
    loc_txt = {
        collection = 'Warp Tickets', --name displayed in collection
        name = 'Warp Tickets', --name displayed in badge
        undiscovered = {
            name = '???', --undiscovered name
            text = {'You are too poor... grind some more Stellar Jades, will you?'} --undiscovered text
        }
    },
    shop_rate = 0, --rate in shop out of 100
}

SMODS.UndiscoveredSprite{
    key = 'WarpTickets', --must be the same key as the consumabletype
    atlas = 'Jokers',
    pos = {x = 0, y = 0}
}

SMODS.Consumable{
    key = 'starrailpass', 
    set = 'WarpTickets', 
    atlas = 'Jokers', 
    pos = {x = 0, y = 0},
    cost = 10,
    unlocked = true,
    discovered = true,

    config = {
        extra = {
            roll = 5, 
            pity = 0,
            old_pity = 0,
        }
    },

    loc_vars = function(self,info_queue, center)
        return {vars = {center.ability.extra.roll, center.ability.extra.pity}} 
    end,

    update = function(self,card,dt)
        if G and G.GAME then
            card.ability.extra.pity = G.GAME.NormalPity or 0
        end
        if card.ability.extra.old_pity ~= card.ability.extra.pity and G.GAME.hoveredCard and G.GAME.hoveredCard == card then
            card:stop_hover()
            card:hover()
        end
        card.ability.extra.old_pity = card.ability.extra.pity
    end,

    can_use = function(self,card)
        if #G.jokers.cards < G.jokers.config.card_limit then
            return true
        else
            return false
        end
    end,

    calculate = function(self,card,context)
        if context.using_consumeable then
            return {
                using_consumeable = true,
	            consumeable = card,
            }
        end
    end,

    use = function(self,card,area,copier)
        hsr_gacha_roll(card)
    end,
}

SMODS.Consumable{
    key = 'starrailspecialpass', 
    set = 'WarpTickets', 
    atlas = 'Jokers', 
    pos = {x = 1, y = 0}, 
    cost = 15,
    unlocked = true,
    discovered = true,

    config = {
        extra = {
            roll = 5,
            bannerName = "?",
            featured5 = "?",
            featured4 = "?",
            old_banner = 1,
            selected_banner = 1,
            max_banner = #returnHsrBanners(),
            pity = 0,
            old_pity = 0,
        }
    },

    update = function(self,card,dt)
        if G and G.GAME and G.GAME.current_banner then
            card.ability.extra.selected_banner = G.GAME.current_banner
        end
        if G and G.GAME then
            card.ability.extra.pity = G.GAME.SpecialPity or 0
        end
        local selectedBanner = returnHsrBanners()[card.ability.extra.selected_banner]
        if selectedBanner then
            for name,v in pairs(selectedBanner) do
                if name == "Name" then
                    card.ability.extra.bannerName = localize(v)
                elseif name == "FourStars" then
                    card.ability.extra.featured4 = ""
                    for _,p in pairs(v) do
                        card.ability.extra.featured4 = card.ability.extra.featured4..p..", "
                    end
                    card.ability.extra.featured4 = string.sub(card.ability.extra.featured4, 1, #card.ability.extra.featured4 - 2)
                elseif name == "FiveStars" then
                    card.ability.extra.featured5 = v
                end
            end
            if (card.ability.extra.old_banner ~= card.ability.extra.selected_banner or card.ability.extra.old_pity ~= card.ability.extra.pity) and G.GAME.hoveredCard and G.GAME.hoveredCard == card then
                card:stop_hover()
                card:hover()
            end
            card.ability.extra.old_banner = card.ability.extra.selected_banner
            card.ability.extra.old_pity = card.ability.extra.pity
        else
            card.ability.extra.bannerName = "?"
            card.ability.extra.featured4 = "?,?,?"
            card.ability.extra.featured5 = "?"
        end
    end,

    loc_vars = function(self,info_queue, center)
        local returnVar = {
            center.ability.extra.roll,
            center.ability.extra.bannerName,
            center.ability.extra.featured5,
            center.ability.extra.featured4,
            center.ability.extra.selected_banner,
            center.ability.extra.max_banner,
            center.ability.extra.pity
        }
        return {vars = returnVar} 
    end,

    can_use = function(self,card)
       return true
    end,

    calculate = function(self,card,context)
        if context.using_consumeable then
            return {
                using_consumeable = true,
	            consumeable = card,
            }
        end
    end,

    use = function(self,card,area,copier)
        hsr_gacha_roll(card)
    end,
}