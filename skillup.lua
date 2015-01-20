--version 1.0.5.0
--[[How to use:
    --this tool is set it and forget it you can leave it running for hours as long as se does not log you out it will keep running--
    1.)place "skillup.lua" in your normal gearswap folder(where all your job files are)
    2.)then us "gs l skillup.lua" to load this skill up in to gearswap
    3.) on lines 22 and 25 of this file you can put in you wind and string instruments
    to start Geomancy magic skillup use command "gs c startgeo"
    to start Healing magic skillup use command "gs c starthealing"
    to start Enhancing magic skillup use command "gs c startenhancing"
    to start Ninjutsu magic skillup use command "gs c startninjutsu"
    to start Singing magic skillup use command "gs c startsinging"
    to start Blue magic skillup use command "gs c startblue"
    to start Summoning magic skillup use command "gs c startsmn"
    to stop all skillups use command "gs c skillstop"
    to auto shutdown after skillup use command "gs c aftershutdown"
    to auto logoff after skillup use command "gs c afterlogoff"
    to just stop and stay logged on after skillup use command "gs c afterStop"(only needed if you use one of the above auto shutdown/logoff)
    
    much thanks to Arcon,Byrth,Mote,and anybody else i forgot for the help in making this]]
-- Save Window Location (default: false)
save_window_location = false
packets = require('packets')
box = {}
box.pos = {}
box.pos.x = 211
box.pos.y = 402
box.text = {}
box.text.font = 'Dotum'
box.text.size = 12
box.bg = {}
box.bg.alpha = 255
boxa = {}
boxa.pos = {}
boxa.pos.x = box.pos.x - 140
boxa.pos.y = box.pos.y
boxa.text = {}
boxa.text.font = 'Dotum'
boxa.text.size = 9
boxa.bg = {}
boxa.bg.alpha = 255
skill_ups = {}
total_skill_ups = 0
skill = {}
last_nin = 'none'
color_GEO = true
color_HEL = true
color_ENH = true
color_NIN = true
color_SIN = true
color_BLU = true
color_SMN = true
color_STOP = true
color_DOWN = true
color_LOG = true
if gearswap.pathsearch({'Saves/skillup_data.lua'}) then
    include('Saves/skillup_data.lua')
