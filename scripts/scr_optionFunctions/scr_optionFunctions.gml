function set_resolution_option(window)
{
	window_set_size(global.resolutions[window][0], global.resolutions[window][1]);
	window_center();
	with obj_screen
	{
		previousMouseX = get_mouse_x_screen(0);
		previousMouseY = get_mouse_y_screen(0);
		captionBuffer = 100;
		global.gameframe_default_cursor = global.DefaultCursor;
	}	
}

function create_option() constructor
{
	static add_icon = function(spr_ind, img_ind)
	{
		sprite_index = spr_ind;
		image_index = img_ind;
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

function option_normal(_id, _options, _on_toggle, _value, _translate_opt = true) : create_option() constructor
{
	id = _id;
	type = OptionType.Normal;
	options = _options;
	on_toggle = _on_toggle;
	value = _value;
	translate_opt = _translate_opt;
}

function option_button(_id, _on_toggle) : create_option() constructor
{
	id = _id;
	on_toggle = _on_toggle;
	type = OptionType.Button;
}

function option_slider(_id, _on_slide, _on_stop, _value, _sound = -4, _show_percent = false) : create_option() constructor
{
	id = _id;
	on_slide = _on_slide;
	on_stop = _on_stop;
	type = OptionType.Slider;
	sound = _sound;
	value = _value;
	show_percent = _show_percent;
}

function option_goto(_optionMenu, _optionSelected = 0)
{
	var _OldMenu = optionMenu;
	optionMenu = _optionMenu;
	optionSelected = _optionSelected;
	inputBuffer = 2;
	event_user(0);
}

function option_create_confirm(_previousValue, _confirmFunc, _resetFunc)
{
	return instance_create(0, 0, obj_option_confirm, 
	{
		previousValue: _previousValue,
		confirmFunc: _confirmFunc,
		resetFunc: _resetFunc
	});
}

function draw_option(_x, _y, _string, _color)
{
	draw_set_color(c_white);
	if !_color
		draw_set_color(#666666);
	draw_text(_x, _y, _string);
	draw_set_color(c_white);
}

function update_option_format(_ver, _num)
{
	switch _ver
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
				if !timer_enabled
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
	with obj_screen
		event_perform(ev_alarm, 0);
	scr_initKeyNameMap();
}

function quick_write_option(_section, _key, _strvalue)
{
	ini_open("optionData.ini");
	if is_string(_strvalue)
		ini_write_string(_section, _key, _strvalue);
	else
		ini_write_real(_section, _key, _strvalue);
	ini_close();
	with obj_option
		changedAnyOption = true;	
}

function create_option_menu(_centered, _backto, _options, _xpad = camera_get_view_width(view_camera[0]) / 2, _ypad = 150, _textpad = 25)
{
	return -4;
	var q = 
	{
		centered: _centered,
		backto: _backto,
		options: _options,
		xpad: _xpad,
		ypad: _ypad,
		textpad: _textpad
	};
	return q;
}

function create_option_toggle(_option, _name, _desc, _func)
{
	return -4;
	var q = 
	{
		name: _name,
		desc: _desc,
		type: OldOptionType.Toggle,
		alpha: 1,
		func: _func,
		value: 0
	};
	array_push(_option, q);
	return q;
}

function create_option_press(_option, _name, _desc, _func)
{
	return -4;
	var q = 
	{
		name: _name,
		desc: _desc,
		type: OldOptionType.Press,
		alpha: 1,
		func: _func,
		value: 0
	};
	array_push(_option, q);
	return q;
}

function create_option_multichoice(_option, _name, _desc, _choices, _func)
{
	return -4;
	var q = 
	{
		name: _name,
		desc: _desc,
		type: OldOptionType.MultiChoice,
		alpha: 1,
		choices: _choices,
		func: _func,
		value: 0
	};
	array_push(_option, q);
	return q;
}

function create_option_slider(_option, _name, _desc, _on_move, _on_stop, _sound = undefined)
{
	return -4;
	var q = 
	{
		name: _name,
		desc: _desc,
		type: OldOptionType.Slider,
		alpha: 1,
		on_move: _on_move,
		on_stop: _on_stop,
		value: 0,
		moving: false,
		sound: undefined
	};
	if !is_undefined(_sound)
		q.sound = fmod_createEventInstance(_sound);
	array_push(_option, q);
	return q;
}

function goto_menu(_menu)
{
	return -4;
	selectedmenu = _menu;
	optionselected = 0;
	textScroll = -9999;
	pgHeight = 0;
	showdesc = false;
}
