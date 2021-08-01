--local Window = gui.Window("dizzenthook","                                                 d i z z e n t h o o k",150,150,400,735)
--local open_menu_key = gui.Reference("Settings", "Advanced", "Manage advanced settings", "Open Menu Key")
--Window:SetOpenKey(open_menu_key:GetValue())
--Window:SetActive(true)
local menu_key = gui.GetValue("adv.menukey")

print("d i z z e n t h o o k - Removed window and using tab due to lua limitations")
--print("- Removed window and using tab due to lua limitations")

local Window = gui.Tab(gui.Reference("Misc"), "semirage", "dizzenthook")

local Window2 = gui.Tab(gui.Reference("Misc"), "semirage", "mindmg")

--local tab = gui.Tab(gui.Reference("dizzenthook"), "Semirage", "Semirage")

local misc = gui.Groupbox(Window, "Misc", 10, 10, 200)
local ind = gui.Groupbox(Window, "Indicators", 350, 10, 200)
local legitaa = gui.Groupbox(Window, "Legit Anti-Aim", 220, 10, 120)
local enhancements = gui.Groupbox(Window, "Enhancements", 220, 260, 120)

local background_color = gui.ColorPicker(ind, "background_color", "Background Color", 0, 0, 0, 100)
local indicator_color = gui.ColorPicker(ind, "indicator_color", "Indicator Color", 255, 75, 15, 255)
local trigger_ind = gui.Checkbox(ind, "trigger_ind", "Trigger Magnet Indicator", 0)
local awall_ind = gui.Checkbox(ind, "awall_ind", "Autowall Indicator", 0)
local dmg_ind = gui.Checkbox(ind, "dmg_ind", "Min damage Indicator", 0)
local fake_ind = gui.Checkbox(ind, "fake_ind", "Fake Side Indicator", 0)
local baim_ind = gui.Checkbox(ind, "baim_ind", "Baim Indicator", 0)
local peekreal_ind = gui.Checkbox(ind, "peekreal_ind", "Peekreal Indicator", 0)
local freestand_ind = gui.Checkbox(ind, "freestand_ind", "Freestand Indicator", 0)
local Legit_aa = gui.Checkbox(legitaa, "legitaa", "Legit-aa", 0)
--local Left_Key = gui.Keybox(legitaa, "Leftkey", "Left Key", 0)
--local Right_Key = gui.Keybox(legitaa, "RightKey", "Right Key", 0)
local Left
local Right
local ragekey = gui.Keybox(misc, "Ragekey", "Ragebot Key", 0)
local awkey = gui.Keybox(misc, "Awallkey", "Autowall Key", 0)
local baim_hotkey = gui.Keybox(misc, "baim_on_key_key", "Baim Key", 0)
local legit_aw = gui.Checkbox(misc, "legit_aw", "Legit Awall", false)
local antipred = gui.Checkbox(misc, "Legfucker", "Anti-Prediction", 0)
local enabletag = gui.Checkbox(misc, "customtagenable", "Custom clantag", 0)
local killsay = gui.Checkbox(misc, "killsay", "Kill says", 0)
local lowdelta = gui.Checkbox(legitaa, "lowdelta", "Low-delta", 0)
local extend = gui.Checkbox(legitaa, "Extend", "Extend", 0)
local peekreal = gui.Checkbox(legitaa, "peekreal", "Peek real", 0)
local slidewalk = "misc.slidewalk"
local lastt = 0
local time = 0
local state = true
local slowwalkkey = gui.GetValue("rbot.accuracy.movement.slowkey")
local delta = gui.GetValue("rbot.antiaim.base.rotation")
local aastate = false
local pingvalue = gui.Slider(legitaa, "pingvalue", "Max Ping", 100, 1, 200)
local votes = gui.Checkbox(enhancements, "showvote", "Show Votes", 0)
local freestand = gui.Checkbox(enhancements, "freestand", "Freestanding", 0)

local dmgsettings = gui.Groupbox(Window2, "Checkbox", 16, 16, 280, 300)
local dmgkey = gui.Checkbox(dmgsettings, "ChangeDmgKey", "Mindamage Key", 0)

local dmgvalues = gui.Groupbox(Window2, "Damage Settings", 16, 120, 280, 300)
local awpDamage = gui.Slider(dmgvalues, "awpDamage", "Awp Min Damage Override", 1, 0, 130)

