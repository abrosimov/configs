-- awesome 3 configuration file

-- Include awesome library, with lots of useful function!
require("awful")
require("tabulous")
require("beautiful")
require("wicked")

theme_path = os.getenv("HOME") .. "/.config/awesome/themes/fally_theme"
os.setlocale(os.getenv("LANG"))

beautiful.init(theme_path)
awful.beautiful.register(beautiful)

file_manager = "rox"
jab_cl       = "psi"
p_editor     = "gimp"
terminal     = "urxvt"
term_exec    = terminal .. " -e "
icq_cl       = "qutIM"
browser      = "firefox"
torr_cl      = "ktorrent"
t_editor     = term_exec .. "vim"
ncmpc        = term_exec .. "ncmpcpp"

music_play = "mpc toggle"
music_stop = "mpc stop"
music_next = "mpc next"
music_prev = "mpc prev"

sound_down   = "amixer -q set Master 5-"
sound_up     = "amixer -q set Master 5+"
sound_mute   = "amixer -q set Master toggle"

modkey = "Mod4" -- modkey - клавиша WIN

-- {{{ Константы, определяющие базовые сочетания клавиш
    kb_m   = { modkey }                  -- WIN
    kb_a   = { "Alt" }                   -- Alt
    kb_ms  = { modkey, "Shift" }         -- WIN+Shift
    kb_mc  = { modkey, "Ctrl" }          -- WIN+Ctrl
    kb_ma  = { modkey, "Alt" }           -- WIN+Alt
    kb_ca  = { "Ctrl", "Alt" }           -- Ctrl+Alt
    kb_sa  = { "Shift", "Alt" }          -- Shift+Alt
    kb_msc = { modkey, "Shift", "Ctrl" } -- WIN+Shift+Ctrl
    kb_msa = { modkey, "Shift", "Alt" }  -- WIN+Shift+Alt
    kb_mca = { modkey, "Ctrl", "Alt" }   -- WIN+Ctrl+Alt
-- }}}

-- Режимы которые мы используются.
layouts = { "tile", "max" }

-- "Плавающие" приложения
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["gimp"] = true,
    ["QutIM"] = true,
    ["psi"] = true,
    -- by instance
    ["Download"] = true,
    ["qutIM"] = true
}

-- Распределяем приложения по тэгам
apptags =
{
    ["Firefox"] = { screen = 1, tag = 1 },
    ["QutIM"] = { screen = 1, tag = 2 },
    ["qutIM"] = { screen = 1, tag = 2 },
    ["psi"] = { screen = 1, tag = 2 },
    ["gimp"] = { screen = 1, tag = 7 }
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}


-- {{{ Tags
-- Define tags table.
tag_names = {"web", "im", "video", "sys", "dev", "work", "etc", "music", "torrent"}
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = {}
    -- Create 9 tags per screen.
    for tagnumber = 1, 9 do
        tags[s][tagnumber] = tag({ name = tag_names[tagnumber], layout = layouts[1] })
        -- Add tags to screen one by one
        tags[s][tagnumber].screen = s
    end
    -- I'm sure you want to see at least one tag.
    tags[s][1].selected = true
end
-- }}}

