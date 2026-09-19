enum OptionMenu
{
	main = 0,
	audio = 1,
	video = 2,
	windowMode = 3,
	game = 4,
	language = 5,
	controls = 6,
	keyboard = 7,
	controller = 8,
	deadzones = 9
}

enum OptionType
{
	toggle = 0,
	sliderLegacy = 1,
	choice = 2,
	press = 3,
	button = 6,
	slider = 7
}

enum ButtonState
{
	released = 0,
	pressed = 1,
	lowering = 2,
	reverting = 3
}

enum Letterbox
{
	off = 0,
	simple = 1,
	doodle = 2,
	dynamic = 3
}

enum Deadzone
{
	master = 0,
	vertical = 1,
	horizontal = 2,
	press = 3,
	sjump = 4,
	crouch = 5
}

function set_resolution_option(arg0)
{
	window_set_size(global.resolutions[arg0][0], global.resolutions[arg0][1]);
	window_center();
	
	with (obj_screen)
	{
		previousMouseX = get_mouse_x_screen(0);
		previousMouseY = get_mouse_y_screen(0);
		captionBuffer = 100;
		global.gameframe_default_cursor = global.DefaultCursor;
	}
}

function create_option() constructor
{
	static add_icon = function(arg0, arg1)
	{
		sprite_index = arg0;
		image_index = arg1;
		return self;
	};
	
	value = 0;
	options = [];
	id = "";
	translate_opt = true;
	translate_name = true;
	on_toggle = undefined;
	on_slide = undefined;
	on_stop = undefined;
	sound = -4;
	alpha = 1;
	moving = false;
	show_percent = false;
	sprite_index = -4;
	image_index = 0;
	icon_alpha = 0;
}

function option_normal(arg0, arg1, arg2, arg3, arg4 = true) : create_option() constructor
{
	id = arg0;
	type = OptionType.choice;
	options = arg1;
	on_toggle = arg2;
	value = arg3;
	translate_opt = arg4;
}

function option_button(arg0, arg1) : create_option() constructor
{
	id = arg0;
	on_toggle = arg1;
	type = OptionType.button;
}

function option_slider(arg0, arg1, arg2, arg3, arg4 = -4, arg5 = false) : create_option() constructor
{
	id = arg0;
	on_slide = arg1;
	on_stop = arg2;
	type = OptionType.slider;
	sound = arg4;
	value = arg3;
	show_percent = arg5;
}

function option_goto(arg0, arg1 = 0)
{
	var _OldMenu = optionMenu;
	optionMenu = arg0;
	optionSelected = arg1;
	inputBuffer = 2;
	event_user(0);
}

function option_create_confirm(arg0, arg1, arg2)
{
	return instance_create(0, 0, obj_option_confirm, 
	{
		previousValue: arg0,
		confirmFunc: arg1,
		resetFunc: arg2
	});
}

