global.scribble_saved_profile = "[pPrompt]";

function scribble_quick_button(button)
{
	return string($"[c_white]{get_control_sprite(button)}{global.scribble_saved_profile}");
}

scribble_add_macro("kL", function()
{
	return scribble_quick_button("left");
});
scribble_add_macro("kU", function()
{
	return scribble_quick_button("up");
});
scribble_add_macro("kD", function()
{
	return scribble_quick_button("down");
});
scribble_add_macro("kR", function()
{
	return scribble_quick_button("right");
});
scribble_add_macro("kJ", function()
{
	return scribble_quick_button("jump");
});
scribble_add_macro("kG", function()
{
	return scribble_quick_button("slap");
});
scribble_add_macro("kM", function()
{
	return scribble_quick_button("attack");
});
scribble_add_macro("kT", function()
{
	return scribble_quick_button("taunt");
});
scribble_add_macro("kSJ", function()
{
	return scribble_quick_button("dialogSJ");
});
scribble_add_macro("kGP", function()
{
	return scribble_quick_button("dialogGP");
});
scribble_add_macro("kFWD", function()
{
	return scribble_quick_button("forward");
});
scribble_add_macro("kBCK", function()
{
	return scribble_quick_button("backward");
});
scribble_add_macro("pNPC", function()
{
	global.scribble_saved_profile = "[pNPC]";
	return "[spr_npc_font][c_black]";
});
scribble_add_macro("pPrompt", function()
{
	global.scribble_saved_profile = "[pPrompt]";
	return "[spr_promptfont][c_white]";
});
scribble_add_macro("iSl", function()
{
	return scr_getDialogIcon("SLUGGY", "c_white", "c_white");
});
scribble_add_macro("iCw", function()
{
	return scr_getDialogIcon("COTTONWITCH", "c_white", "c_white");
});

global.allTexturePages = [
	"Default", "Player", "Baddies", "HUD", "Backgrounds", "Unused", "Devs", 
	"Entryway", "Cottontown", "Mines", "Molasses", "Hub", "Structure", "Cafe", "Fudgetop", "Sucrose",
	"geyserwaves", "effectsGroup", "titleGroup", "testingGroup"
];
global.MainMenuRefresh = false;
randomize();
global.RandomSeed = random_get_seed();

