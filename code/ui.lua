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

    --[[
    local setPadding = 0.02
    self.hsr_skill_tree = UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = {
                align = "cm",
                padding = setPadding,
                colour = G.C.BLACK,
                r = 0.1, minw = 8, minh = 6,
                outline = 1,
                outline_colour = G.C.WHITE
            },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {align = "cr", padding = 0.05},
                    nodes = {
                        {n = G.UIT.R, config = {align = "cm", padding = setPadding, }, nodes = {
                            
                        }},
                    }
                },
            }
        },
        config = { align = 'cm', offset = { x = 0, y = 0 }, major = G, bond = 'Weak' }
    }
    ]]

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
                align = "cardarea_add_to_highlighted_ref",
                offset = { x = 0, y = -0.75 },
                major = G.jokers,
                bond = 'Weak'
            }
        }
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
            align = "cardarea_add_to_highlighted_ref",
            offset = { x = 0, y = -0.75 },
            major = G.jokers,
            bond = 'Weak'
        }
    }
end