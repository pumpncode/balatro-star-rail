-------------------------------------------CONSUMABLES DOWN HERE----------------------------------------------------------------
local BalatroSR = SMODS.current_mod

--Gacha Results UI
BalatroSR.create_UIBox_gacha_results = function()
    local t = {
        n = G.UIT.ROOT,
        config = { align = 'cm', r = 0.1, colour = G.C.UI.TRANSPARENT_DARK},
        nodes = {
            {
                n = G.UIT.O,
                config = {
                    object = BalatroSR.hsr_gacha_results_area
                }
            }
        }
    }
    return t
end

G.FUNCS.hsr_open_gacha_results = function(e)
    BalatroSR.open_gacha_results(true, not G.hsr_gacha_results.states.visible)
end

G.FUNCS.hsr_show_gacha_results = function(e)
    if G.STATE == G.STATES.SHOP then
        e.states.visible = true
    else
        e.states.visible = false
        BalatroSR.open_gacha_results(false, false) --Close the UI if outside Shop.
    end
end

BalatroSR.add_to_gacha_results = function(card, args)
    if card.edition and card.edition.card_limit then
        BalatroSR.hsr_gacha_results_area.config.card_limit = BalatroSR.hsr_gacha_results_area.config.card_limit + card.edition.card_limit
    end
    BalatroSR.hsr_gacha_results_area:emplace(card)
end

BalatroSR.open_gacha_results = function(forced, open, delay_close)
    if open and not BalatroSR.hsr_gacha_results_open then
        BalatroSR.hsr_gacha_results_open = true
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                G.jokers.states.visible = false
                G.hsr_gacha_results.states.visible = true
                G.hsr_gacha_results.alignment.offset.y = 0
                return true
            end
        }))
    elseif not open and BalatroSR.hsr_gacha_results_open then
        BalatroSR.hsr_gacha_results_open = false
        BalatroSR.hsr_gacha_results_area:unhighlight_all()
        G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = "after",
            delay = 0.15 + (delay_close or 0),
            func = function()
                G.hsr_gacha_results.alignment.offset.y = -5
                G.jokers.states.visible = true
                G.E_MANAGER:add_event(Event({
                    blockable = false,
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hsr_gacha_results.states.visible = false
                        return true
                    end
                }))
                return true
            end
        }))
    end
end

function gacha_load_card(cardName)
    local newcard = SMODS.create_card({set = 'Joker', area = BalatroSR.hsr_gacha_results_area, skip_materialize = true, key = "j_hsr_"..cardName})
    BalatroSR.add_to_gacha_results(newcard)
end

function gacha_clear_results()
    for i,v in ipairs(G.hsr_gacha_results_area.cards) do
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                v.T.r = -0.2
                v:juice_up(0.3, 0.4)
                v.states.drag.is = true
                v.children.center.pinch.x = true
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                    func = function()
                            G.hsr_gacha_results_area:remove_card(v)
                            v:remove()
                            v = nil
                        return true; end})) 
                return true
            end
        })) 
    end
end

--Gacha Shop UI
BalatroSR.create_UIBox_gacha_shop = function()
    local t = {
        n = G.UIT.ROOT,
        config = { align = 'cm', r = 0.1, colour = G.C.UI.TRANSPARENT_DARK},
        nodes = {
            {
                n = G.UIT.O,
                config = {
                    object = BalatroSR.hsr_gacha_shop_area
                }
            }
        }
    }
    return t
end

BalatroSR.open_gacha_shop = function(forced, open, delay_close)
    if #G.hsr_gacha_shop_area.cards < 2 then
        BalatroSR.load_gacha_shop()
    end

    if open and not BalatroSR.hsr_gacha_shop_open then
        BalatroSR.hsr_gacha_shop_open = true
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                G.consumeables.states.visible = false
                G.hsr_gacha_shop.states.visible = true
                G.hsr_gacha_shop.alignment.offset.y = 0
                return true
            end
        }))
    elseif not open and BalatroSR.hsr_gacha_shop_open then
        BalatroSR.hsr_gacha_shop_open = false
        BalatroSR.hsr_gacha_shop_area:unhighlight_all()
        G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = "after",
            delay = 0.15 + (delay_close or 0),
            func = function()
                G.hsr_gacha_shop.alignment.offset.y = -5
                G.consumeables.states.visible = true
                G.E_MANAGER:add_event(Event({
                    blockable = false,
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hsr_gacha_shop.states.visible = false
                        return true
                    end
                }))
                return true
            end
        }))
    end