function scr_gameInit()
{
	var dbg_mode = DebugType.None;
	if GM_build_type == "run"
		dbg_mode = DebugType.Dev;
	
	for (var p_i = 0, p_c = parameter_count(); p_i <= p_c; p_i++)
	{
	    if dbg_mode == DebugType.Dev
	        break;
	    var p_s = string_lower(parameter_string(p_i));
	    switch p_s
	    {
	        case "-dev":
	        case "--dev":
	        case "-debug":
	        case "--debug":
	            dbg_mode = DebugType.Dev;
	            break;
	        case "-playtest":
	        case "--playtest":
	            dbg_mode = DebugType.Playtest;
	            break;
	    }
	}
	
	global.DebugMode = dbg_mode;
	surface_depth_disable(true);
	global.coopGame = false;
	global.SaveFileName = "saveData1.ini";
	global.NewFile = false;
	global.PainterTopperIndex = irandom_range(0, sprite_get_number(spr_paintertopper) - 1);
	global.RespawnBlockMoving = false;
	global.challengemode = 0;
	global.erank = 0;
	global.srank = 0;
	global.arank = 0;
	global.brank = 0;
	global.crank = 0;
	global.NewHighScore = false;
	global.HurtCounter = 0;
	global.LocalHurtCounter = 0;
	global.CompletedLevel = false;
	global.HurtMilestone = 0;
	global.MallowFollow = false;
	global.CrackFollow = false;
	global.NephewFollow = false;
	global.currentrank = "D";
	global.panic = false;
	global.PlayerPaletteIndex = 2;
	global.InternalLevelName = "none";
	global.LevelFirstRoom = hub_paintstudio;
	global.secretfound = 0;
	global.gamePauseState = 0;
	global.LevelFrames = 0;
	global.LevelSeconds = 0;
	global.LevelMinutes = 0;
	global.SaveFrames = 0;
	global.SaveSeconds = 0;
	global.SaveMinutes = 0;
	global.EscapeTime = 0;
	global.savedfill = 0;
	global.ExitGateTaunt = 0;
	global.freezeframe = false;
	global.TransfoPrompt = "";
	global.TransfoState = States.normal;
	global.greyscalefade = 0;
	global.music = -4;
	global.harrymusic = -4;
	global.shopmusic = -4;
	global.PAUSE_contTrack_pos = 0;
	global.DialogMessage = 0;
	global.dialogchoices = 0;
	global.choiced = 0;
	global.CurrentTime = current_time;
	global.minesProgress = false;
	global.cutsceneManager = -4;
	global.font = __scribble_font_add_sprite_ext(spr_font, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ!¡.,1234567890:?¿ÁÉÍÓÚ", 1, 0);
	global.smallfont = __scribble_font_add_sprite_ext(spr_smallfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ.?!¡1234567890\"-:ÁÉÍÓÚ_", 1, 0);
	global.smalltimerfont = __scribble_font_add_sprite_ext(spr_smalltimerfont, ".1234567890:", 1, 0);
	global.creditsfont = __scribble_font_add_sprite_ext(spr_creditsfont, " ABCDEFGHIJKLMNOPQRSTUVWXYZ.!,abcdefghijklmnopqrstuvwxyz0123456789@#$%^&*(){}[]|:;'/`", 1, 0);
	global.collectfont = __scribble_font_add_sprite_ext(spr_fontcollect, "0123456789", 1, 0);
	global.candlefont = __scribble_font_add_sprite_ext(spr_fontcandle, "0123456789", 1, 0);
	global.candleBigFont = __scribble_font_add_sprite_ext(spr_fontBigCandle, "0123456789", 1, 0);
	global.rankcombofont = __scribble_font_add_sprite_ext(spr_fontrankcombo, "0123456789", 1, 0);
	global.bubblefont = __scribble_font_add_sprite_ext(spr_bubblefont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.!<>'?()[]", 1, 0);
	global.npcsmallfont = __scribble_font_add_sprite_ext(spr_npcsmallfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz!¡.,:0123456789'?¿-\"ÁÉÍÓÚáéíóú", true, 1);
	global.timerfont = __scribble_font_add_sprite_ext(spr_timer_font, "1234567890", 0, 6);
	global.combofont = __scribble_font_add_sprite_ext(spr_tvHUD_comboFont, "0123456789", 1, 2);
	global.lapfont = __scribble_font_add_sprite_ext(spr_lap_font, "0123456789", 1, 2);
	global.dialogfont = __scribble_font_add_sprite_ext(spr_font_dialogue, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz,.!¡?¿:;\"`'/-_+=1234567890@#$%^&*()[]ÁÉÍÓÚáéíóú", 1, 2);
	global.percentageFont = __scribble_font_add_sprite_ext(spr_fontPercentage, "1234567890%", 1, 2);
	global.buttonfont = __scribble_font_add_sprite_ext(spr_buttonfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ$%&*()/", 1, 0);
	global.promptfont = __scribble_font_add_sprite_ext(spr_promptfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz.,:!¡0123456789?¿'\"ÁÉÍÓÚáéíóú_-[]▼()&#风雨廊桥전태양*яиБжидГзвбнль", 1, 0);
	global.npcfont = __scribble_font_add_sprite_ext(spr_npcfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz!¡,.:0123456789'?¿-()\"ÁÉÍÓÚáéíóú/", 1, 2);
	global.cafefont = __scribble_font_add_sprite_ext(spr_cafefontbig, "0123456789:", 1, 0);
	global.cafefontsmall = __scribble_font_add_sprite_ext(spr_cafefontsmall, "0123456789:", 1, 0);
	global.keyDrawFont = __scribble_font_add_sprite_ext(spr_keyDrawFont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+=-*'`,./\\{];", true, 0);
	global.MoneyFont = __scribble_font_add_sprite_ext(spr_moneyFont, "0123456789$-", true, 0);
	global.smallnumberfont = __scribble_font_add_sprite_ext(spr_smallnumber, "1234567890-+", true, 0);
	global.shellactivate = false;
	global.showcollisions = false;
	global.showtiles = true;
	global.DebugVisuals = false;
	global.fartcounter = 0;
	if (global.DebugMode == DebugType.Dev || global.DebugMode == DebugType.Playtest)
		global.showcollisions = true;
	global.parallaxbg_surface = -4;
	global.ParallaxMap = ds_map_create();
	scr_default_parallax(true);
	global.FollowerList = ds_list_create();
	global.KeyFollowerList = ds_list_create();
	global.MallowFollow = false;
	global.CrackFollow = false;
	global.ChocoFollow = false;
	global.WormFollow = false;
	global.CandyFollow = false;
	global.janitorRudefollow = false;
	global.janitorLapfollow = false;
	global.Donutfollow = false;
	global.janitortype = 1;
	global.lapcount = 0;
	global.CafeDrawer = -4;
	global.PlayerInputDevice = -2;
	global.PlayerInputDevice2 = -2;
	global.targetCamX = 0;
	global.targetCamY = 0;
	global.resolutions = [
		[480, 270], [960, 540], [1024, 576], [1280, 720], [1600, 900], [1920, 1080]
	];
	init_option();
	scr_judgment_init();
	gml_release_mode(global.DebugMode == DebugType.Dev);
	global.doorsave = ds_list_create();
	global.afterimage_list = ds_list_create();
	global.doorindex = 0;
}
