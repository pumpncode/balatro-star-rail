G.FUNCS.hsr_set_break_text = function(e) --Something.
    local card = e.config.ref_table
    e.config.text = "BREAK "..(card.ability.break_meter or 0).."%"
end

--[[
local game_updateref = Game.update
function Game.update(self, dt)
    --Horizontal Test
    G.hand.cards[1].ability.break_meter = 0
    G.test_hsr = UIBox {
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
                    config = {align = "cr", maxw = 2, padding = 0.1, r = 0.08, minw = 2, minh = 0, hover = true, shadow = true, colour = G.C.CLEAR},
                    nodes = {
                        create_progress_bar({label = "BREAK", label_scale = 0.5, w = 2, h = 0.3, text_scale = 0.2, ref_table = G.hand.cards[1].ability, ref_value = 'break_meter', min = 0, max = 100})
                    }
                },
    
            }
        },
        config = {
            align = "tr",
            offset = { x = -2.5, y = 0.3 },
            major = G.hand.cards[1],
            bond = 'Strong'
        }
    }

    --Vertical test
    G.hand.cards[1].ability.break_meter = 50
        G.test_hsr = UIBox {
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
                    config = {align = "cr", maxw = 2, padding = 0.1, r = 0.08, minw = 2, minh = 0, hover = true, shadow = true, colour = G.C.CLEAR},
                    nodes = {
                        create_progress_bar({label_position = "Top", bar_rotation = "Vertical", label = "BREAK", label_scale = 0.5, w = 0.3, h = 2, text_scale = 0.2, ref_table = G.hand.cards[1].ability, ref_value = 'break_meter', min = 0, max = 100})
                    }
                },
    
            }
        },
        config = {
            align = "tr",
            offset = { x = -2.5, y = 0.3 },
            major = G.deck,
            bond = 'Strong'
        }
    }
end
]]

--[[
G.hand.cards[1].ability.break_meter = 0
    G.hand.cards[1].hsr_break_progress_bar = UIBox {
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
                    config = { ref_table = card, align = "cr", maxw = 2, padding = 0.1, r = 0.08, minw = 2, minh = 0, hover = true, shadow = true, colour = G.C.CLEAR},
                    nodes = {
                        create_progress_bar({label = "BREAK", label_scale = 0.7, w = 2, h = 0.3, text_scale = 0.2, ref_table = G.hand.cards[1].ability, ref_value = 'break_meter', min = 0, max = 100})
                    }
                },
    
            }
        },
        config = {
            align = "tr",
            offset = { x = -2.5, y = 0.3 },
            major = G.hand.cards[1],
            bond = 'Strong'
        }
    }
    
G.hand.cards[1].hsr_break_ui_text = UIBox {
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
                config = { ref_table = card, align = "cr", maxw = 2, padding = 0.1, r = 0.08, minw = 2, minh = 0, hover = true, shadow = true, colour = G.C.CLEAR},
                nodes = {
                    { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                    {
                        n = G.UIT.C,
                        config = { align = "tm" },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cm", maxw = 1.25 },
                                nodes = {
                                    { n = G.UIT.T, config = {colour = G.C.UI.TEXT_LIGHT, scale = 1, shadow = true, text = 'BREAK '}},
                                    { n = G.UIT.T, config = {colour = G.C.UI.TEXT_LIGHT, scale = 1, shadow = true, ref_table = G.hand.cards[1].ability, ref_value = 'break_meter'}},
                                    { n = G.UIT.T, config = {colour = G.C.UI.TEXT_LIGHT, scale = 1, shadow = true, text = '%'}},
                                }
                            },
                        }
                    }
                }
            },

        }
    },
    config = {
        align = "tr",
        offset = { x = -2.5, y = 0.5 },
        major = G.hand.cards[1],
        bond = 'Strong'
    }
} 
]]