end
window = texts.new(box)
button = texts.new(boxa)
function get_sets()
    skilluprun = false
    sets.brd = {}
    sets.brd.wind = {
        range="Cornette"--put your wind instrument here
    }
    sets.brd.string = {
        range="Lamia Harp"--put your string instrument here
    }
    skilluptype = {"Healing","Geomancy","Enhancing","Ninjutsu","Singing","Blue","Summoning"}
    skillupcount = 1
    geospells = {"Indi-Acumen","Indi-AGI","Indi-Attunement","Indi-Barrier","Indi-CHR","Indi-DEX","Indi-Fade","Indi-Fend","Indi-Focus","Indi-Frailty","Indi-Fury","Indi-Gravity","Indi-Haste","Indi-INT","Indi-Languor","Indi-Malaise","Indi-MND","Indi-Paralysis","Indi-Poison","Indi-Precision","Indi-Refresh","Indi-Regen","Indi-Slip","Indi-Slow","Indi-STR","Indi-Torpor","Indi-Vex","Indi-VIT","Indi-Voidance","Indi-Wilt"}
    geocount = 1
    healingspells = {"Blindna","Cura","Cura II","Cura III","Curaga","Curaga II","Curaga III","Curaga IV","Curaga V","Cure","Cure II","Cure III","Cure IV","Cure V","Cure VI","Cursna","Esuna","Paralyna","Poisona","Reraise","Reraise II","Reraise III","Silena","Stona","Viruna"}
    healingcount = 1
    enhancespells = {"Baraera","Baraero","Barblizzara","Barblizzard","Barfira","Barfire","Barstone","Barstonra","Barthunder","Barthundra","Barwater","Barwatera"}
    enhancecount = 1
    ninspells = {"Gekka: Ichi","Kakka: Ichi","Migawari: Ichi","Monomi: Ichi","Myoshu: Ichi","Tonko: Ichi","Tonko: Ni","Utsusemi: Ichi","Utsusemi: Ni","Yain: Ichi","Yain: Ichi","Gekka: Ichi"}
    nincount = 1
    nincant = T{}
    nincantcount = 0
    nin_tools ={
        ["Monomi: Ichi"] = {tool='Sanjaku-Tenugui',tool_bag="Toolbag (Sanja)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Aisha: Ichi"] = {tool='Soshi',tool_bag="Toolbag (Soshi)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Katon: Ichi"] = {tool='Uchitake',tool_bag="Toolbag (Uchi)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Katon: Ni"] = {tool='Uchitake',tool_bag="Toolbag (Uchi)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Katon: San"] = {tool='Uchitake',tool_bag="Toolbag (Uchi)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Hyoton: Ichi"] = {tool='Tsurara',tool_bag="Toolbag (Tsura)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Hyoton: Ni"] = {tool='Tsurara',tool_bag="Toolbag (Tsura)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Hyoton: San"] = {tool='Tsurara',tool_bag="Toolbag (Tsura)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Huton: Ichi"] = {tool='Kawahori-Ogi',tool_bag="Toolbag (Kawa)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Huton: Ni"] = {tool='Kawahori-Ogi',tool_bag="Toolbag (Kawa)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Huton: San"] = {tool='Kawahori-Ogi',tool_bag="Toolbag (Kawa)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Doton: Ichi"] = {tool='Makibishi',tool_bag="Toolbag (Maki)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Doton: Ni"] = {tool='Makibishi',tool_bag="Toolbag (Maki)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Doton: San"] = {tool='Makibishi',tool_bag="Toolbag (Maki)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Raiton: Ichi"] = {tool='Hiraishin',tool_bag="Toolbag (Hira)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Raiton: Ni"] = {tool='Hiraishin',tool_bag="Toolbag (Hira)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Raiton: San"] = {tool='Hiraishin',tool_bag="Toolbag (Hira)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Suiton: Ichi"] = {tool='Mizu-Deppo',tool_bag="Toolbag (Mizu)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Suiton: Ni"] = {tool='Mizu-Deppo',tool_bag="Toolbag (Mizu)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Suiton: San"] = {tool='Mizu-Deppo',tool_bag="Toolbag (Mizu)",uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)"},
        ["Utsusemi: Ichi"] = {tool='Shihei',tool_bag="Toolbag (Shihe)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Utsusemi: Ni"] = {tool='Shihei',tool_bag="Toolbag (Shihe)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Utsusemi: San"] = {tool='Shihei',tool_bag="Toolbag (Shihe)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Jubaku: Ichi"] = {tool='Jusatsu',tool_bag="Toolbag (Jusa)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Jubaku: Ni"] = {tool='Jusatsu',tool_bag="Toolbag (Jusa)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Jubaku: San"] = {tool='Jusatsu',tool_bag="Toolbag (Jusa)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Hojo: Ichi"] = {tool='Kaginawa',tool_bag="Toolbag (Kagi)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Hojo: Ni"] = {tool='Kaginawa',tool_bag="Toolbag (Kagi)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Hojo: San"] = {tool='Kaginawa',tool_bag="Toolbag (Kagi)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Kurayami: Ichi"] = {tool='Sairui-Ran',tool_bag="Toolbag (Sai)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Kurayami: Ni"] = {tool='Sairui-Ran',tool_bag="Toolbag (Sai)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Kurayami: San"] = {tool='Sairui-Ran',tool_bag="Toolbag (Sai)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Dokumori: Ichi"] = {tool='Kodoku',tool_bag="Toolbag (Kodo)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Dokumori: Ni"] = {tool='Kodoku',tool_bag="Toolbag (Kodo)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Dokumori: San"] = {tool='Kodoku',tool_bag="Toolbag (Kodo)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Tonko: Ichi"] = {tool='Shinobi-Tabi',tool_bag="Toolbag (Shino)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Tonko: Ni"] = {tool='Shinobi-Tabi',tool_bag="Toolbag (Shino)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Tonko: San"] = {tool='Shinobi-Tabi',tool_bag="Toolbag (Shino)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Gekka: Ichi"] = {tool='Ranka',tool_bag="Toolbag (Ranka)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Yain: Ichi"] = {tool='Furusumi',tool_bag="Toolbag (Furu)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Myoshu: Ichi"] = {tool='Kabenro',tool_bag="Toolbg. (Kaben)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Yurin: Ichi"] = {tool='Jinko',tool_bag="Toolbag (Jinko)",uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)"},
        ["Kakka: Ichi"] = {tool='Ryuno',tool_bag="Toolbag (Ryuno)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        ["Migawari: Ichi"] = {tool='Mokujin',tool_bag="Toolbag (Moku)",uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)"},
        }
    songspells = {"Knight's Minne","Advancing March","Adventurer's Dirge","Archer's Prelude","Army's Paeon","Army's Paeon II","Army's Paeon III","Army's Paeon IV","Army's Paeon V","Army's Paeon VI","Bewitching Etude","Blade Madrigal","Chocobo Mazurka","Dark Carol","Dark Carol II","Dextrous Etude","Dragonfoe Mambo","Earth Carol","Earth Carol II","Enchanting Etude","Fire Carol","Fire Carol II","Foe Sirvente","Fowl Aubade","Goblin Gavotte","Goddess's Hymnus","Gold Capriccio","Herb Pastoral","Herculean Etude","Hunter's Prelude","Ice Carol","Ice Carol II","Knight's Minne II","Knight's Minne III","Knight's Minne IV","Knight's Minne V","Learned Etude","Light Carol","Light Carol II","Lightning Carol","Lightning Carol II","Logical Etude","Mage's Ballad","Mage's Ballad II","Mage's Ballad III","Puppet's Operetta","Quick Etude","Raptor Mazurka","Sage Etude","Scop's Operetta","Sentinel's Scherzo","Sheepfoe Mambo","Shining Fantasia","Sinewy Etude","Spirited Etude","Swift Etude","Sword Madrigal","Uncanny Etude","Valor Minuet","Valor Minuet II","Valor Minuet III","Valor Minuet IV","Valor Minuet V","Victory March","Vital Etude","Vivacious Etude","Warding Round","Water Carol","Water Carol II","Wind Carol","Wind Carol II"}
    songcount = 1
    bluspells = {"Pollen","Wild Carrot","Refueling","Feather Barrier","Magic Fruit","Diamondhide","Warm-Up","Amplification","Triumphant Roar","Saline Coat","Reactor Cool","Plasma Charge","Plenilune Embrace","Regeneration","Animating Wail","Battery Charge","Magic Barrier","Fantod","Winds of Promy.","Barrier Tusk","White Wind","Harden Shell","O. Counterstance","Pyric Bulwark","Nat. Meditation","Carcharian Verve","Healing Breeze"}
    bluspellul = S{"Harden Shell","Thunderbolt","Absolute Terror","Gates of Hades","Tourbillion","Pyric Bulwark","Bilgestorm","Bloodrake","Droning Whirlwind","Carcharian Verve","Blistering Roar"}
    blucount = 1
    smnspells = {"Carbuncle","Cait Sith","Diabolos","Fenrir","Garuda","Ifrit","Leviathan","Ramuh","Shiva","Titan","Air Spirit","Dark Spirit","Earth Spirit","Fire Spirit","Ice Spirit","Light Spirit","Thunder Spirit","Water Spirit"}
    smncount = 1
    sets.Idle = {
        main="Dark Staff",
        left_ear="Relaxing Earring",
        right_ear="Liminus Earring",
    }
    shutdown = false
    logoff = false
    stoptype = "Stop"
    first_spell = 'none'
    frame_count = 0
    initialize(window, box, 'window')
    initialize(button, boxa, 'button')
    window:show()
    button:show()
