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
-- Debug mode (default: false)
debugmode = false
require 'actions'
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
boxa.pos.x = box.pos.x - 139
boxa.pos.y = box.pos.y
boxa.text = {}
boxa.text.font = 'Dotum'
boxa.text.size = 9
boxa.bg = {}
boxa.bg.alpha = 255
skill_ups = {}
total_skill_ups = 0
skill = {}
if gearswap.pathsearch({'Saves/skillup_data.lua'}) then
	include('Saves/skillup_data.lua')
end
window = texts.new(box)
test = texts.new(boxa)
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
		["Monomi: Ichi"] = {tool='Sanjaku-Tenugui',tool_bag="Toolbag (Sanja)",tool_bag_id=5417,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Aisha: Ichi"] = {tool='Soshi',tool_bag="Toolbag (Soshi)",tool_bag_id=5734,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Katon: Ichi"] = {tool='Uchitake',tool_bag="Toolbag (Uchi)",tool_bag_id=5308,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Katon: Ni"] = {tool='Uchitake',tool_bag="Toolbag (Uchi)",tool_bag_id=5308,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Katon: San"] = {tool='Uchitake',tool_bag="Toolbag (Uchi)",tool_bag_id=5308,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Hyoton: Ichi"] = {tool='Tsurara',tool_bag="Toolbag (Tsura)",tool_bag_id=5309,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Hyoton: Ni"] = {tool='Tsurara',tool_bag="Toolbag (Tsura)",tool_bag_id=5309,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Hyoton: San"] = {tool='Tsurara',tool_bag="Toolbag (Tsura)",tool_bag_id=5309,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Huton: Ichi"] = {tool='Kawahori-Ogi',tool_bag="Toolbag (Kawa)",tool_bag_id=5310,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Huton: Ni"] = {tool='Kawahori-Ogi',tool_bag="Toolbag (Kawa)",tool_bag_id=5310,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Huton: San"] = {tool='Kawahori-Ogi',tool_bag="Toolbag (Kawa)",tool_bag_id=5310,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Doton: Ichi"] = {tool='Makibishi',tool_bag="Toolbag (Maki)",tool_bag_id=5311,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Doton: Ni"] = {tool='Makibishi',tool_bag="Toolbag (Maki)",tool_bag_id=5311,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Doton: San"] = {tool='Makibishi',tool_bag="Toolbag (Maki)",tool_bag_id=5311,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Raiton: Ichi"] = {tool='Hiraishin',tool_bag="Toolbag (Hira)",tool_bag_id=5312,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Raiton: Ni"] = {tool='Hiraishin',tool_bag="Toolbag (Hira)",tool_bag_id=5312,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Raiton: San"] = {tool='Hiraishin',tool_bag="Toolbag (Hira)",tool_bag_id=5312,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Suiton: Ichi"] = {tool='Mizu-Deppo',tool_bag="Toolbag (Mizu)",tool_bag_id=5313,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Suiton: Ni"] = {tool='Mizu-Deppo',tool_bag="Toolbag (Mizu)",tool_bag_id=5313,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Suiton: San"] = {tool='Mizu-Deppo',tool_bag="Toolbag (Mizu)",tool_bag_id=5313,uni_tool="Inoshishinofuda",uni_tool_bag="Toolbag (Ino)",uni_tool_bag_id=5867},
		["Utsusemi: Ichi"] = {tool='Shihei',tool_bag="Toolbag (Shihe)",tool_bag_id=5314,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Utsusemi: Ni"] = {tool='Shihei',tool_bag="Toolbag (Shihe)",tool_bag_id=5314,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Utsusemi: San"] = {tool='Shihei',tool_bag="Toolbag (Shihe)",tool_bag_id=5314,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Jubaku: Ichi"] = {tool='Jusatsu',tool_bag="Toolbag (Jusa)",tool_bag_id=5315,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Jubaku: Ni"] = {tool='Jusatsu',tool_bag="Toolbag (Jusa)",tool_bag_id=5315,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Jubaku: San"] = {tool='Jusatsu',tool_bag="Toolbag (Jusa)",tool_bag_id=5315,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Hojo: Ichi"] = {tool='Kaginawa',tool_bag="Toolbag (Kagi)",tool_bag_id=5316,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Hojo: Ni"] = {tool='Kaginawa',tool_bag="Toolbag (Kagi)",tool_bag_id=5316,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Hojo: San"] = {tool='Kaginawa',tool_bag="Toolbag (Kagi)",tool_bag_id=5316,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Kurayami: Ichi"] = {tool='Sairui-Ran',tool_bag="Toolbag (Sai)",tool_bag_id=5317,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Kurayami: Ni"] = {tool='Sairui-Ran',tool_bag="Toolbag (Sai)",tool_bag_id=5317,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Kurayami: San"] = {tool='Sairui-Ran',tool_bag="Toolbag (Sai)",tool_bag_id=5317,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Dokumori: Ichi"] = {tool='Kodoku',tool_bag="Toolbag (Kodo)",tool_bag_id=5318,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Dokumori: Ni"] = {tool='Kodoku',tool_bag="Toolbag (Kodo)",tool_bag_id=5318,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Dokumori: San"] = {tool='Kodoku',tool_bag="Toolbag (Kodo)",tool_bag_id=5318,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Tonko: Ichi"] = {tool='Shinobi-Tabi',tool_bag="Toolbag (Shino)",tool_bag_id=5319,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Tonko: Ni"] = {tool='Shinobi-Tabi',tool_bag="Toolbag (Shino)",tool_bag_id=5319,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Tonko: San"] = {tool='Shinobi-Tabi',tool_bag="Toolbag (Shino)",tool_bag_id=5319,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Gekka: Ichi"] = {tool='Ranka',tool_bag="Toolbag (Ranka)",tool_bag_id=6265,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Yain: Ichi"] = {tool='Furusumi',tool_bag="Toolbag (Furu)",tool_bag_id=6266,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Myoshu: Ichi"] = {tool='Kabenro',tool_bag="Toolbg. (Kaben)",tool_bag_id=5863,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Yurin: Ichi"] = {tool='Jinko',tool_bag="Toolbag (Jinko)",tool_bag_id=5864,uni_tool="Chonofuda",uni_tool_bag="Toolbag (Cho)",uni_tool_bag_id=5869},
		["Kakka: Ichi"] = {tool='Ryuno',tool_bag="Toolbag (Ryuno)",tool_bag_id=5865,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
		["Migawari: Ichi"] = {tool='Mokujin',tool_bag="Toolbag (Moku)",tool_bag_id=5866,uni_tool="Shikanofuda",uni_tool_bag="Toolbag (Shika)",uni_tool_bag_id=5868},
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
	frame_count = 0
	initialize(window, box, 'window')
	initialize(test, boxa, 'test')
	window:show()
	test:show()
end
function initialize(text, settings, a)
	if debugmode then
		add_to_chat(7,"1")
	end
	if a == 'window' then
		local properties = L{}
		properties:append('--Skill Up--')
		properties:append('Mode :\n   ${mode|None}')
		if skilluptype[skillupcount] == 'Singing' then
			properties:append('\\cs(255,255,255)Current Singing Skill LVL:\n   ${skillssing|0}')
			properties:append('\\cs(255,255,255)Current String Skill LVL:\n   ${skillstring|0}')
			properties:append('\\cs(255,255,255)Current Wind Skill LVL:\n   ${skillwind|0}')
		elseif skilluptype[skillupcount] == 'Geomancy' then
			properties:append('\\cs(255,255,255)Current Geomancy Skill LVL:\n   ${skillgeo|0}')
			properties:append('\\cs(255,255,255)Current Handbell Skill LVL:\n   ${skillbell|0}')
		else
			properties:append('\\cs(255,255,255)Current Skilling LVL:\n   ${skillbulk|0}')
		end
		if shutdown then
			properties:append('\\cs(255,255,255)Will Shutdown When Skillup Done')
		elseif logoff then
			properties:append('\\cs(255,255,255)Will Logoff When Skillup Done')
		else
			properties:append('\\cs(255,255,255)Will Stop When Skillup Done')
		end
		properties:append('\\cs(255,255,255)Skillup ${start|\\cs(255,0,0)Stoped}')
		properties:append("\\cs(255,255,255)Skillup's Per Hour \\cs(255,255,0)${skill_ph|0}")
		properties:append("\\cs(255,255,255)Total Skillup's \\cs(255,255,0)${skill_total|0}")
		text:clear()
		text:append(properties:concat('\n'))
	end
	if a == 'test' then
		local properties = L{}
		properties:append('Start GEO')
		properties:append('Start Healing')
		properties:append('Start Enhancing')
		properties:append('Start Ninjutsu')
		properties:append('Start Singing')
		properties:append('Start Blue Magic')
		properties:append('Start Summoning Magic')
		properties:append('Stop Skillups')
		properties:append('Shutdown After Skillup')
		properties:append('Logoff After Skillup')
		text:clear()
		text:append(properties:concat('\n'))
	end
end
function file_unload()
	--file_write()
    window:destroy()
    test:destroy()
end
function status_change(new,old)
	if debugmode then
		add_to_chat(7,"2")
	end
	if new=='Idle' then
		equip(sets.Idle)
		if skilluptype[skillupcount] == "Geomancy" and skilluprun then
			send_command('wait 1.0;input /ma "'..geospells[geocount]..'" <me>')
		elseif skilluptype[skillupcount] == "Healing" and skilluprun then
			send_command('wait 1.0;input /ma "'..healingspells[healingcount]..'" <me>')
		elseif skilluptype[skillupcount] == "Enhancing" and skilluprun then
			send_command('wait 1.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
		elseif skilluptype[skillupcount] == "Ninjutsu" and skilluprun then
			send_command('wait 1.0;input /ma "'..ninspells[nincount]..'" <me>')
		elseif skilluptype[skillupcount] == "Singing" and skilluprun then
			send_command('wait 1.0;input /ma "'..songspells[songcount]..'" <me>')
		elseif skilluptype[skillupcount] == "Blue" and skilluprun then
			send_command('wait 1.0;input /ma "'..bluspells[blucount]..'" <me>')
		elseif skilluptype[skillupcount] == "Summoning" and skilluprun then
			send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
		end
	end
end
function filtered_action(spell)
	if debugmode then
		add_to_chat(7,"3")
	end
	if spell.type == "Geomancy" and skilluprun then
		cancel_spell()
		geocount = (geocount % #geospells) + 1
		send_command('input /ma "'..geospells[geocount]..'" <me>')
		return
	elseif spell.skill == "Healing Magic" and skilluprun then
		cancel_spell()
		healingcount = (healingcount % #healingspells) + 1
		send_command('input /ma "'..healingspells[healingcount]..'" <me>')
		return
	elseif spell.skill == "Enhancing Magic" and skilluprun then
		cancel_spell()
		enhancecount = (enhancecount % #enhancespells) + 1
		send_command('input /ma "'..enhancespells[enhancecount]..'" <me>')
		return
	elseif spell.skill == "Ninjutsu" and skilluprun then
		if not windower.ffxi.get_spells()[spell.id] then
			cancel_spell()
			nincount = (nincount % #ninspells) + 1
			send_command('input /ma "'..ninspells[nincount]..'" <me>')
			return
		end
		if nin_tool_check(spell) then
			cancel_spell()
			send_command('input /item "'..nin_tool_open()..'" <me>')
		end
	elseif spell.skill == "Singing" and skilluprun then
		cancel_spell()
		songcount = (songcount % #songspells) + 1
		send_command('input /ma "'..songspells[songcount]..'" <me>')
		return
	elseif spell.skill == "Blue Magic" and skilluprun then
		cancel_spell()
		blucount = (blucount % #bluspells) + 1
		send_command('input /ma "'..bluspells[blucount]..'" <me>')
		return
	elseif spell.type == "SummonerPact" and skilluprun then
		cancel_spell()
		smncount = (smncount % #smnspells) + 1
		send_command('input /ma "'..smnspells[smncount]..'" <me>')
		return
	elseif spell.name == "Unbridled Learning" then
		cancel_spell()
		blucount = (blucount % #bluspells) + 1
		send_command('input /ma "'..bluspells[blucount]..'" <me>')
		return
	elseif spell.name == "Avatar's Favor" then
			cancel_spell()
			send_command('input /ja "Release" <me>')
			return
	end
end
function precast(spell)
	if debugmode then
		add_to_chat(7,"4")
	end
	if spell then
		if spell.mp_cost > player.mp then
			cancel_spell()
			send_command('input /heal on')
			return
		end
	end
	if spell.type == "Geomancy" and skilluprun then
		if not windower.ffxi.get_spells()[spell.id] then
			cancel_spell()
			geocount = (geocount % #geospells) + 1
			send_command('input /ma "'..geospells[geocount]..'" <me>')
			return
		else
			geocount = (geocount % #geospells) + 1
		end
	elseif spell.skill == "Healing Magic" and skilluprun then
		if not windower.ffxi.get_spells()[spell.id] then
			cancel_spell()
			healingcount = (healingcount % #healingspells) + 1
			send_command('input /ma "'..healingspells[healingcount]..'" <me>')
			return
		else
			healingcount = (healingcount % #healingspells) + 1
		end
	elseif spell.skill == "Enhancing Magic" and skilluprun then
		if not windower.ffxi.get_spells()[spell.id] then
			cancel_spell()
			enhancecount = (enhancecount % #enhancespells) + 1
			send_command('input /ma "'..enhancespells[enhancecount]..'" <me>')
			return
		else
			enhancecount = (enhancecount % #enhancespells) + 1
		end
	elseif spell.skill == "Ninjutsu" and skilluprun then
		if not windower.ffxi.get_spells()[spell.id] then
			cancel_spell()
			nincount = (nincount % #ninspells) + 1
			send_command('input /ma "'..ninspells[nincount]..'" <me>')
			return
		else
			nincount = (nincount % #ninspells) + 1
		end
	elseif spell.skill == "Singing" and skilluprun then
		if not skill['Stringed Instrument Capped'] then
			equip(sets.brd.string)
		elseif not skill['Wind Instrument Capped'] then
			equip(sets.brd.wind)
		end
		if not windower.ffxi.get_spells()[spell.id] then
			cancel_spell()
			songcount = (songcount % #songspells) + 1
			send_command('input /ma "'..songspells[songcount]..'" <me>')
			return
		else
			songcount = (songcount % #songspells) + 1
		end
	elseif spell.skill == "Blue Magic" and skilluprun then
		if not windower.ffxi.get_spells()[spell.id] then
			cancel_spell()
			blucount = (blucount % #bluspells) + 1
			send_command('input /ma "'..bluspells[blucount]..'" <me>')
			return
		else
			blucount = (blucount % #bluspells) + 1
		end
	elseif spell.type == "SummonerPact" and skilluprun then
		if not windower.ffxi.get_spells()[spell.id] then
			cancel_spell()
			smncount = (smncount % #smnspells) + 1
			send_command('input /ma "'..smnspells[smncount]..'" <me>')
			return
		else
			smncount = (smncount % #smnspells) + 1
		end
	end
	if spell.name == "Avatar's Favor" then
		if (windower.ffxi.get_ability_recasts()[spell.recast_id] > 0) or buffactive["Avatar's Favor"] then
			cancel_spell()
			send_command('input /ja "Release" <me>')
			return
		end
	elseif spell.name == "Elemental Siphon" then
		if (windower.ffxi.get_ability_recasts()[spell.recast_id] > 0) or player.mpp > 75 then
			cancel_spell()
			send_command('input /ja "Release" <me>')
			return
		end
	elseif spell.name == "Unbridled Learning" then
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
	if spell.name == "Release" then
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
function aftercast(spell)
	if debugmode then
		add_to_chat(7,"5")
	end
	if skilluprun then
		if spell.interrupted then
			if spell.type == "Geomancy" then
				send_command('wait 3.0;input /ma "'..geospells[geocount]..'" <me>')
			elseif spell.skill == "Healing Magic" then
				send_command('wait 3.0;input /ma "'..healingspells[healingcount]..'" <me>')
			elseif spell.skill == "Enhancing Magic" then
				send_command('wait 3.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
			elseif spell.skill == "Ninjutsu" then
				send_command('wait 3.0;input /ma "'..ninspells[nincount]..'" <me>')
			elseif spell.skill == "Singing" then
				send_command('wait 3.0;input /ma "'..songspells[songcount]..'" <me>')
			elseif spell.skill == "Blue Magic" then
				send_command('wait 3.5;input /ja "Unbridled Learning" <me>')
			elseif spell.type == "SummonerPact" then
				send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
			end
			return
		end
		if spell.type == "Geomancy" then
			if skill['Geomancy Capped'] and skill['Handbell Capped'] then
				skilluprun = false
				shutdown_logoff()
				return
			end
			send_command('wait 3.0;input /ma "'..geospells[geocount]..'" <me>')
		elseif spell.skill == "Healing Magic" then
			if skill['Healing Magic Capped'] then
				skilluprun = false
				shutdown_logoff()
				return
			end
			send_command('wait 3.0;input /ma "'..healingspells[healingcount]..'" <me>')
		elseif spell.skill == "Enhancing Magic" then
			if skill['Enhancing Magic Capped'] then
				skilluprun = false
				shutdown_logoff()
				return
			end
			send_command('wait 3.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
		elseif spell.skill == "Ninjutsu" then
			if skill['Ninjutsu Capped'] then
				skilluprun = false
				shutdown_logoff()
				return
			end
			send_command('wait 3.0;input /ma "'..ninspells[nincount]..'" <me>')
		elseif spell.skill == "Singing" then
			if skill['Singing Capped'] and skill['Stringed Instrument Capped'] and skill['Wind Instrument Capped'] then
				skilluprun = false
				shutdown_logoff()
				return
			end
			send_command('wait 3.0;input /ma "'..songspells[songcount]..'" <me>')
		elseif spell.skill == "Blue Magic" then
			if skill['Blue Magic Capped'] then
				skilluprun = false
				shutdown_logoff()
				return
			end
			send_command('wait 3.5;input /ja "Unbridled Learning" <me>')
		elseif spell.type == "SummonerPact" then
			if skill['Summoning Magic Capped'] then
				skilluprun = false
				send_command('wait 4.0;input /ja "Release" <me>')
				return
			end
			if spell.name:contains('Spirit') and (spell.element == world.weather_element or spell.element == world.day_element)then
				send_command('wait 4.0;input /ja "Elemental Siphon" <me>')
			else
				send_command('wait 4.0;input /ja "Avatar\'s Favor" <me>')
			end
		elseif spell.name == "Release" then
			if spell.interrupted then
				send_command('wait 0.5; input /ja "Release" <me>')
				return
			end
			send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
		elseif spell.name == "Avatar's Favor" then
			send_command('wait 1.0;input /ja "Release" <me>')
		elseif spell.name == "Elemental Siphon" then
			send_command('wait 1.0;input /ja "Release" <me>')
		elseif spell.name == "Unbridled Learning" then
			send_command('wait 1.0;input /ma "'..bluspells[blucount]..'" <me>')
		end
	elseif spell.type == "SummonerPact" then
		if skill['Summoning Magic Capped'] then
			skilluprun = false
			send_command('wait 4.0;input /ja "Release" <me>')
			return
		end
		if spell.name:contains('Spirit') then
			send_command('wait 4.0;input /ja "Elemental Siphon" <me>')
		else
			send_command('wait 4.0;input /ja "Avatar\'s Favor" <me>')
		end
	elseif spell.name == "Release" then
		if skill['Summoning Magic Capped'] then
			shutdown_logoff()
			return
		end
		if pet.isvalid then
			if spell.interrupted then
				send_command('wait 0.5; input /ja "Release" <me>')
				return
			end
		end
	elseif spell.name == "Avatar's Favor" then
		send_command('wait 1.0;input /ja "Release" <me>')
	end
end
function self_command(command)
	if debugmode then
		add_to_chat(7,"6")
	end
	if command == "startgeo" then
		skilluprun = true
		skillupcount = 2
		send_command('wait 1.0;input /ma "'..geospells[geocount]..'" <me>')
		initialize(window, box, 'window')
	end
	if command == "starthealing" then
		skilluprun = true
		skillupcount = 1
		send_command('wait 1.0;input /ma "'..healingspells[healingcount]..'" <me>')
		initialize(window, box, 'window')
	end
	if command == "startenhancing" then
		skilluprun = true
		skillupcount = 3
		send_command('wait 1.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
		initialize(window, box, 'window')
	end
	if command == "startninjutsu" then
		skilluprun = true
		skillupcount = 4
		send_command('wait 1.0;input /ma "'..ninspells[nincount]..'" <me>')
		initialize(window, box, 'window')
	end
	if command == "startsinging" then
		skilluprun = true
		skillupcount = 5
		send_command('wait 1.0;input /ma "'..songspells[songcount]..'" <me>')
		initialize(window, box, 'window')
	end
	if command == "startblue" then
		skilluprun = true
		skillupcount = 6
		send_command('wait 1.0;input /ma "'..bluspells[blucount]..'" <me>')
		initialize(window, box, 'window')
	end
	if command == "startsmn" then
		skilluprun = true
		skillupcount = 7
		send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
		initialize(window, box, 'window')
	end
	if command == "skillstop" then
		skilluprun = false
		initialize(window, box, 'window')
	end
	if command == 'aftershutdown' then
		stoptype = "Shutdown"
		shutdown = true
		logoff = false
		initialize(window, box, 'window')
	end
	if command == 'afterlogoff' then
		stoptype = "Logoff"
		shutdown = false
		logoff = true
		initialize(window, box, 'window')
	end
	if command == 'afterStop' then
		stoptype = "Stop"
		shutdown = false
		logoff = false
		initialize(window, box, 'window')
	end
	updatedisplay()
end
function shutdown_logoff()
	if debugmode then
		add_to_chat(7,"7")
	end
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
	if debugmode then
		add_to_chat(7,"8")
	end
	if (player.inventory[nin_tools[spell.name].tool] == nil  or player.inventory[nin_tools[spell.name].uni_tool] == nil) 
	and (player.inventory[nin_tools[spell.name].tool_bag] ~= nil or player.inventory[nin_tools[spell.name].uni_tool_bag] ~= nil) then
		return true
	else
		add_to_chat(7,"No Tools Available To Cast "..spell.name)
	end
end
function nin_tool_open()
	if debugmode then
		add_to_chat(7,"9")
	end
	if nincantcount ~= #ninspells and not nincant:contains(spell.name) then
		if player.inventory[nin_tools[spell.name].tool_bag] ~= nil then
			tbid = nin_tools[spell.name].tool_bag_id
			return nin_tools[spell.name].tool_bag
		elseif player.inventory[nin_tools[spell.name].uni_tool_bag] ~= nil then
			tbid = nin_tools[spell.name].uni_tool_bag_id
			return nin_tools[spell.name].uni_tool_bag
		end
		nincant:append(spell.name)
		nincantcount = nincantcount +1
	elseif nincantcount ~= #ninspells then
		cancel_spell()
		nincount = (nincount % #ninspells) + 1
		send_command('input /ma "'..ninspells[nincount]..'" <me>')
		return
	else
		skilluprun = false
		cancel_spell()
		add_to_chat(7,"No Tools Available To Cast Any NIN Spells That You Have")
	end
end
function event_action(act)
	if debugmode then
		add_to_chat(7,"10")
	end
	action = Action(act)
    if action:get_category_string() == 'item_finish' then
        if action.raw.param == tbid and player.id == action.raw.actor_id then
			send_command('wait 1.0;input /ma "'..ninspells[nincount]..'" <me>')
			tbid = 0
		end
    end
end
windower.raw_register_event('action', event_action)
function skill_capped(id, data, modified, injected, blocked)
	local packet = packets.parse('incoming', data)
	if id == 0x062 then
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
	if debugmode then
		add_to_chat(7,"12")
	end
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
		info.skill.Summoning = (skill['Summoning Magic Capped'] and "Capped" or skill['Summoning Magic Level'])
		info.skill.Ninjutsu = (skill['Ninjutsu Capped'] and "Capped" or skill['Ninjutsu Level'])
		info.skill.Blue = (skill['Blue Magic Capped'] and "Capped" or skill['Blue Magic Level'])
		info.skillbulk = info.skill[info.mode]
		info.type = stoptype
		info.skill_ph = (get_rate(skill_ups) or 0) / 10
		info.skill_total = (total_skill_ups or 0) / 10
		window:update(info)
		window:show()
end
function file_write()
	if debugmode then
		add_to_chat(7,"13")
	end
	local file = io.open(lua_base_path..'data/'..player.name..'/Saves/skillup_data.lua',"w")
	file:write(
		'box.pos.x = '..tostring(box.pos.x)..
		'\nbox.pos.y = '..tostring(box.pos.y)..
		'')
	file:close() 
end
function mouse(type, x, y, delta, blocked)
	if type == 0 then
		if window:hover(x, y) and window:visible() then
			test:pos((box.pos.x - 139), box.pos.y)
		elseif test:hover(x, y) and test:visible() then
			window:pos((boxa.pos.x + 139), boxa.pos.y)
		else
			return
		end
	elseif type == 2 then
		local hx = (x - boxa.pos.x)
		local hy = (y - boxa.pos.y)
		local location = {}
		location.offset = boxa.text.size * 1.566666666666667
		location.GEOya = 1
		location.GEOyb = location.offset
		location.HELya = location.GEOyb
		location.HELyb = (location.GEOyb + location.offset)
		location.ENHya = location.HELyb
		location.ENHyb = (location.HELyb + location.offset)
		location.NINya = location.ENHyb
		location.NINyb = (location.ENHyb + location.offset)
		location.SINya = location.NINyb
		location.SINyb = (location.NINyb + location.offset)
		location.BLUya = location.SINyb
		location.BLUyb = (location.SINyb + location.offset)
		location.SMNya = location.BLUyb
		location.SMNyb = (location.BLUyb + location.offset)
		location.STOPya = location.SMNyb
		location.STOPyb = (location.SMNyb + location.offset)
		location.DOWNya = location.STOPyb
		location.DOWNyb = (location.STOPyb + location.offset)
		location.LOGya = location.DOWNyb
		location.LOGyb = (location.DOWNyb + location.offset)
		if test:hover(x, y) and test:visible() then
			if (hy > location.GEOya and hy < location.GEOyb) then
				send_command("gs c startgeo")
			elseif (hy > location.HELya and hy < location.HELyb) then
				send_command("gs c starthealing")
			elseif (hy > location.ENHya and hy < location.ENHyb) then
				send_command("gs c startenhancing")
			elseif (hy > location.NINya and hy < location.NINyb) then
				send_command("gs c startninjutsu")
			elseif (hy > location.SINya and hy < location.SINyb) then
				send_command("gs c startsinging")
			elseif (hy > location.BLUya and hy < location.BLUyb) then
				send_command("gs c startblue")
			elseif (hy > location.SMNya and hy < location.SMNyb) then
				send_command("gs c startsmn")
			elseif (hy > location.STOPya and hy < location.STOPyb) then
				send_command("gs c skillstop")
			elseif (hy > location.DOWNya and hy < location.DOWNyb) then
				send_command("gs c aftershutdown")
			elseif (hy > location.LOGya and hy < location.LOGyb) then
				send_command("gs c afterlogoff")
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
    local maximum_timestamp = 29
    for ts,points in pairs(tab) do
        local time_diff = t - ts
        if t - ts > 600 then
            tab[ts] = nil
        else
            running_total = running_total + points
            if time_diff > maximum_timestamp then
                maximum_timestamp = time_diff
            end
        end
    end
    
    local rate
    if maximum_timestamp == 29 then
        rate = 0
    else
        rate = math.floor((running_total/maximum_timestamp)*3600)
    end
    
    return rate
end
windower.raw_register_event('prerender',function()
    if frame_count%30 == 0 and window:visible() then
        updatedisplay()
    end
    frame_count = frame_count + 1
end)