hsr_worlds = {
    "Belobog", --"Xianzhou"
}
hsr_worlds_boss_blinds = {
    ["Belobog"] = {"bl_hsr_Cocolia","bl_hsr_Svarog"},
    --["Xianzhou"] = {"bl_hsr_Cocolia","bl_hsr_Svarog"},
}
hsr_worlds_small_blinds = {
    ["Belobog"] = {"bl_hsr_Frostspawn", "bl_hsr_Flamespawn", "bl_hsr_Thunderspawn", "bl_hsr_Windspawn"}
}
hsr_worlds_big_blinds = {
    ["Belobog"] = {"bl_hsr_A_Direwolf"}
}
hsr_chance_to_small_blind = 6
hsr_chance_to_big_blind = 6

function set_hsr_world(world)
    G.GAME.hsr_world = world
    G.GAME.hsr_chosen_boss_blind = pseudorandom_element(hsr_worlds_boss_blinds[world],pseudoseed("hsr_choose_boss_blind_from_world"))
    G.E_MANAGER:add_event(Event({
        func = (function()
            local text = G.GAME.hsr_world
            attention_text({
                scale = 1.4, text = text, hold = 10, align = 'cm', offset = {x = 0,y = -3.4},major = G.play
            })
            text = localize("hsr_world_"..text)
            attention_text({
                scale = 0.7, text = text, hold = 10, align = 'cm', offset = {x = 0,y = -2},major = G.play
            })
            return true
         end)
    }))
end

function randomize_hsr_world()
    set_hsr_world(pseudorandom_element(hsr_worlds,pseudoseed("hsr_randomize_world")))
    randomize_hsr_blinds()
end

function randomize_hsr_blinds()
    local s_change, b_change = false, false

    if pseudorandom("hsr_choose_small_blind") < 1/hsr_chance_to_small_blind then
        local availableBlinds = hsr_worlds_small_blinds[G.GAME.hsr_world]
        if availableBlinds then
            availableBlinds = pseudorandom_element(availableBlinds,pseudoseed("hsr_choose_small_blind_specific"))
            if availableBlinds then G.GAME.round_resets.blind_choices.Small = availableBlinds s_change = true end
        end
    end

    if pseudorandom("hsr_choose_big_blind") < 1/hsr_chance_to_big_blind then
        local availableBlinds = hsr_worlds_big_blinds[G.GAME.hsr_world]
        if availableBlinds then
            availableBlinds = pseudorandom_element(availableBlinds,pseudoseed("hsr_choose_big_blind_specific"))
            if availableBlinds then G.GAME.round_resets.blind_choices.Big = availableBlinds b_change = true end
        end
    end

    return s_change, b_change
end

function set_hsr_blind(b_name, type) --Use this to manually set a HSR Blind in place of Small/Big Blinds.
    stop_use()
    G.CONTROLLER.locks.boss_reroll = true

    if type == "Small" then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                play_sound('other1')
                G.blind_select_opts.small:set_role({xy_bond = 'Weak'})
                G.blind_select_opts.small.alignment.offset.y = 20
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            func = (function()
                local par = G.blind_select_opts.small.parent
    
                G.GAME.round_resets.blind_choices.Small = b_name or "bl_hsr_Test"
        
                G.blind_select_opts.small:remove()
                G.blind_select_opts.small = UIBox{
                  T = {par.T.x, 0, 0, 0, },
                  definition =
                    {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                        UIBox_dyn_container({hsr_create_UIBox_blind_choice(type or 'Boss')},false,get_blind_main_colour(type or 'Boss'), mix_colours(G.C.BLACK, get_blind_main_colour(type or 'Boss'), 0.8))
                    }},
                  config = {align="bmi",
                            offset = {x=0,y=G.ROOM.T.y + 9},
                            major = par,
                            xy_bond = 'Weak'
                          }
                }
                par.config.object = G.blind_select_opts.small
                par.config.object:recalculate()
                G.blind_select_opts.small.parent = par
                G.blind_select_opts.small.alignment.offset.y = 0
                
                G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
                    G.CONTROLLER.locks.boss_reroll = nil
                    return true
                end
                }))  
                save_run()
            return true
            end)
        })) 
    elseif type == "Big" then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                play_sound('other1')
                G.blind_select_opts.big:set_role({xy_bond = 'Weak'})
                G.blind_select_opts.big.alignment.offset.y = 20
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            func = (function()
                local par = G.blind_select_opts.big.parent
    
                G.GAME.round_resets.blind_choices.Big = b_name or "bl_hsr_Test"
        
                G.blind_select_opts.big:remove()
                G.blind_select_opts.big = UIBox{
                  T = {par.T.x, 0, 0, 0, },
                  definition =
                    {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                        UIBox_dyn_container({hsr_create_UIBox_blind_choice(type or 'Boss')},false,get_blind_main_colour(type or 'Boss'), mix_colours(G.C.BLACK, get_blind_main_colour(type or 'Boss'), 0.8))
                    }},
                  config = {align="bmi",
                            offset = {x=0,y=G.ROOM.T.y + 9},
                            major = par,
                            xy_bond = 'Weak'
                          }
                }
                par.config.object = G.blind_select_opts.big
                par.config.object:recalculate()
                G.blind_select_opts.big.parent = par
                G.blind_select_opts.big.alignment.offset.y = 0
                
                G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
                    G.CONTROLLER.locks.boss_reroll = nil
                    return true
                end
                }))  
                save_run()
            return true
            end)
        })) 
    end