end

G.FUNCS.hsr_show_gacha_shop = function(e)
    if G.STATE == G.STATES.SHOP then
        e.states.visible = true
    else
        e.states.visible = false
        BalatroSR.open_gacha_shop(false, false) --Close the UI if outside Shop.
    end
end

G.FUNCS.hsr_open_gacha_shop = function(e)
    BalatroSR.open_gacha_shop(true, not G.hsr_gacha_shop.states.visible)
end

local toLoadInShop = {"c_hsr_starrailpass", "c_hsr_starrailspecialpass"} --Cards appearing in shop to buy.
BalatroSR.load_gacha_shop = function()
    for _,key in ipairs(toLoadInShop) do
        local newcard = SMODS.create_card({set = 'WarpTickets', area = BalatroSR.hsr_gacha_shop_area, skip_materialize = true, key = key})
        BalatroSR.hsr_gacha_shop_area:emplace(newcard)
    end
end

--Hooks taken straight from JoyousSpring, my beloved

local cardarea_remove_ref = CardArea.remove
function CardArea:remove()
    if self == G.shop_jokers or self == G.shop_booster then
        BalatroSR.open_gacha_shop(false, false)
    end
    cardarea_remove_ref(self)
end

local cardarea_can_highlight_ref = CardArea.can_highlight
function CardArea:can_highlight(card)
    return self.config.type == 'gacha_shop' or cardarea_can_highlight_ref
end