-- {{{ Statusbar
-- Create a taglist widget
mytaglist = widget({ type = "taglist", name = "mytaglist" })
mytaglist:mouse_add(mouse({}, 1, function (object, tag) awful.tag.viewonly(tag) end))
mytaglist:mouse_add(mouse({ modkey }, 1, function (object, tag) awful.client.movetotag(tag) end))
mytaglist:mouse_add(mouse({}, 3, function (object, tag) tag.selected = not tag.selected end))
mytaglist:mouse_add(mouse({ modkey }, 3, function (object, tag) awful.client.toggletag(tag) end))
mytaglist:mouse_add(mouse({ }, 4, awful.tag.viewnext))
mytaglist:mouse_add(mouse({ }, 5, awful.tag.viewprev))
mytaglist.label = awful.widget.taglist.label.all

-- Create a tasklist widget
mytasklist = widget({ type = "tasklist", name = "mytasklist" })
mytasklist:mouse_add(mouse({ }, 1, function (object, c) client.focus = c; c:raise() end))
mytasklist:mouse_add(mouse({ }, 4, function () awful.client.focusbyidx(1) end))
mytasklist:mouse_add(mouse({ }, 5, function () awful.client.focusbyidx(-1) end))
mytasklist.label = awful.widget.tasklist.label.currenttags

-- Create prompt box for running commands
mypromptbox = widget({ type = "textbox", name = "mypromptbox", align = "left" })

-- Create an iconbox widget
myiconbox = widget({ type = "textbox", name = "myiconbox", align = "left" })
myiconbox.text = "<bg image=\"/usr/local/share/awesome/icons/awesome16.png\" resize=\"true\"/>"

-- Create a systray
mysystray = widget({ type = "systray", name = "mysystray", align = "right" })

-- Create an iconbox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
mylayoutbox = {}
for s = 1, screen.count() do
    mylayoutbox[s] = widget({ type = "textbox", name = "mylayoutbox", align = "right" })
    mylayoutbox[s]:mouse_add(mouse({ }, 1, function () awful.layout.inc(layouts, 1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 3, function () awful.layout.inc(layouts, -1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 4, function () awful.layout.inc(layouts, 1) end))
    mylayoutbox[s]:mouse_add(mouse({ }, 5, function () awful.layout.inc(layouts, -1) end))
    mylayoutbox[s].text = "<bg image=\"/usr/local/share/awesome/icons/layouts/tilew.png\" resize=\"true\"/>"
end

-- {{{ Icon widgets
mpd_icon = widget({ type = "textbox", name = "mpd_icon", align = "left" })
mpd_icon.text = "<bg image=\"" .. os.getenv("HOME") .. "/.config/awesome/icons/mpd.png\" resize=\"false\"/>"

mem_icon = widget({ type = "textbox", name = "mem_icon", align = "left" })
mem_icon.text = "<bg image=\"" .. os.getenv("HOME") .. "/.config/awesome/icons/mem.png\" resize=\"false\"/>"

mem_bar_icon = widget({ type = "textbox", name = "mem_bar_icon", align = "right" })
mem_bar_icon.text = "<bg image=\"" .. os.getenv("HOME") .. "/.config/awesome/icons/mem.png\" resize=\"false\"/>"

cpu_icon = widget({ type = "textbox", name = "cpu_icon", align = "left" })
cpu_icon.text = "<bg image=\"" .. os.getenv("HOME") .. "/.config/awesome/icons/cpu.png\" resize=\"true\"/>"

cpu_bar_icon = widget({ type = "textbox", name = "cpu_bar_icon", align = "right" })
cpu_bar_icon.text = "<bg image=\"" .. os.getenv("HOME") .. "/.config/awesome/icons/cpu.png\" resize=\"true\"/>"

download_icon = widget({ type = "textbox", name = "download_icon", align = "left" })
download_icon.text = "<bg image=\"" .. os.getenv("HOME") .. "/.config/awesome/icons/down.png\" resize=\"false\"/>"

upload_icon = widget({ type = "textbox", name = "download_icon", align = "left" })
upload_icon.text = "<bg image=\"" .. os.getenv("HOME") .. "/.config/awesome/icons/up.png\" resize=\"false\"/>"

mpd_icon_src = "<bg image=\"" .. os.getenv("HOME") .. "/.config/awesome/icons/mpd.png\" resize=\"false\" />"
ac_icon_src  = "<bg image=\"" .. os.getenv("HOME") .. "/.config/awesome/icons/power-ac.png\" resize=\"false\" />"
bat_icon_src = "<bg image=\"" .. os.getenv("HOME") .. "/.config/awesome/icons/power-bat.png\" resize=\"false\" />"
-- }}}

-- {{{ MPD Widget
mpdwidget = widget({
    type = 'textbox',
    name = 'mpdwidget'
})

wicked.register(mpdwidget, wicked.widgets.mpd, 
    function (widget, args)
        if args[1]:find("volume:") == nil then
            mpd_icon.text = mpd_icon_src
	    return args[1] .. '|'
        else
            mpd_icon.text = ''
            return ''
        end
end)
-- }}}

-- {{{ Date widget
datewidget = widget({
    type = 'textbox',
    name = 'datewidget',
    align = 'right'
})

wicked.register(datewidget, wicked.widgets.date, ' <span color="white">DATE:</span> %H:%M [%d.%m.%y]')
-- }}}

-- {{{ Memory stats widget
memwidget = widget({
    type = 'textbox',
    name = 'memwidget'
})

wicked.register(memwidget, wicked.widgets.mem, '$1% ($2Mb/$3Mb)|', nil, nil, {2, 4, 4})
-- }}}

-- {{{ Volume widget
--
-- }}}

-- {{{ Memory graph Widget
memgraphwidget = widget({
    type = 'graph',
    name = 'memgraphwidget',
    align = 'right'
})

memgraphwidget.height = 0.85
memgraphwidget.width = 45
memgraphwidget.bg = '#333333'
memgraphwidget.border_color = '#0a0a0a'
memgraphwidget.grow = 'left'

memgraphwidget:plot_properties_set('mem', {
    fg = '#AEC6D8',
    fg_center = '#285577',
    fg_end = '#285577',
    vertical_gradient = false
})

wicked.register(memgraphwidget, wicked.widgets.mem, '$1', 1, 'mem')
-- }}}

-- {{{ CPU stats widget
cpuwidget = widget({
    type = 'textbox',
    name = 'cpuwidget'
})

wicked.register(cpuwidget, wicked.widgets.cpu, '$1%|')
-- }}}

-- {{{{ CPU graph widget
cpugraphwidget = widget({
    type = 'graph',
    name = 'cpugraphwidget',
    align = 'right'
})

cpugraphwidget.height = 0.85
cpugraphwidget.width = 45
cpugraphwidget.bg = '#333333'
cpugraphwidget.border_color = '#0a0a0a'
cpugraphwidget.grow = 'left'
cpugraphwidget:plot_properties_set('cpu', {
    fg = '#AEC6D8',
    fg_center = '#285577',
    fg_end = '#285577',
    vertical_gradient = false
})

wicked.register(cpugraphwidget, wicked.widgets.cpu, '$1', 1, 'cpu')
-- }}}

-- {{{{{{ Network windgets

-- {{{ Download widget
download_widget = widget({
    type = 'textbox',
    name = 'netwidget'
})

wicked.register(download_widget, wicked.widgets.net, '${eth0 down} [${eth0 rx}]|', nil, nil, 3)
-- }}}

-- {{{ Upload widget
upload_widget = widget({
    type = 'textbox',
    name = 'netwidget'
})

wicked.register(upload_widget, wicked.widgets.net, '${eth0 up} [${eth0 tx}]', nil, nil, 3)
-- }}}

-- }}}}}}

-- {{{ Battery stats widget
batwidget = widget({
    type = 'textbox',
    name = 'batwidget'
})
--
function battery()
    local capacity = io.open("/proc/acpi/battery/BAT0/info"):read("*a"):match("last full capacity:%s+(%d+)")
    local current = io.open("/proc/acpi/battery/BAT0/state"):read("*a"):match("remaining capacity:%s+(%d+)")

    battery = ((current * 100) / capacity)

    remain = math.floor(battery * 10 ^ 2) / 10 ^ 2
    if remain == 100 then
        batwidget.text = ac_icon_src .. "  <span color=\"green\">" .. remain .. "%</span>|"
    elseif remain < 25 then
        batwidget.text = bat_icon_src .. "   <span color=\"red\">" ..remain.. "%</span>|"
    else
        batwidget.text = bat_icon_src .. "  <span color=\"yellow\">" ..remain.. "%</span>|"
    end
end
-- }}}

-- {{{ Create top-bar
mystatusbar = {}
for s = 1, screen.count() do
    mystatusbar[s] = statusbar({ position = "top", name = "mystatusbar" .. s,
                                 fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the statusbar - order matters
    mystatusbar[s]:widgets({
        --mytaglist,
        mytasklist,
        myiconbox,
        mypromptbox,
        mylayoutbox[s],
        s == 1 and mysystray or nil
    })
    mystatusbar[s].screen = s
end
-- }}}

-- {{{ Create bottom-bar
btsb = {}
for s = 1, screen.count() do
    btsb[s] = statusbar({ position = "bottom", name = "btsb" .. s,
                                 fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the statusbar - order matters
    btsb[s]:widgets({
	--volume_widget, 
        mpd_icon,
        mpdwidget,
        mem_icon,
	memwidget,
        cpu_icon,
	cpuwidget,
        cpu_bar_icon, 
	cpugraphwidget,
        mem_bar_icon, 
        memgraphwidget,
	datewidget,
        batwidget,
        download_icon,
	download_widget,
        upload_icon,
        upload_widget
    })
    btsb[s].screen = s
end
-- }}}

-- {{{ Mouse bindings
awesome.mouse_add(mouse({ }, 3, function () awful.spawn(terminal) end))
awesome.mouse_add(mouse({ }, 4, awful.tag.viewnext))
awesome.mouse_add(mouse({ }, 5, awful.tag.viewprev))
-- }}}

-- {{{ Key bindings
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
    keybinding(kb_m, i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           awful.tag.viewonly(tags[screen][i])
                       end
                   end):add()
    keybinding(kb_mc, i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           tags[screen][i].selected = not tags[screen][i].selected
                       end
                   end):add()
    keybinding(kb_ms, i,
                   function ()
                       local sel = client.focus
                       if sel then
                           if tags[sel.screen][i] then
                               awful.client.movetotag(tags[sel.screen][i])
                           end
                       end
                   end):add()
    keybinding(kb_msc, i,
                   function ()
                       local sel = client.focus
                       if sel then
                           if tags[sel.screen][i] then
                               awful.client.toggletag(tags[sel.screen][i])
                           end
                       end
                   end):add()
end

keybinding(kb_m, "Left", awful.tag.viewprev):add()
keybinding(kb_m, "Right", awful.tag.viewnext):add()
keybinding(kb_m, "Escape", awful.tag.history.restore):add()

-- Standard program
keybinding(kb_m, "Return", function () awful.spawn(terminal) end):add()
-- Настройки "горячих" клавиш для запуска программ.
keybinding(kb_ms, "b", function () awful.spawn(browser) end):add() -- Браузер
keybinding(kb_ms, "t", function () awful.spawn(t_editor) end):add() -- Текстовый редактор
keybinding(kb_ms, "i", function () awful.spawn(icq_cl) end):add() -- ICQ-клиент
keybinding(kb_ms, "p", function () awful.spawn(jab_cl) end):add() -- Jabber-клиент
keybinding(kb_ms, "g", function () awful.spawn(p_editor) end):add() -- Графический редактор 
keybinding(kb_ms, "f", function () awful.spawn(file_manager) end):add() -- Файловый менеджер
keybinding(kb_ms, "t", function () awful.spawn(torr_cl) end):add() -- Торрент-клиент
keybinding(kb_ms, "n", function () awful.spawn(ncmpc) end):add() -- Аудио-проигрыватель
-- "Горячие" клавиши настройки громкости звука.
keybinding(kb_m, "m", function () awful.spawn(sound_mute) end):add() -- Заглушить звук
keybinding(kb_m, "-", function () awful.spawn(sound_down) end):add() -- Понизить громкость на -5
keybinding(kb_m, "=", function () awful.spawn(sound_up) end):add() -- повысить громкость на +5
-- Настройка переключения треков с помошью mpc
keybinding(kb_m, "z", function () awful.spawn(music_prev) end):add() -- Предыдущая дорожка.
keybinding(kb_m, "v", function () awful.spawn(music_next) end):add() -- Следующая дорожка.
keybinding(kb_m, "x", function () awful.spawn(music_stop) end):add() -- Остановить воспроизведение дорожки.
keybinding(kb_m, "c", function () awful.spawn(music_play) end):add() -- Играть/приостановить проигрывание дорожки.

keybinding(kb_mc, "r", awesome.restart):add() -- перезапустить awesome
keybinding(kb_ms, "q", awesome.quit):add() -- выйти из awesome

-- Манипуляции над пользовательскими тегами
keybinding(kb_m, "m", awful.client.maximize):add() -- развернуть приложение на весь экран
keybinding(kb_ms, "c", function () client.focus:kill() end):add() -- "убить" текущее приложение
keybinding(kb_m, "j", function () awful.client.focusbyidx(1); client.focus:raise() end):add() -- перейти к приложению находящемуся в следующем теге
keybinding(kb_m, "k", function () awful.client.focusbyidx(-1);  client.focus:raise() end):add() -- Перейти к приложению находящемуся в предыдущем теге
keybinding(kb_ms, "j", function () awful.client.swap(1) end):add() -- Поменять местами приложения в текущем и следующем тегах
keybinding(kb_ms, "k", function () awful.client.swap(-1) end):add() -- Поменять приложения в текущем и предыдущем тегах
keybinding(kb_mc, "j", function () awful.screen.focus(1) end):add() -- Переместить фокус на следующее приложение
keybinding(kb_mc, "k", function () awful.screen.focus(-1) end):add() -- переместить фокус на предыдущее приложение
keybinding(kb_mc, "space", awful.client.togglefloating):add() -- Снимаем tiling-style с приложения в текущем теге
keybinding(kb_mc, "Return", function () client.focus:swap(awful.client.master()) end):add() -- Переместить фокус на текущее приложение (отобразить в самом "большом" теге)
keybinding(kb_m, "o", awful.client.movetoscreen):add()
keybinding(kb_m, "Tab", awful.client.focus.history.previous):add() -- перейти к предыдущемуу в истории тегу
keybinding(kb_m, "u", awful.client.urgent.jumpto):add()
keybinding(kb_ms, "r", function () client.focus:redraw() end):add() -- перерисовать приложение в текущем теге

-- Layout manipulation
keybinding(kb_m, "l", function () awful.tag.incmwfact(0.05) end):add() -- увеличить размер текущего тега
keybinding(kb_m, "h", function () awful.tag.incmwfact(-0.05) end):add() -- уменьшить размер текущего тега
keybinding(kb_ms, "h", function () awful.tag.incnmaster(1) end):add() -- перевернуть теги по часовой стрелке
keybinding(kb_ms, "l", function () awful.tag.incnmaster(-1) end):add() -- перевернуть теги против часовой стрелки
keybinding(kb_mc, "h", function () awful.tag.incncol(1) end):add()
keybinding(kb_mc, "l", function () awful.tag.incncol(-1) end):add()
keybinding(kb_m, "space", function () awful.layout.inc(layouts, 1) end):add() -- перейти к следующему виду отображения
keybinding(kb_ms, "space", function () awful.layout.inc(layouts, -1) end):add() -- перейти к предыдущему виду отображения

-- Поля ввода =) --
keybinding(kb_m, "F1", function () -- поле для запуска команды
                                 awful.prompt.run({ prompt = "Run: " }, mypromptbox, awful.spawn, awful.completion.bash,
os.getenv("HOME") .. "/.cache/awesome/history") end):add()

keybinding(kb_m, "F4", function () -- поля для запуска lua-кода
                                 awful.prompt.run({ prompt = "Run Lua code: " }, mypromptbox, awful.eval, awful.prompt.bash,
os.getenv("HOME") .. "/.cache/awesome/history_eval") end):add()

-- По Ctrl+WIN+i отобразить на верхней панели класс и инсанс приложения в
-- текущем теге
keybinding(kb_mc, "i", function ()
                                        if mypromptbox.text then
                                            mypromptbox.text = nil
                                        else
                                            mypromptbox.text = nil
                                            if client.focus.class then
                                                mypromptbox.text = "Class: " .. client.focus.class .. " "
                                            end
                                            if client.focus.instance then
                                                mypromptbox.text = mypromptbox.text .. "Instance: ".. client.focus.instance .. " "
                                            end
                                            if client.focus.role then
                                                mypromptbox.text = mypromptbox.text .. "Role: ".. client.focus.role
                                            end
                                        end
                                    end):add()

--- Tabulous, tab manipulation
keybinding(kb_mc, "y", function ()
    local tabbedview = tabulous.tabindex_get()
    local nextclient = awful.client.next(1)

    if not tabbedview then
        tabbedview = tabulous.tabindex_get(nextclient)

        if not tabbedview then
            tabbedview = tabulous.tab_create()
            tabulous.tab(tabbedview, nextclient)
        else
            tabulous.tab(tabbedview, client.focus)
        end
    else
        tabulous.tab(tabbedview, nextclient)
    end
end):add()

keybinding(kb_ms, "y", tabulous.untab):add()

keybinding(kb_m, "y", function ()
   local tabbedview = tabulous.tabindex_get()

   if tabbedview then
       local n = tabulous.next(tabbedview)
       tabulous.display(tabbedview, n)
   end
end):add()

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
keybinding(kb_m, "t", awful.client.togglemarked):add()
keybinding(kb_ms, "t", function ()
    local tabbedview = tabulous.tabindex_get()
    local clients = awful.client.getmarked()

    if not tabbedview then
        tabbedview = tabulous.tab_create(clients[1])
        table.remove(clients, 1)
    end

    for k,c in pairs(clients) do
        tabulous.tab(tabbedview, c)
    end

end):add()

for i = 1, keynumber do
    keybinding(kb_ms, "F" .. i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           for k, c in pairs(awful.client.getmarked()) do
                               awful.client.movetotag(tags[screen][i], c)
                           end
                       end
                   end):add()
end
-- }}}

-- {{{ Hooks
-- Hook function to execute when focusing a client.
function hook_focus(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end

-- Hook function to execute when unfocusing a client.
function hook_unfocus(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end

-- Hook function to execute when marking a client
function hook_marked(c)
    c.border_color = beautiful.border_marked
end

-- Hook function to execute when unmarking a client
function hook_unmarked(c)
    c.border_color = beautiful.border_focus
end

-- Hook function to execute when the mouse is over a client.
function hook_mouseover(c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= "magnifier" then
        client.focus = c
    end
end

-- Hook function to execute when a new client appears.
function hook_manage(c)
    -- Set floating placement to be smart!
    c.floating_placement = "smart"
    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:mouse_add(mouse({ }, 1, function (c) client.focus = c; c:raise() end))
    c:mouse_add(mouse({ modkey }, 1, function (c) c:mouse_move() end))
    c:mouse_add(mouse({ modkey }, 3, function (c) c:mouse_resize() end))
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal
    client.focus = c

    -- Check if the application should be floating.
    local cls = c.class
    local inst = c.instance
    if floatapps[cls] then
        c.floating = floatapps[cls]
    elseif floatapps[inst] then
        c.floating = floatapps[inst]
    end
    
    -- Make certain windows floating
    --for class,bool in pairs(floatapps) do
    --    if c.class:lower():find(class) and bool then
    --        c.floating = true
    --        break
    --    end
    --end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)

    -- Honor size hints
    c.honorsizehints = true
end

-- Hook function to execute when arranging the screen
-- (tag switch, new client, etc)
function hook_arrange(screen)
    local layout = awful.layout.get(screen)
    if layout then
        mylayoutbox[screen].text =
            "<bg image=\"/usr/local/share/awesome/icons/layouts/" .. awful.layout.get(screen) .. "w.png\" resize=\"true\"/>"
        else
            mylayoutbox[screen].text = "No layout."
    end

    -- If no window has focus, give focus to the latest in history
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end
end

-- Set up some hooks
awful.hooks.focus.register(hook_focus)
awful.hooks.unfocus.register(hook_unfocus)
awful.hooks.marked.register(hook_marked)
awful.hooks.unmarked.register(hook_unmarked)
awful.hooks.manage.register(hook_manage)
awful.hooks.mouseover.register(hook_mouseover)
awful.hooks.arrange.register(hook_arrange)
awful.hooks.timer.register(3, battery)
-- }}}