end

BalatroSR.reset_game_globals = function(run_start)
    if not G.GAME.hsr_world then
        randomize_hsr_world()
    end
end

G.FUNCS.hsr_act_boss_button = function(e)
    stop_use()
    G.CONTROLLER.locks.boss_reroll = true

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            G.blind_select_opts.boss:set_role({xy_bond = 'Weak'})
            G.blind_select_opts.boss.alignment.offset.y = 20
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.3,
        func = (function()
            local par = G.blind_select_opts.boss.parent
            if G.GAME.round_resets.hsr_stored_blind ~= G.GAME.hsr_chosen_boss_blind and G.GAME.round_resets.blind_choices.Boss ~= G.GAME.hsr_chosen_boss_blind then
                G.GAME.round_resets.hsr_stored_blind = G.GAME.round_resets.blind_choices.Boss
            end

            if G.GAME.round_resets.blind_choices.Boss ~= G.GAME.hsr_chosen_boss_blind then
                G.GAME.round_resets.blind_choices.Boss = G.GAME.hsr_chosen_boss_blind
            else
                G.GAME.round_resets.blind_choices.Boss = G.GAME.round_resets.hsr_stored_blind
            end
    
            G.blind_select_opts.boss:remove()
            G.blind_select_opts.boss = UIBox{
              T = {par.T.x, 0, 0, 0, },
              definition =
                {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                    UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))
                }},
              config = {align="bmi",
                        offset = {x=0,y=G.ROOM.T.y + 9},
                        major = par,
                        xy_bond = 'Weak'
                      }
            }
            par.config.object = G.blind_select_opts.boss
            par.config.object:recalculate()
            G.blind_select_opts.boss.parent = par
            G.blind_select_opts.boss.alignment.offset.y = 0
            
            G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
                G.CONTROLLER.locks.boss_reroll = nil
                return true
            end
            }))  
            save_run()
        return true
        end)
    }))
end

