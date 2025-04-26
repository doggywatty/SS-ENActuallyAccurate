global.scribble_saved_profile = "[pPrompt]";

function scribble_quick_button(button)
{
	return $"[c_white]{get_control_sprite(button)}{global.scribble_saved_profile}";
}

global.DefaultCursor = 0;
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
	return "[npcfont][c_black]";
});
scribble_add_macro("pPrompt", function()
{
	global.scribble_saved_profile = "[pPrompt]";
	return "[promptfont][c_white]";
});
scribble_add_macro("iSl", function()
{
	return scr_getDialogIcon("SLUGGY", "c_white", "c_white");
});
scribble_add_macro("iGH", function()
{
	return scr_getDialogIcon("HARRY", "c_white", "c_white");
});
scribble_add_macro("iCw", function()
{
	return scr_getDialogIcon("COTTONWITCH", "c_white", "c_white");
});
scribble_add_macro("iGu", function()
{
	return scr_getDialogIcon("GUARDIAN", "c_white", "c_white");
});
scribble_add_macro("iFf", function()
{
	return scr_getDialogIcon("FLINGFROG", "c_white", "c_white");
});
global.allTexturePages = [
	"Default", "Player", "Baddies", "HUD", "Backgrounds", "Unused", "Devs", 
	"Entryway", "Cottontown", "Mines", "Molasses", "Hub", "Structure", "Cafe", "Fudgetop", "Sucrose",
	"geyserwaves", "effectsGroup", "titleGroup", "testingGroup"
];
global.langUpdated = false;
randomize();
global.RandomSeed = random_get_seed();
global.GLOBAL_FUN = 0;

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
	global.PreviousRoom = rm_missing;	
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
		[480, 270], [640, 360], [960, 540], [1024, 576], [1280, 720], [1600, 900], [1920, 1080],
		[2560, 1440], [3840, 2160]
	];
	init_option();
	scr_judgment_init();
	global.doorsave = ds_list_create();
	global.afterimage_list = ds_list_create();
	global.doorindex = 0;
}