end
function initialize(text, settings, a)
    if a == 'window' then
        local properties = L{}
        properties:append('--Skill Up--')
        properties:append('Mode :\n   ${mode|None}')
        if skilluptype[skillupcount] == 'Singing' then
            properties:append('\\crCurrent Singing Skill LVL:\n   ${skillssing|0}')
            properties:append('\\crCurrent String Skill LVL:\n   ${skillstring|0}')
            properties:append('\\crCurrent Wind Skill LVL:\n   ${skillwind|0}')
        elseif skilluptype[skillupcount] == 'Geomancy' then
            properties:append('\\crCurrent Geomancy Skill LVL:\n   ${skillgeo|0}')
            properties:append('\\crCurrent Handbell Skill LVL:\n   ${skillbell|0}')
        else
            properties:append('\\crCurrent Skilling LVL:\n   ${skillbulk|0}')
        end
        if shutdown then
            properties:append('\\crWill Shutdown When Skillup Done')
        elseif logoff then
            properties:append('\\crWill Logoff When Skillup Done')
        else
            properties:append('\\crWill Stop When Skillup Done')
        end
        properties:append('\\crSkillup ${start|\\cs(255,0,0)Stoped}')
        properties:append("\\crSkillup's Per Hour \\cs(255,255,0)${skill_ph|0}")
        properties:append("\\crTotal Skillup's \\cs(255,255,0)${skill_total|0}")
        text:clear()
        text:append(properties:concat('\n'))
    end
    if a == 'button' then
        local properties = L{}
        properties:append('${GEOc}')
        properties:append('${HELc}')
        properties:append('${ENHc}')
        properties:append('${NINc}')
        properties:append('${SINc}')
        properties:append('${BLUc}')
        properties:append('${SMNc}')
        properties:append('${STOPc}')
        properties:append('${DOWNc}')
        properties:append('${LOGc}')
        text:clear()
        text:append(properties:concat('\n'))
    end
end
function file_unload()
    if save_window_location then
        file_write()
    end
    window:destroy()
    button:destroy()