G.FUNCS.hsr_blind_choice_handler = function(e)
    if not e.config.ref_table.run_info and G.blind_select and G.blind_select.VT.y < 10 and e.config.id and G.blind_select_opts[string.lower(e.config.id)] then 
      if e.UIBox.role.xy_bond ~= 'Weak' then e.UIBox:set_role({xy_bond = 'Weak'}) end
      if (e.config.ref_table.deck ~= 'on' and e.config.id == G.GAME.blind_on_deck) or
         (e.config.ref_table.deck ~= 'off' and e.config.id ~= G.GAME.blind_on_deck) then

          local _blind_choice = G.blind_select_opts[string.lower(e.config.id)]
          local _top_button = e.UIBox:get_UIE_by_ID('select_blind_button')
          local _border = e.UIBox.UIRoot.children[1].children[1]
          local _tag = e.UIBox:get_UIE_by_ID('tag_'..e.config.id)
          local _tag_container = e.UIBox:get_UIE_by_ID('tag_container')
          if _tag_container and not G.SETTINGS.tutorial_complete and not G.SETTINGS.tutorial_progress.completed_parts['shop_1'] then _tag_container.states.visible = false
          elseif _tag_container then  _tag_container.states.visible = true end
          if e.config.id == G.GAME.blind_on_deck then
            e.config.ref_table.deck = 'on'
            e.config.draw_after = false
            e.config.colour = G.C.CLEAR
            _border.parent.config.outline = 2
            _border.parent.config.outline_colour = G.C.UI.TRANSPARENT_DARK
            _border.config.outline_colour = _border.config.outline and _border.config.outline_colour or get_blind_main_colour(e.config.id)
            _border.config.outline = 1.5
            _blind_choice.alignment.offset.y = -0.9
            if _tag and _tag_container then 
              _tag_container.children[2].config.draw_after = false
              _tag_container.children[2].config.colour = G.C.BLACK
              _tag.children[2].config.button = 'skip_blind'
              _tag.config.outline_colour = adjust_alpha(G.C.BLUE, 0.5)
              _tag.children[2].config.hover = true
              _tag.children[2].config.colour = G.C.RED
              _tag.children[2].children[1].config.colour = G.C.UI.TEXT_LIGHT
              local _sprite = _tag.config.ref_table
              _sprite.config.force_focus = nil
            end
            if _top_button then
              G.E_MANAGER:add_event(Event({func = function()
                G.CONTROLLER:snap_to({node = _top_button})
              return true end }))
              _top_button.config.button = 'select_blind'
              _top_button.config.colour = G.C.FILTER
              _top_button.config.hover = true
              _top_button.children[1].config.colour = G.C.WHITE
            end
          elseif e.config.id ~= G.GAME.blind_on_deck then 
            e.config.ref_table.deck = 'off'
            e.config.draw_after = true
            e.config.colour = adjust_alpha(G.GAME.round_resets.blind_states[e.config.id] == 'Skipped' and mix_colours(G.C.BLUE, G.C.L_BLACK, 0.1) or G.C.L_BLACK, 0.5)
            _border.parent.config.outline = nil
            _border.parent.config.outline_colour = nil
            _border.config.outline_colour = nil
            _border.config.outline = nil
            _blind_choice.alignment.offset.y = -0.2
            if _tag and _tag_container then 
              if G.GAME.round_resets.blind_states[e.config.id] == 'Skipped' or
                 G.GAME.round_resets.blind_states[e.config.id] == 'Defeated' then
                _tag_container.children[2]:set_role({xy_bond = 'Weak'})
                _tag_container.children[2]:align(0, 10)
                _tag_container.children[1]:set_role({xy_bond = 'Weak'})
                _tag_container.children[1]:align(0, 10)
              end
              if G.GAME.round_resets.blind_states[e.config.id] == 'Skipped' then
                _blind_choice.children.alert = UIBox{
                  definition = create_UIBox_card_alert({text_rot = -0.35, no_bg = true,text = localize('k_skipped_cap'), bump_amount = 1, scale = 0.9, maxw = 3.4}),
                  config = {
                    align="tmi",
                    offset = {x = 0, y = 2.2},
                    major = _blind_choice, parent = _blind_choice}
                }
              end
              _tag.children[2].config.button = nil
              _tag.config.outline_colour = G.C.UI.BACKGROUND_INACTIVE
              _tag.children[2].config.hover = false
              _tag.children[2].config.colour = G.C.UI.BACKGROUND_INACTIVE
              _tag.children[2].children[1].config.colour = G.C.UI.TEXT_INACTIVE
              local _sprite = _tag.config.ref_table
              _sprite.config.force_focus = true
            end
            if _top_button then 
              _top_button.config.colour = G.C.UI.BACKGROUND_INACTIVE
              _top_button.config.button = nil
              _top_button.config.hover = false
              _top_button.children[1].config.colour = G.C.UI.TEXT_INACTIVE
            end
          end
      end
    end