local cardarea_add_to_highlighted_ref = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent)
    if self.config.type == 'gacha_shop' then
        if #self.highlighted >= self.config.highlighted_limit then
            self:remove_from_highlighted(self.highlighted[1])
        end
        self.highlighted[#self.highlighted + 1] = card
        card:highlight(true)
        if not silent then play_sound('cardSlide1') end
    else
        cardarea_add_to_highlighted_ref(self, card, silent)
    end
end


local cardarea_draw_ref = CardArea.draw
function CardArea:draw()
    cardarea_draw_ref(self)

    if self.config.type == 'gacha_shop' then
        for k, v in ipairs(self.ARGS.draw_layers) do
            for i = 1, #self.cards do
                if self.cards[i] ~= G.CONTROLLER.focused.target then
                    if not self.cards[i].highlighted then
                        if G.CONTROLLER.dragging.target ~= self.cards[i] then self.cards[i]:draw(v) end
                    end
                end
            end
            for i = 1, #self.cards do
                if self.cards[i] ~= G.CONTROLLER.focused.target then
                    if self.cards[i].highlighted then
                        if G.CONTROLLER.dragging.target ~= self.cards[i] then self.cards[i]:draw(v) end
                    end
                end
            end
        end
    end
end


local cardarea_align_cards_ref = CardArea.align_cards
function CardArea:align_cards()
    if self.config.type == 'gacha_shop' then
        for k, card in ipairs(self.cards) do
            if not card.states.drag.is then 
                if #self.cards > 1 then
                    card.T.x = self.T.x + (self.T.w-self.card_w)*((k-1)/(#self.cards-1)) + 0.5*(self.card_w - card.T.w)
                else
                    card.T.x = self.T.x + self.T.w/2 - self.card_w/2 + 0.5*(self.card_w - card.T.w)
                end
                local highlight_height = G.HIGHLIGHT_H/2
                if not card.highlighted then highlight_height = 0 end
                card.T.y = self.T.y + self.T.h/2 - card.T.h/2 - highlight_height+ (G.SETTINGS.reduced_motion and 0 or 1)*0.03*math.sin(0.666*G.TIMERS.REAL+card.T.x)
                card.T.x = card.T.x + card.shadow_parrallax.x/30
            end
        end
        table.sort(self.cards, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
    end   
    cardarea_align_cards_ref(self)
end

--Load the new UI buttons.
local game_start_run_ref = Game.start_run
function Game:start_run(args)
    self.hsr_gacha_results_area = CardArea(
        0,
        0,
        self.CARD_W * 4.95,
        self.CARD_H * 0.95,
        {
            card_limit = 5,
            type = 'joker',
            highlight_limit = 1,
        }
    )
    BalatroSR.hsr_gacha_results_area = G.hsr_gacha_results_area

    self.hsr_gacha_shop_area = CardArea(
        0,
        0,
        self.CARD_W * 2.3,
        self.CARD_H * 0.95,
        {
            card_limit = 2,
            type = 'gacha_shop',
            highlight_limit = 1,
        }
    )
    BalatroSR.hsr_gacha_shop_area = G.hsr_gacha_shop_area

    game_start_run_ref(self, args)

    self.hsr_gacha_results = UIBox {
        definition = BalatroSR.create_UIBox_gacha_results(),
        config = { align = 'cmi', offset = { x = 0, y = -5 }, major = self.jokers, bond = 'Weak' }
    }
    self.hsr_gacha_results.states.visible = false
    G.GAME.hsr_show_gacha_results = G.GAME.hsr_show_gacha_results or false
    BalatroSR.hsr_gacha_results_open = false

    self.hsr_gacha_shop = UIBox {
        definition = BalatroSR.create_UIBox_gacha_shop(),
        config = { align = 'cmi', offset = { x = 0, y = -5 }, major = self.consumeables, bond = 'Weak' }
    }
    self.hsr_gacha_shop.states.visible = false
    G.GAME.hsr_show_gacha_shop = G.GAME.hsr_show_gacha_shop or false
    BalatroSR.hsr_gacha_shop_open = false

    self.extra_buttons = UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = {
                align = "cm",
                minw = 1,
                minh = 0.3,
                padding = 0.15,
                r = 0.1,
                colour = G.C.CLEAR
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        align = "tm",
                        minw = 2,
                        padding = 0.1,
                        r = 0.1,
                        hover = true,
                        colour = G.C.UI.BACKGROUND_DARK,
                        shadow = true,
                        button = "hsr_open_gacha_results",
                        func = "hsr_show_gacha_results"
                    },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "bcm", padding = 0 },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = localize('hsr_gacha_show'),
                                        scale = 0.35,
                                        colour = G.C.UI.TEXT_LIGHT
                                    }
                                }
                            }
                        },
                    }
                },

                {
                    n = G.UIT.C,
                    config = {
                        align = "tm",
                        minw = 2,
                        padding = 0.1,
                        r = 0.1,
                        hover = true,
                        colour = G.C.UI.BACKGROUND_DARK,
                        shadow = true,
                        button = "hsr_open_gacha_shop",
                        func = "hsr_show_gacha_shop"
                    },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "bcm", padding = 0 },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = localize('hsr_gacha_shop'),
                                        scale = 0.35,
                                        colour = G.C.UI.TEXT_LIGHT
                                    }
                                }
                            }
                        },
                    }
                },

            }
        },
        config = {
            align = "tr",
            offset = { x = -4, y = 0 },
            major = G.consumeables,
            bond = 'Weak'
        }
    }
end

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
    loc_txt = {
        name = 'Star Rail Pass', 
        text = { 
            'Roll #1# time(s) with different chances.',
            '{C:inactive,s:0.6}94.3% to get a 3 stars Standard Joker.{}',
            '{C:inactive,s:0.6}5.1% to get a 4 stars Standard Joker.{}',
            '{C:inactive,s:0.6}0.6% to get a 5 stars Standard Joker.{}',
            'Pity: #2#',
        }
    },
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
    loc_txt = {
        name = 'Star Rail Special Pass', 
        text = { 
            'Roll #1# time(s) with different chances.',
            '{C:inactive,s:0.6}94.3% to get a 3 stars Standard Joker.{}',
            '{C:inactive,s:0.6}5.1% to get a 4 stars Standard Joker.{}',
            '{C:inactive,s:0.6}0.3% to get a 5 stars Standard Joker.{}',
            '{C:inactive,s:0.6}0.3% to get a 5 stars Special Joker.{}',
            'Pity: #7#',
            '#2#',
            '{C:inactive,s:0.8}Featured 5-Star:{} {C:attention,s:0.8}#3#{}',
            '{C:inactive,s:0.8}Featured 4-Star:{} {C:attention,s:0.8}#4#{}',
            '{C:inactive,s:0.6}[Banner #5#/#6#]{}',
        }
    },
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
                    card.ability.extra.bannerName = v
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