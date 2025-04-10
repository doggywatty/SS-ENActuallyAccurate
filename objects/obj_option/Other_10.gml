handle_savedoption();
kill_sounds([activeSFX]);
var onOffToggle = ["opt_off", "opt_on"];
var toMainPage = new option_button("opt_back", function()
{
	event_play_oneshot("event:/SFX/ui/menuBack");
	option_goto(backMenu, backOption);
});

switch optionMenu
{
	default:
		alignCenter = true;
		backMenu = -4;
		backOption = 0;
		options = [new option_button("opt_audio", function()
		{
			option_goto(OptionMenu.Audio);
		}).add_icon(spr_newpause_icons, 5), new option_button("opt_video", function()
		{
			option_goto(OptionMenu.Video);
		}).add_icon(spr_newpause_icons, 6), new option_button("opt_game", function()
		{
			option_goto(OptionMenu.Game);
		}).add_icon(spr_newpause_icons, 8), new option_button("opt_controls", function()
		{
			option_goto(OptionMenu.Controls);
		}).add_icon(spr_newpause_icons, 7)];
		break;
	case OptionMenu.Audio:
		backMenu = OptionMenu.Base;
		backOption = 0;
		alignCenter = false;
		sliderSprite = spr_optionslide_bar;
		sliderIcon = spr_optionslide_end;
		var speaker_options = ["opt_aud_mono", "opt_aud_stereo"];
		options = [toMainPage, new option_slider("opt_aud_master", function(val)
		{
			global.masterVolume = val / 100;
			set_volume_options();
		}, function(val)
		{
			global.masterVolume = val / 100;
			set_volume_options();
			quick_write_option("Settings", "mastervol", global.masterVolume);
		}, round(global.masterVolume * 100), "event:/SFX/ui/sliderMaster"), new option_slider("opt_aud_music", function(val)
		{
			global.musicVolume = val / 100;
			set_volume_options();
		}, function(val)
		{
			global.musicVolume = val / 100;
			set_volume_options();
			quick_write_option("Settings", "musicvol", global.musicVolume);
		}, round(global.musicVolume * 100), "event:/SFX/ui/sliderMusic"), new option_slider("opt_aud_sfx", function(val)
		{
			global.soundVolume = val / 100;
			set_volume_options();
		}, function(val)
		{
			global.soundVolume = val / 100;
			set_volume_options();
			quick_write_option("Settings", "soundvol", global.soundVolume);
		}, round(global.soundVolume * 100), "event:/SFX/ui/sliderSFX"), new option_normal("opt_aud_focus", onOffToggle, function(val)
		{
			quick_write_option("Settings", "unfocusmute", val);
			global.unfocusedMute = val;
		}, global.unfocusedMute), new option_normal("opt_aud_speaker", speaker_options, function(val)
		{
			quick_write_option("Settings", "speaker", val);
			global.speakerOption = val;
			fmod_studio_system_set_parameter_by_name("speakerOption", val, true);
		}, global.speakerOption)];
		break;
	case OptionMenu.Video:
		backMenu = OptionMenu.Base;
		backOption = 1;
		alignCenter = false;
		
		var res = [];
		for (var i = 0; i < array_length(global.resolutions); i++)
			array_push(res, string($"{global.resolutions[i][0]}X{global.resolutions[i][1]}"));
		
		options = [toMainPage, new option_normal("opt_vid_windowmode", ["opt_vid_windowmode_windowed", "opt_vid_windowmode_exclusive", "opt_vid_windowmode_borderless"], function(val)
		{
			quick_write_option("Settings", "fullscrn", val);
			global.fullscreen = val;
			with obj_screen
				alarm[0] = 1;
		}, global.fullscreen), new option_normal("opt_vid_resolution", res, function(val)
		{
			quick_write_option("Settings", "resolution", val);
			global.selectedResolution = val;
			set_resolution_option(global.selectedResolution);
		}, global.selectedResolution, false), new option_normal("opt_vid_vsync", onOffToggle, function(val)
		{
			quick_write_option("Settings", "vsync", val);
			display_reset(0, global.Vsync);
			global.Vsync = val;
		}, global.Vsync), new option_normal("opt_vid_texturefilter", onOffToggle, function(val)
		{
			quick_write_option("Settings", "TextureFiltering", val);
			global.TextureFiltering = val;
		}, global.TextureFiltering), new option_normal("opt_vid_showHUD", onOffToggle, function(val)
		{
			quick_write_option("Settings", "showHUD", val);
			global.ShowHUD = val;
		}, global.ShowHUD)];
		break;
	case OptionMenu.Game:
		backMenu = OptionMenu.Base;
		backOption = 2;
		alignCenter = false;
		var timer_options = ["opt_game_timer_type_level", "opt_game_timer_type_save", "opt_game_timer_type_both"];
		options = [toMainPage, new option_normal("opt_game_vibrate", onOffToggle, function(val)
		{
			quick_write_option("Settings", "vibration", val);
			global.controllerVibration = val;
		}, global.controllerVibration), new option_normal("opt_game_screenshake", onOffToggle, function(val)
		{
			quick_write_option("Settings", "screenshake", val);
			global.ScreenShake = val;
		}, global.ScreenShake), new option_normal("opt_game_timer", onOffToggle, function(val)
		{
			quick_write_option("Settings", "timer", val);
			global.toggleTimer = val;
		}, global.toggleTimer), new option_normal("opt_game_timerspeedrun", onOffToggle, function(val)
		{
			quick_write_option("Settings", "timerspeedrun", val);
			global.option_speedrun_timer = val;
		}, global.option_speedrun_timer), new option_normal("opt_game_timer_type", timer_options, function(val)
		{
			quick_write_option("Settings", "timertype", val);
			global.option_timer_type = val;
		}, global.option_timer_type)];
		break;
	case OptionMenu.Language:
		backMenu = OptionMenu.Game;
		backOption = 1;
		alignCenter = false;
		var lang_switcher = new option_normal("opt_access_lang", global.langFiles, function(val)
		{
			var f = global.langFiles[val];
			if (f != string($"{global.langName}.txt"))
			{
				scr_lang_set_file(f);
				quick_write_option("Settings", "lang", global.langName);
				trace("Current language: ", lang_get("language"));
			}
		}, array_get_index(global.langFiles, string($"{global.langName}.txt")));
		with lang_switcher
			translate_opt = false;
		var timer_options = ["PER LEVEL", "PER SAVE", "BOTH"];
		options = [toMainPage, lang_switcher];
		break;
	case OptionMenu.Controls:
		backMenu = OptionMenu.Base;
		backOption = 3;
		alignCenter = false;
		options = [toMainPage, new option_button("opt_ctrl_keyboard", function()
		{
			option_goto(OptionMenu.Keyboard);
		}), new option_button("opt_ctrl_controller", function()
		{
			option_goto(OptionMenu.Gamepad);
		})];
		break;
	case OptionMenu.Keyboard:
		backMenu = OptionMenu.Controls;
		backOption = 1;
		alignCenter = false;
		options = [toMainPage, new option_button("opt_ctrl_bindings", function()
		{
			if !instance_exists(obj_option_keyconfig)
			{
				scr_input_varinit();
				with instance_create(x, y, obj_option_keyconfig)
					gamepad = false;
			}
		}), new option_normal("opt_ctrl_keyboardsuperjump", onOffToggle, function(val)
		{
			quick_write_option("Settings", "dsjumpkey", val);
			global.option_sjump_key = val;
		}, global.option_sjump_key), new option_normal("opt_ctrl_keyboardgroundpound", onOffToggle, function(val)
		{
			quick_write_option("Settings", "dgroundpoundkey", val);
			global.option_groundpound_key = val;
		}, global.option_groundpound_key)];
		break;
	case OptionMenu.Gamepad:
		backMenu = OptionMenu.Controls;
		backOption = 2;
		alignCenter = false;
		options = [toMainPage, new option_button("opt_ctrl_bindings", function()
		{
			if !instance_exists(obj_option_keyconfig)
			{
				scr_input_varinit();
				with instance_create(x, y, obj_option_keyconfig)
					gamepad = true;
			}
		}), new option_button("opt_ctrl_deadzones", function()
		{
			option_goto(OptionMenu.Deadzones);
		}), new option_normal("opt_ctrl_controllersuperjump", onOffToggle, function(val)
		{
			quick_write_option("Settings", "dsjumpgp", val);
			global.option_sjump_gp = val;
		}, global.option_sjump_gp), new option_normal("opt_ctrl_controllergroundpound", onOffToggle, function(val)
		{
			quick_write_option("Settings", "dgroundpoundgp", val);
			global.option_groundpound_gp = val;
		}, global.option_groundpound_gp)];
		break;
	case OptionMenu.Deadzones:
		backMenu = OptionMenu.Gamepad;
		backOption = 2;
		alignCenter = false;
		sliderSprite = spr_optionSlider;
		sliderIcon = spr_optionSliderIcon2;
		options = [toMainPage, new option_slider("opt_ctrl_dz_gen", function(val)
		{
			global.deadzones[Deadzones.Master] = val / 100;
		}, function(val)
		{
			global.deadzones[Deadzones.Master] = val / 100;
			quick_write_option("Settings", "deadzoneMaster", global.deadzones[Deadzones.Master]);
		}, round(global.deadzones[Deadzones.Master] * 100)), new option_slider("opt_ctrl_dz_vert", function(val)
		{
			global.deadzones[Deadzones.Vertical] = val / 100;
		}, function(val)
		{
			global.deadzones[Deadzones.Vertical] = val / 100;
			quick_write_option("Settings", "deadzoneVertical", global.deadzones[Deadzones.Vertical]);
		}, round(global.deadzones[Deadzones.Vertical] * 100)), new option_slider("opt_ctrl_dz_horiz", function(val)
		{
			global.deadzones[Deadzones.Horizontal] = val / 100;
		}, function(val)
		{
			global.deadzones[Deadzones.Horizontal] = val / 100;
			quick_write_option("Settings", "deadzoneHorizontal", global.deadzones[Deadzones.Horizontal]);
		}, round(global.deadzones[Deadzones.Horizontal] * 100)), new option_slider("opt_ctrl_dz_press", function(val)
		{
			global.deadzones[Deadzones.Press] = val / 100;
		}, function(val)
		{
			global.deadzones[Deadzones.Press] = val / 100;
			quick_write_option("Settings", "deadzonePress", global.deadzones[Deadzones.Press]);
		}, round(global.deadzones[Deadzones.Press] * 100)), new option_slider("opt_ctrl_dz_superjump", function(val)
		{
			global.deadzones[Deadzones.SJump] = val / 100;
		}, function(val)
		{
			global.deadzones[Deadzones.SJump] = val / 100;
			quick_write_option("Settings", "deadzoneSJump", global.deadzones[Deadzones.SJump]);
		}, round(global.deadzones[Deadzones.SJump] * 100)), new option_slider("opt_ctrl_dz_crouchwalk", function(val)
		{
			global.deadzones[Deadzones.Crouch] = val / 100;
		}, function(val)
		{
			global.deadzones[Deadzones.Crouch] = val / 100;
			quick_write_option("Settings", "deadzoneCrouch", global.deadzones[Deadzones.Crouch]);
		}, round(global.deadzones[Deadzones.Crouch] * 100))];
		break;
}