end

local get_typeref = Blind.get_type
function Blind.get_type(self)
    if self.config and self.config.blind and self.config.blind.config and self.config.blind.config.extra and self.config.blind.config.extra.hsr_blindType then
        return self.config.blind.config.extra.hsr_blindType
    end
    return get_typeref(self)
end

function hsr_create_UIBox_blind_choice(type, run_info)
    if not G.GAME.blind_on_deck then
      G.GAME.blind_on_deck = 'Small'
    end
    if not run_info then G.GAME.round_resets.blind_states[G.GAME.blind_on_deck] = 'Select' end
  
    local disabled = false
    type = type or 'Small'
  
    local blind_choice = {
        config = G.P_BLINDS[G.GAME.round_resets.blind_choices[type]],
    }
  
    blind_choice.animation = AnimatedSprite(0,0, 1.4, 1.4, G.ANIMATION_ATLAS[blind_choice.config.atlas] or G.ANIMATION_ATLAS['blind_chips'],  blind_choice.config.pos)
    blind_choice.animation:define_draw_steps({
      {shader = 'dissolve', shadow_height = 0.05},
      {shader = 'dissolve'}
    })

    local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)

    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
    local target = {type = 'raw_descriptions', key = blind_choice.config.key, set = 'Blind', vars = {}}

    local obj = blind_choice.config
    if obj.loc_vars and _G['type'](obj.loc_vars) == 'function' then
        local res = obj:loc_vars() or {}
        target.vars = res.vars or target.vars
        target.key = res.key or target.key
    end
    local loc_target = localize(target)
    local loc_name = localize{type = 'name_text', key = blind_choice.config.key, set = 'Blind'}
    local text_table = loc_target
    local blind_col = get_blind_main_colour(type)
    local blind_amt = get_blind_amount(G.GAME.round_resets.blind_ante)*blind_choice.config.mult*G.GAME.starting_params.ante_scaling
  
    local blind_state = G.GAME.round_resets.blind_states[type] --This should be replaced with type when I'm done.
    local _reward = true
    if G.GAME.modifiers.no_blind_reward and G.GAME.modifiers.no_blind_reward[type] then _reward = nil end
    if blind_state == 'Select' then blind_state = 'Current' end
    local blind_desc_nodes = {}
    for k, v in ipairs(text_table) do
        blind_desc_nodes[#blind_desc_nodes+1] = {n=G.UIT.R, config={align = "cm", maxw = 2.8}, nodes={
            {n=G.UIT.T, config={text = v or '-', scale = 0.32, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.WHITE, shadow = not disabled}}
        }}
    end
    local run_info_colour = run_info and (blind_state == 'Defeated' and G.C.GREY or blind_state == 'Skipped' and G.C.BLUE or blind_state == 'Upcoming' and G.C.ORANGE or blind_state == 'Current' and G.C.RED or G.C.GOLD)
    local t = 
    {n=G.UIT.R, config={id = type, align = "tm", func = 'hsr_blind_choice_handler', minh = not run_info and 10 or nil, ref_table = {deck = nil, run_info = run_info}, r = 0.1, padding = 0.05}, nodes={
      {n=G.UIT.R, config={align = "cm", colour = mix_colours(G.C.BLACK, G.C.L_BLACK, 0.5), r = 0.1, outline = 1, outline_colour = G.C.L_BLACK}, nodes={  
        {n=G.UIT.R, config={align = "cm", padding = 0.2}, nodes={
            not run_info and {n=G.UIT.R, config={id = 'select_blind_button', align = "cm", ref_table = blind_choice.config, colour = disabled and G.C.UI.BACKGROUND_INACTIVE or G.C.ORANGE, minh = 0.6, minw = 2.7, padding = 0.07, r = 0.1, shadow = true, hover = true, one_press = true, button = 'select_blind'}, nodes={ --This is the button.
              {n=G.UIT.T, config={ref_table = G.GAME.round_resets.loc_blind_states, ref_value = type, scale = 0.45, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.UI.TEXT_LIGHT, shadow = not disabled}}
            }} or 
            {n=G.UIT.R, config={id = 'select_blind_button', align = "cm", ref_table = blind_choice.config, colour = run_info_colour, minh = 0.6, minw = 2.7, padding = 0.07, r = 0.1, emboss = 0.08}, nodes={
              {n=G.UIT.T, config={text = localize(blind_state, 'blind_states'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }}
          }},
          {n=G.UIT.R, config={id = 'blind_name',align = "cm", padding = 0.07}, nodes={
            {n=G.UIT.R, config={align = "cm", r = 0.1, outline = 1, outline_colour = blind_col, colour = darken(blind_col, 0.3), minw = 2.9, emboss = 0.1, padding = 0.07, line_emboss = 1}, nodes={
              {n=G.UIT.O, config={object = DynaText({string = loc_name, colours = {disabled and G.C.UI.TEXT_INACTIVE or G.C.WHITE}, shadow = not disabled, float = not disabled, y_offset = -4, scale = 0.45, maxw =2.8})}},
            }},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
            {n=G.UIT.R, config={id = 'blind_desc', align = "cm", padding = 0.05}, nodes={
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.R, config={align = "cm", minh = 1.5}, nodes={
                  {n=G.UIT.O, config={object = blind_choice.animation}},
                }},
                text_table[1] and {n=G.UIT.R, config={align = "cm", minh = 0.7, padding = 0.05, minw = 2.9}, nodes = blind_desc_nodes} or nil,
              }},
              {n=G.UIT.R, config={align = "cm",r = 0.1, padding = 0.05, minw = 3.1, colour = G.C.BLACK, emboss = 0.05}, nodes={
                {n=G.UIT.R, config={align = "cm", maxw = 3}, nodes={
                  {n=G.UIT.T, config={text = localize('ph_blind_score_at_least'), scale = 0.3, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.WHITE, shadow = not disabled}}
                }},
                {n=G.UIT.R, config={align = "cm", minh = 0.6}, nodes={
                  {n=G.UIT.O, config={w=0.5,h=0.5, colour = G.C.BLUE, object = stake_sprite, hover = true, can_collide = false}},
                  {n=G.UIT.B, config={h=0.1,w=0.1}},
                  {n=G.UIT.T, config={text = number_format(blind_amt), scale = score_number_scale(0.9, blind_amt), colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.RED, shadow =  not disabled}}
                }},
                _reward and {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={text = localize('ph_blind_reward'), scale = 0.35, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.WHITE, shadow = not disabled}},
                  {n=G.UIT.T, config={text = string.rep(localize("$"), blind_choice.config.dollars)..'+', scale = 0.35, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.MONEY, shadow = not disabled}}
                }} or nil,
              }},
            }},
          }},
        }},  
      }}
    return t