local scoutDamage = gui.Slider(dmgvalues, "scoutDamage", "Scout Min Damage Override", 1, 0, 130)

local autoDamage = gui.Slider(dmgvalues, "autoDamage", "Auto Min Damage Override", 1, 0, 130)

local r8Damage = gui.Slider(dmgvalues, "r8Damage", "R8 Min Damage Override", 1, 0, 130)

local awpori = gui.Slider(dmgvalues, "awpori", "Awp Original Min Damage", 1, 0, 130)
local scoutori = gui.Slider(dmgvalues, "scoutori", "Scout Original Min Damage", 1, 0, 130)
local autoori = gui.Slider(dmgvalues, "autoori", "Auto Original Min Damage", 1, 0, 130)
local r8ori = gui.Slider(dmgvalues, "r8ori", "R8 Original Min Damage", 1, 0, 130)

-- local awpori = gui.GetValue("rbot.accuracy.weapon.sniper.mindmg")
-- local scoutori = gui.GetValue("rbot.accuracy.weapon.scout.mindmg")
-- local autoori = gui.GetValue("rbot.accuracy.weapon.asniper.mindmg")
-- local r8ori = gui.GetValue("rbot.accuracy.weapon.hpistol.mindmg")

local font = draw.CreateFont("Calibri", 20)

local frame_rate = 0.0
local get_abs_fps = function()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    return math.floor((1.0 / frame_rate) + 0.5)
end

function isOpen()
    if (gui.Reference("MENU"):IsActive()) then
        Window:SetActive(true)
    else
        Window:SetActive(false)
    end
end
callbacks.Register("Draw", isOpen)
-- local function get_enemy_players()
--     local players = entities.FindByClass("CCSPlayer")
--     local enemy_players = {}
--     for i, v in next, players do
--         if v:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and v:IsAlive() and not v:IsDormant() then
--             table.insert(enemy_players, v)
--         end
--     end
--     return enemy_players
-- end

local pressedd = false
local function freestanding()
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then
        return
    end

    if freestand:GetValue() then
        gui.SetValue("rbot.antiaim.advanced.autodir.edges", 1)
    else
        gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
    end
end