function draw_option(arg0, arg1, arg2, arg3)
{
	draw_set_color(c_white);
	
	if (!arg3)
		draw_set_color(#666666);
	
	draw_text(arg0, arg1, arg2);
	draw_set_color(c_white);
}

function update_option_format(arg0, arg1)
{
	switch (arg0)
	{
		case 0:
			if (ini_key_exists("Settings", "resolution"))
			{
				var cur_res = ini_read_real("Settings", "resolution", 1);
				
				if (cur_res > 0)
					ini_write_real("Settings", "opt_resolution", cur_res + 1);
				
				global.selectedResolution = cur_res + 1;
			}
			
			if (ini_key_exists("Settings", "timer") || ini_key_exists("Settings", "timertype"))
			{
				var cur_timer_type = ini_read_real("Settings", "timertype", 2);
				var timer_enabled = ini_read_real("Settings", "timer", 1);
				
				if (!timer_enabled)
				{
					ini_write_real("Settings", "opt_timerType", 0);
					global.option_timer_type = 0;
				}
				else
				{
					ini_write_real("Settings", "opt_timerType", cur_timer_type + 1);
					global.option_timer_type = cur_timer_type + 1;
				}
			}
			
			break;
	}
}

function init_option()
{
	ini_open("optionData.ini");
	global.fullscreen = ini_read_real("Settings", "fullscrn", 0);
	global.selectedResolution = ini_read_real("Settings", "opt_resolution", 2);
	global.Letterbox = ini_read_real("Settings", "letterbox", 0);
	global.smoothcam = false;
	global.hitstunEnabled = true;
	global.Vsync = ini_read_real("Settings", "vsync", 1);
	global.ShowHUD = ini_read_real("Settings", "ShowHUD", 1);
	global.screentilt = false;
	global.playerrotate = false;
	global.ScreenShake = ini_read_real("Settings", "screenshake", 1);
	global.tvmessages = false;
	global.lowperformance = false;
	global.TextureFiltering = ini_read_real("Settings", "TextureFiltering", 0);
	global.unfocusedMute = ini_read_real("Settings", "unfocusmute", 1);
	global.musicAttenuation = ini_read_real("Settings", "musicAttenuation", 0);
	global.toggleTimer = 1;
	global.controllerVibration = ini_read_real("Settings", "vibration", 1);
	global.musicVolume = ini_read_real("Settings", "musicvol", 0.9);
	global.dialogueVolume = ini_read_real("Settings", "dialoguevol", 1);
	global.soundVolume = ini_read_real("Settings", "soundvol", 1);
	global.masterVolume = ini_read_real("Settings", "mastervol", 1);
	global.speakerOption = ini_read_real("Settings", "speaker", 1);
	global.option_sjump_key = ini_read_real("Settings", "dsjumpkey", 1);
	global.option_sjump_gp = ini_read_real("Settings", "dsjumpgp", 1);
	global.option_groundpound_key = ini_read_real("Settings", "dgroundpoundkey", 1);
	global.option_groundpound_gp = ini_read_real("Settings", "dgroundpoundgp", 1);
	global.option_speedrun_timer = ini_read_real("Settings", "timerspeedrun", 0);
	global.option_timer_type = ini_read_real("Settings", "opt_timerType", 3);
	global.option_livesplit_enabled = ini_read_real("Settings", "livesplit", 0);
	var cur_version = ini_read_real("FileFormat", "version", 0);
	
	if (cur_version > 1)
		show_debug_message($"WARNING: optionData.ini Version: {cur_version} is higher than game's expected optionData.ini version: {1}. Tomfoolery afoot.");
	
	if (!ini_section_exists("FileFormat") || !ini_key_exists("FileFormat", "version") || cur_version < 1)
	{
		show_debug_message($"ALERT: Updating optionData.ini version... {cur_version} to {1}");
		ini_write_real("FileFormat", "version", 1);
		update_option_format(cur_version, 1);
	}
	
	ini_close();
	scr_setinput_init();
	scr_input_create();
	scr_lang_init();
	display_reset(0, global.Vsync);
	set_resolution_option(global.selectedResolution);
	
	with (obj_screen)
		event_perform(ev_alarm, 0);
	
	scr_initKeyNameMap();
}

function quick_write_option(arg0, arg1, arg2)
{
	ini_open("optionData.ini");
	
	if (is_string(arg2))
		ini_write_string(arg0, arg1, arg2);
	else
		ini_write_real(arg0, arg1, arg2);
	
	ini_close();
	
	with (obj_option)
		changedAnyOption = true;
}

function create_option_menu(arg0, arg1, arg2, arg3 = camera_get_view_width(view_camera[0]) / 2, arg4 = 150, arg5 = 25)
{
	return -4;
	var q = 
	{
		centered: arg0,
		backto: arg1,
		options: arg2,
		xpad: arg3,
		ypad: arg4,
		textpad: arg5
	};
	return q;
}

function create_option_toggle(arg0, arg1, arg2, arg3)
{
	return -4;
	var q = 
	{
		name: arg1,
		desc: arg2,
		type: OptionType.toggle,
		alpha: 1,
		func: arg3,
		value: 0
	};
	array_push(arg0, q);
	return q;
}

function create_option_press(arg0, arg1, arg2, arg3)
{
	return -4;
	var q = 
	{
		name: arg1,
		desc: arg2,
		type: OptionType.press,
		alpha: 1,
		func: arg3,
		value: 0
	};
	array_push(arg0, q);
	return q;
}

function create_option_multichoice(arg0, arg1, arg2, arg3, arg4)
{
	return -4;
	var q = 
	{
		name: arg1,
		desc: arg2,
		type: OptionType.choice,
		alpha: 1,
		choices: arg3,
		func: arg4,
		value: 0
	};
	array_push(arg0, q);
	return q;
}

function create_option_slider(arg0, arg1, arg2, arg3, arg4, arg5 = undefined)
{
	return -4;
	var q = 
	{
		name: arg1,
		desc: arg2,
		type: OptionType.sliderLegacy,
		alpha: 1,
		on_move: arg3,
		on_stop: arg4,
		value: 0,
		moving: false,
		sound: undefined
	};
	
	if (!is_undefined(arg5))
		q.sound = fmod_createEventInstance(arg5);
	
	array_push(arg0, q);
	return q;
}

function goto_menu(arg0)
{
	return -4;
	selectedmenu = arg0;
	optionselected = 0;
	textScroll = -9999;
	pgHeight = 0;
	showdesc = false;
}