end

local hookTo = end_round
function end_round() --Reroll world when Showdown Boss Blind is defeated.
    if G.GAME.round_resets.blind and G.GAME.round_resets.blind.config and G.GAME.round_resets.blind.config.extra and G.GAME.round_resets.blind.config.extra.hsr_blindType then
        G.GAME.round_resets.blind = (G.GAME.round_resets.blind.config.extra.hsr_blindType == "Small" and G.P_BLINDS.bl_small) or (G.GAME.round_resets.blind.config.extra.hsr_blindType == "Big" and G.P_BLINDS.bl_big)
    end
    local ret = hookTo()
    if G.GAME and G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind and G.GAME.blind.config.blind.boss and G.GAME.blind.config.blind.boss.showdown and G.GAME.blind:get_type() == "Boss" then
        G.GAME.hsr_reroll_world = true
    end

    return ret
end

local hookTo = reset_blinds
function reset_blinds()
    if G.GAME.round_resets.blind_states.Boss == 'Defeated' then
        local check_s, check_b = randomize_hsr_blinds()
        if not check_s then
            G.GAME.round_resets.blind_choices.Small = "bl_small"
        end
        if not check_b then
            G.GAME.round_resets.blind_choices.Big = "bl_big"
        end
    end

    local ret = hookTo()

    return ret