end
function status_change(new,old)
    if new=='Idle' then
        equip(sets.Idle)
        if skilluprun then
            if skilluptype[skillupcount] == "Geomancy" then
                send_command('wait 1.0;input /ma "'..geospells[geocount]..'" <me>')
            elseif skilluptype[skillupcount] == "Healing" then
                send_command('wait 1.0;input /ma "'..healingspells[healingcount]..'" <me>')
            elseif skilluptype[skillupcount] == "Enhancing" then
                send_command('wait 1.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
            elseif skilluptype[skillupcount] == "Ninjutsu" then
                send_command('wait 1.0;input /ma "'..ninspells[nincount]..'" <me>')
            elseif skilluptype[skillupcount] == "Singing" then
                send_command('wait 1.0;input /ma "'..songspells[songcount]..'" <me>')
            elseif skilluptype[skillupcount] == "Blue" then
                send_command('wait 1.0;input /ma "'..bluspells[blucount]..'" <me>')
            elseif skilluptype[skillupcount] == "Summoning" then
                send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
            end
        end
    end
end
function filtered_action(spell)
    if skilluprun then
        if spell.type == "Geomancy" then
            if skill['Geomancy Capped'] and skill['Handbell Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            cancel_spell()
            geocount = (geocount % #geospells) + 1
            send_command('input /ma "'..geospells[geocount]..'" <me>')
            return
        elseif spell.skill == "Healing Magic" then
            if skill['Healing Magic Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            cancel_spell()
            healingcount = (healingcount % #healingspells) + 1
            send_command('input /ma "'..healingspells[healingcount]..'" <me>')
            return
        elseif spell.skill == "Enhancing Magic" then
            if skill['Enhancing Magic Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            cancel_spell()
            enhancecount = (enhancecount % #enhancespells) + 1
            send_command('input /ma "'..enhancespells[enhancecount]..'" <me>')
            return
        elseif spell.skill == "Ninjutsu" then
            if skill['Ninjutsu Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            if not windower.ffxi.get_spells()[spell.id] then
                cancel_spell()
                nincount = (nincount % #ninspells) + 1
                send_command('input /ma "'..ninspells[nincount]..'" <me>')
                return
            elseif nin_tool_check(spell) then
                cancel_spell()
                last_nin = ninspells[nincount]
                send_command('input /item "'..nin_tool_open()..'" <me>')
            end
        elseif spell.skill == "Singing" then
            if skill['Singing Capped'] and skill['Stringed Instrument Capped'] and skill['Wind Instrument Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            cancel_spell()
            songcount = (songcount % #songspells) + 1
            send_command('input /ma "'..songspells[songcount]..'" <me>')
            return
        elseif spell.skill == "Blue Magic" then
            if skill['Blue Magic Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            cancel_spell()
            blucount = (blucount % #bluspells) + 1
            send_command('input /ma "'..bluspells[blucount]..'" <me>')
            return
        elseif spell.type == "SummonerPact" then
            if skill['Summoning Magic Capped'] then
                skilluprun = false
                send_command('wait 4.0;input /ja "Release" <me>')
                return
            end
            cancel_spell()
            smncount = (smncount % #smnspells) + 1
            send_command('input /ma "'..smnspells[smncount]..'" <me>')
            return
        elseif spell.english == "Unbridled Learning" then
            if skill['Blue Magic Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            cancel_spell()
            blucount = (blucount % #bluspells) + 1
            send_command('input /ma "'..bluspells[blucount]..'" <me>')
            return
        elseif spell.english == "Avatar's Favor" then
            if skill['Summoning Magic Capped'] then
                skilluprun = false
                send_command('wait 4.0;input /ja "Release" <me>')
                return
            end
            cancel_spell()
            send_command('input /ja "Release" <me>')
            return
        end
        return
    end
    cancel_spell()
end
function precast(spell) -- done
    if spell then
        if spell.mp_cost > player.mp then
            cancel_spell()
            send_command('input /heal on')
            return
        end
    end
    if skilluprun then
        if skilluptype[skillupcount] == "Healing" then
            if tonumber(windower.ffxi.get_spell_recasts()[spell.recast_id]) > 0 or not windower.ffxi.get_spells()[spell.id] then
                cancel_spell()
                healingcount = (healingcount % #healingspells) + 1
                send_command('input /ma "'..healingspells[healingcount]..'" <me>')
                return
            else
                healingcount = (healingcount % #healingspells) + 1
            end
        elseif skilluptype[skillupcount] == "Geomancy" then
            if tonumber(windower.ffxi.get_spell_recasts()[spell.recast_id]) > 0 or not windower.ffxi.get_spells()[spell.id] then
                cancel_spell()
                geocount = (geocount % #geospells) + 1
                send_command('input /ma "'..geospells[geocount]..'" <me>')
                return
            else
                geocount = (geocount % #geospells) + 1
            end
        elseif skilluptype[skillupcount] == "Enhancing" then
            if tonumber(windower.ffxi.get_spell_recasts()[spell.recast_id]) > 0 or not windower.ffxi.get_spells()[spell.id] then
                cancel_spell()
                enhancecount = (enhancecount % #enhancespells) + 1
                send_command('input /ma "'..enhancespells[enhancecount]..'" <me>')
                return
            else
                enhancecount = (enhancecount % #enhancespells) + 1
            end
        elseif skilluptype[skillupcount] == "Ninjutsu" then
            if tonumber(windower.ffxi.get_spell_recasts()[spell.recast_id]) > 0 or not windower.ffxi.get_spells()[spell.id] then
                cancel_spell()
                nincount = (nincount % #ninspells) + 1
                send_command('input /ma "'..ninspells[nincount]..'" <me>')
                return
            else
                nincount = (nincount % #ninspells) + 1
            end
        elseif skilluptype[skillupcount] == "Singing" then
            if not skill['Stringed Instrument Capped'] then
                equip(sets.brd.string)
            elseif not skill['Wind Instrument Capped'] then
                equip(sets.brd.wind)
            end
            if tonumber(windower.ffxi.get_spell_recasts()[spell.recast_id]) > 0 or not windower.ffxi.get_spells()[spell.id] then
                cancel_spell()
                songcount = (songcount % #songspells) + 1
                send_command('input /ma "'..songspells[songcount]..'" <me>')
                return
            else
                songcount = (songcount % #songspells) + 1
            end
        elseif skilluptype[skillupcount] == "Blue" then
            if spell.skill == "Blue Magic" then
                if tonumber(windower.ffxi.get_spell_recasts()[spell.recast_id]) > 0 or not windower.ffxi.get_spells()[spell.id] then
                    cancel_spell()
                    blucount = (blucount % #bluspells) + 1
                    send_command('input /ma "'..bluspells[blucount]..'" <me>')
                    return
                else
                    blucount = (blucount % #bluspells) + 1
                end
            elseif spell.english == "Unbridled Learning" then
                if bluspellul:contains(bluspells[blucount]) and not windower.ffxi.get_spells()[ulid[bluspells[blucount]]] then
                    if not buffactive["Unbridled Learning"] then
                        if (windower.ffxi.get_ability_recasts()[spell.recast_id] > 0) then
                            cancel_spell()
                            blucount = (blucount % #bluspells) + 1
                            send_command('input /ma "'..bluspells[blucount]..'" <me>')
                            return
                        end
                    end
                else
                    cancel_spell()
                    blucount = (blucount % #bluspells) + 1
                    send_command('input /ma "'..bluspells[blucount]..'" <me>')
                    return
                end
            end
        elseif skilluptype[skillupcount] == "Summoning" then
            if spell.type == "SummonerPact" then
                if tonumber(windower.ffxi.get_spell_recasts()[spell.recast_id]) > 0 or not windower.ffxi.get_spells()[spell.id] then
                    cancel_spell()
                    smncount = (smncount % #smnspells) + 1
                    send_command('input /ma "'..smnspells[smncount]..'" <me>')
                    return
                else
                    smncount = (smncount % #smnspells) + 1
                end
            elseif spell.english == "Avatar's Favor" then
                if (windower.ffxi.get_ability_recasts()[spell.recast_id] > 0) or buffactive["Avatar's Favor"] then
                    cancel_spell()
                    send_command('input /ja "Release" <me>')
                    return
                end
            elseif spell.english == "Elemental Siphon" then
                if (windower.ffxi.get_ability_recasts()[spell.recast_id] > 0) or player.mpp > 75 then
                cancel_spell()
                send_command('input /ja "Release" <me>')
                return
                end
            elseif spell.english == "Release" then
                if not pet.isvalid then
                    cancel_spell()
                    send_command('input /heal on')
                    return
                end
                local recast = windower.ffxi.get_ability_recasts()[spell.recast_id]
                if (recast > 0) then
                    cancel_spell()
                    send_command('wait '..tostring(recast+0.5)..';input /ja "Release" <me>')
                    return
                end
            end
        end
        return
    elseif spell.english == "Release" then
        local recast = windower.ffxi.get_ability_recasts()[spell.recast_id]
        if (recast > 0) then
            cancel_spell()
            send_command('wait '..tostring(recast+0.5)..';input /ja "Release" <me>')
            return
        end
        return
    end
end
function aftercast(spell)
    if skilluprun then
        if spell.interrupted then
            if skilluptype[skillupcount] == "Geomancy" then
                send_command('wait 3.0;input /ma "'..geospells[geocount]..'" <me>')
            elseif skilluptype[skillupcount] == "Healing" then
                send_command('wait 3.0;input /ma "'..healingspells[healingcount]..'" <me>')
            elseif skilluptype[skillupcount] == "Enhancing" then
                send_command('wait 3.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
            elseif skilluptype[skillupcount] == "Ninjutsu" then
                send_command('wait 3.0;input /ma "'..ninspells[nincount]..'" <me>')
            elseif skilluptype[skillupcount] == "Singing" then
                send_command('wait 3.0;input /ma "'..songspells[songcount]..'" <me>')
            elseif skilluptype[skillupcount] == "Blue" then
                send_command('wait 3.5;input /ja "Unbridled Learning" <me>')
            elseif skilluptype[skillupcount] == "Summoning" then
                send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
            end
            return
        end
        if skilluptype[skillupcount] == "Geomancy" then
            if skill['Geomancy Capped'] and skill['Handbell Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            send_command('wait 3.0;input /ma "'..geospells[geocount]..'" <me>')
        elseif skilluptype[skillupcount] == "Healing" then
            if skill['Healing Magic Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            send_command('wait 3.0;input /ma "'..healingspells[healingcount]..'" <me>')
        elseif skilluptype[skillupcount] == "Enhancing" then
            if skill['Enhancing Magic Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            send_command('wait 3.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
        elseif skilluptype[skillupcount] == "Ninjutsu" then
            if skill['Ninjutsu Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            elseif spell.type == 'Item' and spell.english == tbid then
                send_command('wait 1.0;input /ma "'..last_nin..'" <me>')
                tbid = 'none'
            end
            send_command('wait 3.0;input /ma "'..ninspells[nincount]..'" <me>')
        elseif skilluptype[skillupcount] == "Singing" then
            if skill['Singing Capped'] and skill['Stringed Instrument Capped'] and skill['Wind Instrument Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            end
            send_command('wait 3.0;input /ma "'..songspells[songcount]..'" <me>')
        elseif skilluptype[skillupcount] == "Blue" then
            if skill['Blue Magic Capped'] then
                skilluprun = false
                shutdown_logoff()
                return
            elseif spell.english == "Unbridled Learning" then
                send_command('wait 1.0;input /ma "'..bluspells[blucount]..'" <me>')
                return
            end
            send_command('wait 4.0;input /ja "Unbridled Learning" <me>')
        elseif skilluptype[skillupcount] == "Summoning" then
            if skill['Summoning Magic Capped'] then
                skilluprun = false
                send_command('wait 4.0;input /ja "Release" <me>')
                return
            end
            if spell.type == "SummonerPact" then
                if spell.english:contains('Spirit') and (spell.element == world.weather_element or spell.element == world.day_element)then
                    send_command('wait 4.0;input /ja "Elemental Siphon" <me>')
                elseif not spell.english:contains('Spirit') then
                    send_command('wait 4.0;input /ja "Avatar\'s Favor" <me>')
                else
                    send_command('wait 0.5; input /ja "Release" <me>')
                end
                return
            elseif spell.english == "Release" then
                if spell.interrupted then
                    send_command('wait 0.5; input /ja "Release" <me>')
                    return
                end
            elseif spell.english == "Avatar's Favor" then
                send_command('wait 1.0;input /ja "Release" <me>')
                return
            elseif spell.english == "Elemental Siphon" then
                send_command('wait 1.0;input /ja "Release" <me>')
                return
            end
            send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
        end
        return
    elseif spell.type == "SummonerPact" then
        if skill['Summoning Magic Capped'] then
            skilluprun = false
            send_command('wait 4.0;input /ja "Release" <me>')
            return
        end
    elseif spell.english == "Release" then
        if skill['Summoning Magic Capped'] then
            shutdown_logoff()
        end
    elseif spell.english == "Avatar's Favor" then
        send_command('wait 1.0;input /ja "Release" <me>')
    end
end
function self_command(command)
    if command == "startgeo" then
        skilluprun = true
        skillupcount = 2
        send_command('wait 1.0;input /ma "'..geospells[geocount]..'" <me>')
        initialize(window, box, 'window')
    elseif command == "starthealing" then
        skilluprun = true
        skillupcount = 1
        send_command('wait 1.0;input /ma "'..healingspells[healingcount]..'" <me>')
        initialize(window, box, 'window')
    elseif command == "startenhancing" then
        skilluprun = true
        skillupcount = 3
        send_command('wait 1.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
        initialize(window, box, 'window')
    elseif command == "startninjutsu" then
        skilluprun = true
        skillupcount = 4
        send_command('wait 1.0;input /ma "'..ninspells[nincount]..'" <me>')
        initialize(window, box, 'window')
    elseif command == "startsinging" then
        skilluprun = true
        skillupcount = 5
        send_command('wait 1.0;input /ma "'..songspells[songcount]..'" <me>')
        initialize(window, box, 'window')
    elseif command == "startblue" then
        skilluprun = true
        skillupcount = 6
        send_command('wait 1.0;input /ma "'..bluspells[blucount]..'" <me>')
        initialize(window, box, 'window')
    elseif command == "startsmn" then
        skilluprun = true
        skillupcount = 7
        send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
        initialize(window, box, 'window')
    elseif command == "skillstop" then
        skilluprun = false
    elseif command == 'aftershutdown' then
        stoptype = "Shutdown"
        shutdown = true
        logoff = false
        initialize(window, box, 'window')
    elseif command == 'afterlogoff' then
        stoptype = "Logoff"
        shutdown = false
        logoff = true
        initialize(window, box, 'window')
    elseif command == 'afterStop' then
        stoptype = "Stop"
        shutdown = false
        logoff = false
        initialize(window, box, 'window')
    end
    updatedisplay()
end
function shutdown_logoff()
    add_to_chat(123,"Auto stop skillup")
    if logoff then
        send_command('wait 3.0;input /logout')
    elseif shutdown then
        send_command('wait 3.0;input /shutdown')
    end
    initialize(window, box, 'window')
    updatedisplay()
end
function nin_tool_check(spell)
    if (player.inventory[nin_tools[spell.english].tool] == nil  or player.inventory[nin_tools[spell.english].uni_tool] == nil) 
    and (player.inventory[nin_tools[spell.english].tool_bag] ~= nil or player.inventory[nin_tools[spell.english].uni_tool_bag] ~= nil) then
        return true
    else
        add_to_chat(7,"No Tools Available To Cast "..spell.english)
    end
end
function nin_tool_open()
    if nincantcount ~= #ninspells and not nincant:contains(spell.english) then
        if player.inventory[nin_tools[spell.english].tool_bag] ~= nil then
            tbid = nin_tools[spell.english].tool_bag
            return nin_tools[spell.english].tool_bag
        elseif player.inventory[nin_tools[spell.english].uni_tool_bag] ~= nil then
            tbid = nin_tools[spell.english].uni_tool_bag
            return nin_tools[spell.english].uni_tool_bag
        else
            nincant:append(spell.english)
            nincantcount = nincantcount +1
        end
    elseif nincantcount ~= #ninspells then
        cancel_spell()
        nincount = (nincount % #ninspells) + 1
        send_command('input /ma "'..ninspells[nincount]..'" <me>')
        return
    else
        skilluprun = false
        cancel_spell()
        add_to_chat(7,"No Tools Available To Cast Any Ninjutsu")
    end
end
function skill_capped(id, data, modified, injected, blocked)
    if id == 0x062 then
        local packet = packets.parse('incoming', data)
        skill = packet
        updatedisplay()
    end
    if id == 0x0DF and skilluprun then
        if data:unpack('I', 0x0D) == player.max_mp and skilluprun then
            windower.send_command('input /heal off')
        end
    end
end
windower.raw_register_event('incoming chunk', skill_capped)
function updatedisplay()
    local info = {}
        info.mode = skilluptype[skillupcount]
        info.modeb = skilluprun and info.mode or 'None'
        info.start = (skilluprun and '\\cs(0,255,0)Started' or '\\cs(255,0,0)Stoped')
        info.skillssing = (skill['Singing Capped'] and "Capped" or skill['Singing Level'])
        info.skillstring = (skill['Stringed Instrument Capped'] and "Capped" or skill['Stringed Instrument Level'])
        info.skillwind = (skill['Wind Instrument Capped'] and "Capped" or skill['Wind Instrument Level'])
        info.skillgeo = (skill['Geomancy Capped'] and "Capped" or skill['Geomancy Level'])
        info.skillbell = (skill['Handbell Capped'] and "Capped" or skill['Handbell Level'])
        info.skill = {}
        info.skill.Healing = (skill['Healing Magic Capped'] and "Capped" or skill['Healing Magic Level'])
        info.skill.Enhancing = (skill['Enhancing Magic Capped'] and "Capped" or skill['Enhancing Magic Level'])
        info.skill.Summoning = skill['Summoning Magic Level']
        info.skill.Ninjutsu = (skill['Ninjutsu Capped'] and "Capped" or skill['Ninjutsu Level'])
        info.skill.Blue = (skill['Blue Magic Capped'] and "Capped" or skill['Blue Magic Level'])
        info.skillbulk = info.skill[info.mode]
        info.type = stoptype
        info.skill_ph = (get_rate(skill_ups) or 0) / 10
        info.skill_total = (total_skill_ups or 0) / 10
        info.GEOc = (color_GEO and 'Start GEO' or '\\cs(255,0,0)Start GEO\\cr')
        info.HELc = (color_HEL and 'Start Healing' or '\\cs(255,0,0)Start Healing\\cr')
        info.ENHc = (color_ENH and 'Start Enhancing' or '\\cs(255,0,0)Start Enhancing\\cr')
        info.NINc = (color_NIN and 'Start Ninjutsu' or '\\cs(255,0,0)Start Ninjutsu\\cr')
        info.SINc = (color_SIN and 'Start Singing' or '\\cs(255,0,0)Start Singing\\cr')
        info.BLUc = (color_BLU and 'Start Blue Magic' or '\\cs(255,0,0)Start Blue Magic\\cr')
        info.SMNc = (color_SMN and 'Start Summoning Magic' or '\\cs(255,0,0)Start Summoning Magic\\cr')
        info.STOPc = (color_STOP and 'Stop Skillups' or '\\cs(255,0,0)Stop Skillups\\cr')
        info.DOWNc = (color_DOWN and 'Shutdown After Skillup' or '\\cs(255,0,0)Shutdown After Skillup\\cr')
        info.LOGc = (color_LOG and  'Logoff After Skillup' or '\\cs(255,0,0)Logoff After Skillup')
        window:update(info)
        window:show()
        button:update(info)
        button:show()
end
function file_write()
    if not windower.dir_exists(lua_base_path..'data/'..player.name..'/Saves') then
        windower.create_dir(lua_base_path..'data/'..player.name..'/Saves')
    end
    local file = io.open(lua_base_path..'data/'..player.name..'/Saves/skillup_data.lua',"w")
    file:write(
        'box.pos.x = '..tostring(box.pos.x)..
        '\nbox.pos.y = '..tostring(box.pos.y)..
        '\nboxa.pos.x = '..tostring(box.pos.x)..
        '\nboxa.pos.y = '..tostring(box.pos.y)..
        '')
    file:close() 
end
function set_color(name)
    for i, v in pairs(_G) do
        if string.contains(i, "color_") then
            if i == ("color_"..name) then
                _G[i] = false
            else
                _G[i] = true
            end
        end
    end
end
function mouse(type, x, y, delta, blocked)
    local mx, my = texts.extents(button)
    local button_lines = button:text():count('\n') + 1 
    local hx = (x - boxa.pos.x)
    local hy = (y - boxa.pos.y)
    local location = {}
    location.offset = my / button_lines
    location[1] = {}
    location[1].ya = 1
    location[1].yb = location.offset
    local count = 2
    while count <= button_lines do
         location[count] = {}
         location[count].ya = location[count - 1].yb
         location[count].yb = location[count - 1].yb + location.offset
         count = count + 1
    end
    if type == 0 then
        if window:hover(x, y) and window:visible() then
            button:pos((box.pos.x - mx), box.pos.y)
        elseif button:hover(x, y) and button:visible() then
            window:pos((boxa.pos.x + mx), boxa.pos.y)
            for i, v in ipairs(location) do
                local switch = {[1]="GEO",[2]="HEL",[3]="ENH",[4]="NIN",[5]="SIN",[6]="BLU",[7]="SMN",[8]="STOP",[9]="DOWN",[10]="LOG"}
                if hy > location[i].ya and hy < location[i].yb then
                    set_color(switch[i])
                    updatedisplay()
                end
            end
        else
            set_color("none")
            updatedisplay()
            return
        end
    elseif type == 2 then
        if button:hover(x, y) and button:visible() then
            for i, v in ipairs(location) do
                local switchb = {[1]="startgeo",[2]="starthealing",[3]="startenhancing",[4]="startninjutsu",[5]="startsinging",[6]="startblue",[7]="startsmn",[8]="skillstop",[9]="aftershutdown",[10]="afterlogoff"}
                if hy > location[i].ya and hy < location[i].yb then
                    send_command("gs c "..switchb[i])
                    updatedisplay()
                end
            end
        end
    end
end
windower.raw_register_event('mouse', mouse)

function action_message(actor_id, target_id, actor_index, target_index, message_id, param_1, param_2, param_3)
    if message_id == 38 and target_id == player.id then
        local ts = os.clock()
        total_skill_ups = total_skill_ups + param_2
        skill_ups[ts] = param_2
    end
    updatedisplay()
end
windower.raw_register_event('action message', action_message)
function get_rate(tab)
    local t = os.clock()
    local running_total = 0
    for ts,points in pairs(tab) do
        local time_diff = t - ts
        if t - ts > 3600 then
            tab[ts] = nil
        else
            running_total = running_total + points
        end
    end
    return running_total
end
windower.raw_register_event('prerender',function()
    if frame_count%30 == 0 and window:visible() then
        updatedisplay()
    end
    frame_count = frame_count + 1
end)