local function legitantiaim()
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then
        return
    end
    if not Legit_aa:GetValue() then
        aastate = false
        gui.SetValue("rbot.antiaim.base", "0.0 Off")
        gui.SetValue("lbot.antiaim.type", "Off")
        return
    end

    if not entities.GetLocalPlayer() then
        return
    end

    --local players = entities.FindByClass( "CCSPlayer" )
    --local num = -1
    local Entity = entities.GetLocalPlayer()
    local Alive = Entity:IsAlive()
    local velocityX = Entity:GetPropFloat("localdata", "m_vecVelocity[0]")
    local velocityY = Entity:GetPropFloat("localdata", "m_vecVelocity[1]")
    local velocity = math.sqrt(velocityX ^ 2 + velocityY ^ 2)
    local FinalVelocity = math.min(9999, velocity) + 0.2
    if (Alive == true) then
        speed = math.floor(FinalVelocity)
    else
        speed = 0
    end

    -- draw.TextShadow(500,500,"Ping: " .. #players)

    -- for i = 1, #players do
    --     local player = players[ i ]

    --     if player:IsAlive() and not Entity:IsDormant() then
    --         num = num + 1
    --     end
    -- end
    -- local enemy_players = get_enemy_players()
    -- -- for i = 1, #players do
    -- --     local Entity = players[i]
    -- --     local Team = Entity:GetTeamNumber() == LocalPlayer:GetTeamNumber()

    -- --     if (not Team and not Entity:IsDormant() and Entity:IsAlive()) then
    -- --         draw.TextShadow(500,500,"aaaaaaaaaaaa: " .. #players)
    -- --     end
    -- -- end

    -- draw.TextShadow(550,500,"Pingaa: " .. enemy_players)
    --if (not Team and not Entity:IsDormant() and Entity:IsAlive()) then
    --    draw.TextShadow(500,500,"Ping: " .. huhhhhh)
    --end
    --player = player + 1

    local Ping = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex())
    if get_abs_fps() < 64 or Ping > pingvalue:GetValue() then
        gui.SetValue("lbot.antiaim.enemy", 1)
        gui.SetValue("rbot.antiaim.base", "0.0 Off")
        gui.SetValue("lbot.antiaim.type", "Off")
        aastate = false
    elseif extend:GetValue() then
        gui.SetValue("lbot.antiaim.enemy", 0)
        gui.SetValue("rbot.antiaim.base", "0.0 Desync")
        gui.SetValue("lbot.antiaim.type", "Maximum")
        aastate = true
    else
        gui.SetValue("lbot.antiaim.enemy", 0)
        gui.SetValue("rbot.antiaim.base", "0.0 Desync")
        gui.SetValue("lbot.antiaim.type", "Minimum")
        aastate = true
    end

    --draw.TextShadow(500,500,"Ping: " .. Ping)
    --draw.TextShadow(500,515, "Fps: " .. get_abs_fps())
    --if aastate then
    --    draw.TextShadow(500,530, "AA: On" )
    --else
    --    draw.TextShadow(500,530, "AA: Off" )
    --end

    local slowwalkkey = gui.GetValue("rbot.accuracy.movement.slowkey")
    if lowdelta:GetValue() then
        if input.IsButtonDown(slowwalkkey) and speed > 20 then
            allah = math.random(1, 100)
            if allah > 85 then
                delta = math.random(-15, -35)
            else
                --delta = math.random(30, 35) --math.random(-60, 60)
                delta = math.random(30, 35)
            end
        else
            delta = 58
        end
    end

    if gui.GetValue("rbot.antiaim.base.rotation") > 1 then
        Left = true
        Right = false
    elseif gui.GetValue("rbot.antiaim.base.rotation") < -1 then
        Left = false
        Right = true
    end
end

callbacks.Register(
    "CreateMove",
    function(cmd)
        if not cmd.sendpacket then
            return
        end

        local local_player = entities.GetLocalPlayer()

        local eye_pos = local_player:GetAbsOrigin()
        local yaw = cmd:GetViewAngles().yaw

        local frac_num = {["f_left"] = 0, ["f_right"] = 0}

        for i = yaw - 90, yaw + 90, 30 do
            if i ~= yaw then
                local rad = math.rad(i)

                local destination = Vector3(eye_pos.x + 200 * math.cos(rad), eye_pos.y + 200 * math.sin(rad), eye_pos.z)

                local trace = engine.TraceLine(eye_pos, destination, 0xFFFFFFFF)

                local side = i < yaw and "f_left" or "f_right"

                frac_num[side] = frac_num[side] + trace.fraction
            end
        end

        if peekreal:GetValue() then
            gui.SetValue("rbot.antiaim.base.rotation", frac_num["f_left"] > frac_num["f_right"] and -delta or delta)
        else
            gui.SetValue("rbot.antiaim.base.rotation", frac_num["f_left"] > frac_num["f_right"] and delta or -delta)
        end
        if extend:GetValue() then
            if peekreal:GetValue() then
                gui.SetValue("rbot.antiaim.base.lby", frac_num["f_left"] > frac_num["f_right"] and 120 or -120)
            else
                gui.SetValue("rbot.antiaim.base.lby", frac_num["f_left"] > frac_num["f_right"] and -120 or 120)
            end
        else
            gui.SetValue("rbot.antiaim.base.lby", 0)
        end
    end
)

local function ragebot()
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then
        return
    end

    if ragekey:GetValue() ~= 0 then
        if input.IsButtonDown(ragekey:GetValue()) then
            gui.SetValue("rbot.master", 1)
            gui.SetValue("rbot.aim.enable", 1)
            gui.SetValue("lbot.master", 0)
        elseif input.IsButtonDown(0x01) then
            gui.SetValue("rbot.master", 0)
            gui.SetValue("rbot.aim.enable", 0)
            gui.SetValue("lbot.master", 1)
        else
            gui.SetValue("rbot.master", 1)
            gui.SetValue("rbot.aim.enable", 0)
            gui.SetValue("lbot.master", 0)
        end
    end
end

--start
local weapon_types = {
    "shared.",
    "zeus.",
    "pistol.",
    "hpistol.",
    "smg.",
    "rifle.",
    "shotgun.",
    "scout.",
    "asniper.",
    "sniper.",
    "lmg."
}

local autowall_var1 = false
local autowall_var2 = false

local PI = math.pi
local DEG_TO_RAD = PI / 180.0
local RAD_TO_DEG = 180.0 / PI

local function vec3_normalize(x, y, z)
    local len = math.sqrt(x * x + y * y + z * z)
    if len == 0 then
        return 0, 0, 0
    end
    local r = 1 / len
    return x * r, y * r, z * r
end

local function vec3_dot(ax, ay, az, bx, by, bz)
    return ax * bx + ay * by + az * bz
end

local function angle_to_vec(pitch, yaw)
    local pitch_rad, yaw_rad = DEG_TO_RAD * pitch, DEG_TO_RAD * yaw
    local sp, cp, sy, cy = math.sin(pitch_rad), math.cos(pitch_rad), math.sin(yaw_rad), math.cos(yaw_rad)
    return cp * cy, cp * sy, -sp
end
function calculate_fov_to_player(ent, lx, ly, lz, fx, fy, fz)
    local pOrigin = ent:GetProp("m_vecOrigin")
    local px, py, pz = pOrigin.x, pOrigin.y, pOrigin.z
    local dx, dy, dz = vec3_normalize(px - lx, py - ly, lz - lz)
    local dot_product = dx * fx + dy * fy + dz * fz
    local cos_inverse = math.acos(dot_product)
    return RAD_TO_DEG * cos_inverse
end

local function get_enemy_players()
    local players = entities.FindByClass("CCSPlayer")
    local enemy_players = {}
    for i, v in next, players do
        if v:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and v:IsAlive() and not v:IsDormant() then
            table.insert(enemy_players, v)
        end
    end

    return enemy_players
end

local function calculate_fov_to_player(ent, lx, ly, lz, fx, fy, fz)
    local pOrigin = ent:GetProp("m_vecOrigin")
    local px, py, pz = pOrigin.x, pOrigin.y, pOrigin.z
    local dx, dy, dz = vec3_normalize(px - lx, py - ly, lz - lz)
    local dot_product = vec3_dot(dx, dy, dz, fx, fy, fz)
    local cos_inverse = math.acos(dot_product)
    return RAD_TO_DEG * cos_inverse
end

local function get_closest_player_to_crosshair(lx, ly, lz, pitch, yaw)
    local fx, fy, fz = angle_to_vec(pitch, yaw)
    local enemy_players = get_enemy_players()
    local nearest_player = nil
    local nearest_player_fov = math.huge
    for i = 1, #enemy_players do
        local enemy_ent = enemy_players[i]
        local fov_to_player = calculate_fov_to_player(enemy_ent, lx, ly, lz, fx, fy, fz)
        if fov_to_player <= nearest_player_fov then
            nearest_player = enemy_ent
            nearest_player_fov = fov_to_player
        end
    end
    return nearest_player, nearest_player_fov
end

local function entities_check()
    local lp = entities.GetLocalPlayer()
    local abs_o
    if lp then
        abs_o = lp:GetAbsOrigin()
        if (math.floor((lp:GetPropInt("m_fFlags") % 4) / 2) == 1) then
            z = 46
        else
            z = 64
        end
        abs_o.z = abs_o.z + lp:GetPropVector("localdata", "m_vecViewOffset[0]").z
        return abs_o, lp
    end
end

local function is_player_visible(local_player, lx, ly, lz, ent)
    local visible_hitboxes = 0
    for i = 0, 18 do
        local epos = ent:GetHitboxPosition(i)
        local ex, ey, ez = epos.x, epos.y, epos.z
        local entindex = engine.TraceLine(Vector3(lx, ly, lz), epos, 0xFFFFFFFF)
        if entindex.entity:GetIndex() == ent:GetIndex() then
            visible_hitboxes = visible_hitboxes + 1
        end
        if visible_hitboxes >= 1 then
            return true
        end
    end
    return visible_hitboxes >= 1
end

local function AWHandler()

    if awkey:GetValue() or legit_aw:GetValue() then
        for i, v in next, weapon_types do
            gui.SetValue("rbot.hitscan.mode."..v.."autowall", (autowall_var1 or autowall_var2 and legit_aw:GetValue()))
        end
    end
end

-- check for key press
callbacks.Register("Draw", function()
    if not entities.GetLocalPlayer() then return end
    if not entities.GetLocalPlayer():IsAlive() then return end

    if awkey:GetValue() ~= 0 then
        if input.IsButtonDown(awkey:GetValue()) then
            autowall_var1 = true
        else
            autowall_var1 = false
        end
    end
    AWHandler()
end)

-- check for enemy visible
callbacks.Register("Draw", function()
    local local_player = entities.GetLocalPlayer()

    if not local_player then return end
    if not local_player:IsAlive() then return end

    local maximum_fov = gui.GetValue("rbot.aim.target.fov")
    local engine_view_angles = engine.GetViewAngles()
    local pitch, yaw = engine_view_angles.pitch, engine_view_angles.yaw
    local origin = local_player:GetProp("m_vecOrigin")
    local eye_pos = local_player:GetHitboxPosition(0)
    local lx, ly, lz = eye_pos.x, eye_pos.y, eye_pos.z
    local nearest_player, nearest_player_fov = get_closest_player_to_crosshair(lx, ly, lz, pitch, yaw)

    if nearest_player ~= nil and nearest_player_fov <= maximum_fov * 2 and legit_aw:GetValue() then
        autowall_var2 = is_player_visible(local_player, lx, ly, lz, nearest_player)
    else
        autowall_var2 = false
    end
    AWHandler()
end)

local active = {
    [true] = {
        ["bodyaim.force"] = 1,
        ["bodyaim.lethal"] = 0,
        ["bodyaim.onshot"] = 0,
        ["bodyaim.safepoint"] = 0,
        ["prefersafe"] = 0,
        ["forcesafe"] = 1,
        ["forcesafe.limbs"] = 1,
        ["forcesafe.head"] = 1,
        ["forcesafe.body"] = 1
    },
    [false] = {}
}

local function setValues(val)
    for i = 1, #weapon_types do
        local wep = "rbot.hitscan.mode." .. weapon_types[i]

        if val then
            for k, v in pairs(active[true]) do
                active[false][wep .. k] = gui.GetValue(wep .. k)
                gui.SetValue(wep .. k, v)
            end
        else
            for k, v in pairs(active[false]) do
                gui.SetValue(k, v)
            end
        end
    end
end

local function move_box()
    for i = 1, #weapon_types do
        if gui.GetValue("rbot.hitscan.mode." .. weapon_types[i] .. "forcesafe") then
            return true
        end
    end
end

local pressed = false
callbacks.Register(
    "Draw",
    function()
        local key = baim_hotkey:GetValue()
        if key == 0 then
            return
        end

        if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then
            return
        end

        local mode = "Toggle"
        if mode == "Toggle" then
            if input.IsButtonReleased(key) then
                pressed = not pressed
                setValues(pressed)
            end
        end

        local r, g, b = 255, 25, 25
        if pressed then
            r, g, b = 112, 255, 0
        end
    end
)
--start
local _SetTag = ffi.cast("int(__fastcall*)(const char*, const char*)", mem.FindPattern("engine.dll", "53 56 57 8B DA 8B F9 FF 15"))
local last = nil
local tag = " "
local lasttag = nil
local tagsteps = {}

local SetTag = function(v)
    if v ~= last then
        _SetTag(v, "")
        last = v
    end
end

local function makesteps()
    tagsteps = {" "}

    for i = 1, #tag do
        table.insert(tagsteps, tag:sub(1, i))
    end

    for i = #tagsteps - 1, 1, -1 do
        table.insert(tagsteps, tagsteps[i])
    end
end

local function settag()
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then
        return
    end
    if enabletag:GetValue() then
        gui.SetValue("misc.clantag", false)
        tag = "dizzenthook    "
        if lasttag ~= tag then
            makesteps()
            lasttag = tag
        end
        SetTag(tagsteps[math.floor(globals.TickCount() / ((11 - 5) * 3.5)) % (#tagsteps - 1) + 1])
    else
        SetTag("")
    end
end

callbacks.Register("Draw", settag)

callbacks.Register(
    "Unload",
    function()
        SetTag("")
    end
)
--end

local function time_to_ticks(a)
    return math.floor(1 + a / globals.TickInterval())
end

--start
--UI References
--local misc = gui.Groupbox(Window, "Misc", 10, 10, 200)
-- Makes new UI Boxes & Sliders



--Gets stuff
local function changeMinDamage()
    if dmgkey:GetValue() then
        gui.SetValue("rbot.accuracy.weapon.sniper.mindmg", awpDamage:GetValue())

        gui.SetValue("rbot.accuracy.weapon.scout.mindmg", scoutDamage:GetValue())

        gui.SetValue("rbot.accuracy.weapon.asniper.mindmg", autoDamage:GetValue())

        gui.SetValue("rbot.accuracy.weapon.hpistol.mindmg", r8Damage:GetValue())
    else
        gui.SetValue("rbot.accuracy.weapon.asniper.mindmg", autoori:GetValue())

        gui.SetValue("rbot.accuracy.weapon.sniper.mindmg", awpori:GetValue())

        gui.SetValue("rbot.accuracy.weapon.scout.mindmg", scoutori:GetValue())

        gui.SetValue("rbot.accuracy.weapon.hpistol.mindmg", r8ori:GetValue())
    end
end
--end

local function indicator()
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then
        return
    end

    local background_r, background_g, background_b, background_a = background_color:GetValue()
    local indicator_r, indicator_g, indicator_b, indicator_a = indicator_color:GetValue()

    local w, h = draw.GetScreenSize()
    x = w / 2
    y = h / 2

    local offset = 0.4
    draw.SetFont(font)

    --local st = entities.GetLocalPlayer():GetProp("m_flSimulationTime")
    --local std = globals.CurTime() - st
    --local choke = (std / globals.TickInterval())
    --local percentage = 100 / 6 * choke
    --local fl = time_to_ticks(globals.CurTime() - entities.GetLocalPlayer():GetPropFloat("m_flSimulationTime")) + 2
    --draw.TextShadow(x - draw.GetTextSize("FL") / 2, y + 25, "FL" .. fl)
    --draw.indicator(r, g, b, a, "FL " .. fl)
    --draw.TextShadow(500,500,"FL " .. percentage)

    --draw.indicator(255, 255, 255, 255, "LC")

    if trigger_ind:GetValue() then
        offset = offset + 0.6
        if gui.GetValue("rbot.aim.enable") then
            draw.Color(indicator_r, indicator_g, indicator_b, indicator_a)
        else
            draw.Color(background_r, background_g, background_b, background_a)
        end
        draw.TextShadow(x - draw.GetTextSize("TM") / 2, y + offset * 25, "TM")
    end

    if awall_ind:GetValue() then
        offset = offset + 0.6
        if gui.GetValue("rbot.hitscan.mode.shared.autowall") then
            draw.Color(indicator_r, indicator_g, indicator_b, indicator_a)
        else
            draw.Color(background_r, background_g, background_b, background_a)
        end
        draw.TextShadow(x - draw.GetTextSize("AWALL") / 2, y + offset * 25, "AWALL")
    end

    if baim_ind:GetValue() then
        if pressed then
            offset = offset + 0.6
            draw.Color(indicator_r, indicator_g, indicator_b, indicator_a)
        else
            offset = offset + 0.6
            draw.Color(background_r, background_g, background_b, background_a)
        end
        draw.TextShadow(x - draw.GetTextSize("BAIM") / 2, y + offset * 25, "BAIM")
    end

    if fake_ind:GetValue() then
        if Legit_aa:GetValue() then
            --offset = offset + 0.6
            if aastate and delta >= 58 then
                draw.Color(indicator_r, indicator_g, indicator_b, indicator_a)
            elseif aastate and delta < 58 then
                draw.Color(indicator_r, indicator_g, indicator_b, indicator_a / 2)
            else
                draw.Color(background_r, background_g, background_b, background_a)
            end

            if Left then
                --draw.Triangle(y * 1.23 - 20, x / 1.25 + 5, y * 1.23 - 20, x / 1.25 - 5, y * 1.23 - 40, x / 1.25)
                draw.TextShadow(x - 40, y - 5, "◄")
            elseif not Left then
                draw.TextShadow(x + 25, y - 5, "►")
            --draw.Triangle(y * 1.27 + 20, x / 1.25 + 5, y * 1.27 + 20, x / 1.25 - 5, y * 1.27 + 40, x / 1.25)
            --draw.Triangle(y * 1.25 + 40, x / 1.25 + 9, y * 1.25 + 40, x / 1.25 - 9, y * 1.25 + 55, x / 1.25) thick
            end

        --[[ if Left and delta < 58 then
                draw.FilledRect(y*1.25-35, x/1.25+9, y*1.25-37, x/1.25-9)
            elseif not Left and delta < 58 then
                draw.FilledRect(y*1.25+35, x/1.25+9, y*1.25+37, x/1.25-9)
            end ]]
        end
    end
    --draw.Color(255,255,255,255)
    --draw.FilledRect(y*1.25-35, x/1.25+9, y*1.25-37, x/1.25-9)
    --draw.FilledRect(y*1.25+35, x/1.25+9, y*1.25+37, x/1.25-9)
    --draw.Color(Rr,Rg,Rb,Rw)

    if dmg_ind:GetValue() then
        if dmgkey:GetValue() then
            offset = offset + 0.6
            draw.Color(indicator_r, indicator_g, indicator_b, indicator_a)
            draw.TextShadow(x - draw.GetTextSize("DMG") / 2, y + offset * 25, "DMG")
        else
            offset = offset + 0.6
            draw.Color(background_r, background_g, background_b, background_a)
            draw.TextShadow(x - draw.GetTextSize("DMG") / 2, y + offset * 25, "DMG")
        end
    end

    if peekreal_ind:GetValue() then
        if peekreal:GetValue() then
            offset = offset + 0.6
            draw.Color(indicator_r, indicator_g, indicator_b, indicator_a)
            draw.TextShadow(x - draw.GetTextSize("PEEK-REAL") / 2, y + offset * 25, "PEEK-REAL")
        end
    end

    if gui.GetValue("rbot.antiaim.condition.shiftonshot") then
        offset = offset + 0.6
        draw.Color(indicator_r, indicator_g, indicator_b, indicator_a)
        draw.TextShadow(x - draw.GetTextSize("HIDE") / 2, y + offset * 25, "HIDE")
    end

    if freestand_ind:GetValue() then
        if freestand:GetValue() then
            offset = offset + 0.6
            draw.Color(indicator_r, indicator_g, indicator_b, indicator_a)
            draw.TextShadow(x - draw.GetTextSize("FREESTAND") / 2, y + offset * 25, "FREESTAND")
        end
    end
end

local function legfucker()
    if not antipred:GetValue() then
        return
    end
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then
        time = 0
        return
    end

    if globals.CurTime() > time then
        state = not state
        time = globals.CurTime() + 0.075
        entities.GetLocalPlayer():SetPropInt(0, "m_flPoseParameter")
    end
    gui.SetValue(slidewalk, state)
    -- if globals.CurTime() > lastt then
    --     state = not state
    --     lastt = globals.CurTime() + 0.05
    --     entities.GetLocalPlayer():SetPropInt(1, "m_flPoseParameter")
    --     gui.SetValue(slidewalk, state)
    -- end
end

local Kill_String = {
    "卐 Ａｗａｌｌ ｍｅ ｏｎｃｅ ａｎｄ ｉ ａｗａｌｌ ｔｗｉｃｅ 卐",
    "oops :D",
    "Eat it nn Ɑ͞ ̶͞ ̶͞ ﻝﮞ",
    "nice die to legit kfg???",
    "VIS SHOT BRO I SWEAR!!!",
    "2ez for vis awal))",
    "ez awalled nigger",
    "Automatic Penetration Is False Sir",
    "˜”*°•.★.. ОДИН ..★.•°*”˜ ",
    "lucky shot nn",
    "༺Leͥgeͣnͫd༻ᴳᵒᵈ",
    "꧁✪♕BOT♕✪꧂",
    "♡︎  AWP - senpai ◕︎‿︎◕︎ [ツ︎]",
    "NN AWALLED(ಠ_ಠ)┌∩┐",
    "༻︻デ═一♣u suk♡︎◕︎‿︎◕︎",
    "AWPutin༻︻デ═一",
    "(っ◔◡◔)っ ♥ ezz noobs ♥",
    "⎝ツ⎠╾━╤デ╦︻(▀̿Ĺ̯▀̿ ̿)",
    "ＳＥＭＩＲＡＧＥ ＡＣＴＩＶＡＴＥＤ (◣_◢)",
    "im rape you",
    "Ｉ ＦＵＣＫ ＹＯＵＲ ＴＯＥＳ =)",
    "tap tap tap (◣_◢)",
    "nice main",
    "nice semen lips",
    "you more fat than logiqq",
    "who? me 0 car",
    "nt, go awall next time)",
    "you smell bad",
    "nike resolver men",
    "nae nigga nae nae",
    "♕♕ C R I N G E ♕♕",
    "and? me play baypas",
    "get 1'd you hairy turk böss",
    "give confik plis",
    "Legs shaved, butt plug in, programming socks on",
    "♣csgo pLAY♠",
    "(っ◔◡◔)っ ♥ Ace Awp♥",
    "🔥🔥🔥AIM-HACKING.exe🔥",
    "✘︎NeveR●︎Give●︎Up✘︎ヅ︎",
    "The whit guy┌∩┐",
    "⋙ ✿ Legend (^ ω ^) ✿⋘",
    "🆃🅷🅴 🅺🅸🅽🅶 🅷🅴🅰🅳🆂🅾🆃",
    "𝒸𝑒𝑜 𝑜𝒻𝑜 𝒶𝓃𝒶𝓁",
    "u are idiots all",
    "all dogs wish my playstyle"
}

local function CHAT_KillSay(Event)
    if (Event:GetName() == "player_death") then
        local ME = client.GetLocalPlayerIndex()

        local INT_UID = Event:GetInt("userid")
        local INT_ATTACKER = Event:GetInt("attacker")

        local NAME_Victim = client.GetPlayerNameByUserID(INT_UID)
        local INDEX_Victim = client.GetPlayerIndexByUserID(INT_UID)

        local NAME_Attacker = client.GetPlayerNameByUserID(INT_ATTACKER)
        local INDEX_Attacker = client.GetPlayerIndexByUserID(INT_ATTACKER)

        if killsay:GetValue() then
            if (INDEX_Attacker == ME and INDEX_Victim ~= ME) then
                random = math.random(1, 44)
                client.ChatSay(" " .. tostring(Kill_String[random]))
            end
        end
    end
end
client.AllowListener("player_death")

--start
local c_hud_chat =
ffi.cast(
    "unsigned long(__thiscall*)(void*, const char*)",
    mem.FindPattern("client.dll", "55 8B EC 53 8B 5D 08 56 57 8B F9 33 F6 39 77 28")
)(
    ffi.cast(
        "unsigned long**",
        ffi.cast("uintptr_t", mem.FindPattern("client.dll", "B9 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B 5D 08")) + 1
    )[0],
    "CHudChat"
)

local ffi_print_chat =
    ffi.cast("void(__cdecl*)(int, int, int, const char*, ...)", ffi.cast("void***", c_hud_chat)[0][27])

function client.PrintChat(msg)
    ffi_print_chat(c_hud_chat, 0, 0, " " .. msg)
end

local vote_print_chat =
    (function()
    local on = votes
    --on:SetDescription("Print voting information in local client chat.")

    callbacks.Register(
        "DispatchUserMessage",
        function(um)
            local lp = entities.GetLocalPlayer()
            if not (gui.GetValue("misc.master") and on:GetValue() and lp) then
                return
            end

            local team = lp:GetTeamNumber()
            local clr = team == 2 and "\09" or team == 3 and "\10" or "\01"
            if um:GetID() == 46 then
                local type = um:GetInt(3)
                local type_name =
                    type == 0 and "\07kick " or type == 1 and " Change map " or type == 6 and "\04Surrender" or
                    type == 13 and "\07Call a timeout"

                client.PrintChat(
                    "[" ..
                        clr ..
                            "dizzenthook\01] " ..
                                client.GetPlayerNameByIndex(um:GetInt(2)) ..
                                    " wants to " .. type_name .. um:GetString(5)
                )
            end

            local results = um:GetID() == 47 and "\06Passed" or um:GetID() == 48 and "\02Failed"
            local _ = results and client.PrintChat("[" .. clr .. "dizzenthook\01] " .. "vote " .. results)
        end
    )

    client.AllowListener("vote_cast")

    callbacks.Register(
        "FireGameEvent",
        function(e)
            local lp = entities.GetLocalPlayer()
            if not (gui.GetValue("misc.master") and on:GetValue() and lp) then
                return
            end

            if e:GetName() and e:GetName() == "vote_cast" then
                local team = lp:GetTeamNumber()
                local option = e:GetInt("vote_option")
                local results = option == 0 and "\06Yes" or option == 1 and "\07No" or "?"

                client.PrintChat(
                    "[" ..
                        (team == 2 and "\09" or team == 3 and "\10" or "\01") ..
                            "dizzenthook\01] " ..
                                client.GetPlayerNameByIndex(e:GetInt("entityid")) .. " voted " .. results
                )
            end
        end
    )
end)()
--end
callbacks.Register("Draw", freestanding)
callbacks.Register("Draw", legitantiaim)
callbacks.Register("Draw", ragebot)
--callbacks.Register("Draw", autowall)
callbacks.Register("Draw", indicator)
--callbacks.Register("Draw", legfucker)
callbacks.Register("Draw", changeMinDamage)
callbacks.Register(
    "Draw",
    function()
        if entities.GetLocalPlayer() then
            entities.GetLocalPlayer():SetPropInt(1, "m_flPoseParameter")
            legfucker()
        end
    end
)
callbacks.Register("FireGameEvent", "AWKS", CHAT_KillSay)