end

local hookTo = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(e) --Hooking to reroll_boss to ensure that it doesn't reroll HSR Boss Blind. (HOW DID I GET IT WORKING WITHIN 10 MINUTES)
    if G.GAME.round_resets.blind_choices.Boss == G.GAME.hsr_chosen_boss_blind then
        stop_use()
        G.CONTROLLER.locks.boss_reroll = true
    
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                play_sound('other1')
                G.blind_select_opts.boss:set_role({xy_bond = 'Weak'})
                G.blind_select_opts.boss.alignment.offset.y = 20
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            func = (function()
                local par = G.blind_select_opts.boss.parent
    
                G.GAME.round_resets.blind_choices.Boss = G.GAME.round_resets.hsr_stored_blind
        
                G.blind_select_opts.boss:remove()
                G.blind_select_opts.boss = UIBox{
                  T = {par.T.x, 0, 0, 0, },
                  definition =
                    {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                        UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))
                    }},
                  config = {align="bmi",
                            offset = {x=0,y=G.ROOM.T.y + 9},
                            major = par,
                            xy_bond = 'Weak'
                          }
                }
                par.config.object = G.blind_select_opts.boss
                par.config.object:recalculate()
                G.blind_select_opts.boss.parent = par
                G.blind_select_opts.boss.alignment.offset.y = 0
                
                G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
                    G.CONTROLLER.locks.boss_reroll = nil
                    return true
                end
                }))  
                save_run()
            return true
            end)
        })) 
    end

    local ret = hookTo(e)
    return ret
end

local hookTo = create_UIBox_blind_choice
function create_UIBox_blind_choice(type, run_info) --Add another button to Boss Blind's UI. Check for reroll_boss too.
    local ret = nil
    if (type == "Big" and G.GAME.round_resets.blind_choices.Big ~= "bl_big" and string.find(G.GAME.round_resets.blind_choices.Big, "_hsr_")) or (type == "Small" and G.GAME.round_resets.blind_choices.Small ~= "bl_small" and string.find(G.GAME.round_resets.blind_choices.Small, "_hsr_")) then
        ret = hsr_create_UIBox_blind_choice(type, run_info)
    else
        ret = hookTo(type, run_info)
    end

    if type == "Boss" then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            blocking = false,
            func = function()
                if G.blind_select_opts and G.blind_select_opts.boss then
                    local isShowdown = false
                    for i,v in pairs(G.P_BLINDS) do
                        if i == G.GAME.round_resets.blind_choices.Boss and v.boss.showdown then
                            isShowdown = true
                            break
                        end
                    end
                    if isShowdown then
                        G.hsr_change_boss_button = UIBox {
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
                                        config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = 0, hover = true, shadow = true, colour = G.C.RED, button = 'hsr_act_boss_button'},
                                        nodes = {
                                            { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                                            {
                                                n = G.UIT.C,
                                                config = { align = "tm" },
                                                nodes = {
                                                    {
                                                        n = G.UIT.R,
                                                        config = { align = "cm", maxw = 1.25 },
                                                        nodes = {
                                                            { n = G.UIT.T, config = { text = localize('hsr_boss_switch1'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                                        }
                                                    },
                                                    {
                                                        n = G.UIT.R,
                                                        config = { align = "cm" },
                                                        nodes = {
                                                            { n = G.UIT.T, config = { text = localize('hsr_boss_switch2'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    },
                    
                                }
                            },
                            config = {
                                align = "tr",
                                offset = { x = 0, y = 1 },
                                major = G.blind_select_opts.boss,
                                bond = 'Strong'
                            }
                        } 
                    end
                    return true
                end
            end
        }))   
    end
 
    return ret
end

local hookTo = create_UIBox_blind_select
function create_UIBox_blind_select() --Randomizing world after Showdown boss is beaten, the timing is when you enter the Blind selection screen.
    if G.GAME.hsr_reroll_world then
        G.GAME.hsr_reroll_world = false
        randomize_hsr_world()
    end

    local ret = hookTo()
 
    return ret
end