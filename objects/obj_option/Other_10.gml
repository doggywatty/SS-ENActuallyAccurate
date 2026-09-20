handle_savedoption();
kill_sounds([activeSFX]);
var onOffToggle = ["opt_off", "opt_on"];
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDI
var toMainPage = new option_button("opt_back", function()
{
	event_play_oneshot("event:/SFX/ui/menuBack");
	option_goto(backMenu, backOption);
});

switch (optionMenu)
{
	default:
		alignCenter = true;
		backMenu = -4;
		backOption = 0;
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPAD
		options = [new option_button("opt_audio", function()
		{
			option_goto(OptionMenu.audio);
//P
		}).add_icon(spr_newpause_icons, 5), new option_button("opt_video", function()
		{
			option_goto(OptionMenu.video);
//P
		}).add_icon(spr_newpause_icons, 6), new option_button("opt_game", function()
		{
			option_goto(OptionMenu.game);
//P
		}).add_icon(spr_newpause_icons, 8), new option_button("opt_controls", function()
		{
			option_goto(OptionMenu.controls);
		}).add_icon(spr_newpause_icons, 7)];
		
		if (room == rm_mainmenu)
		{
//PADDINGPADDINGPADDING
			var lang_menu = new option_button("opt_language", function()
			{
				option_goto(OptionMenu.language);
				instance_create(0, 0, obj_option_lang);
				scr_input_varinit();
			});
			lang_menu.add_icon(spr_newpause_icons, 9);
			array_push(options, lang_menu);
		}
		
		break;
	case OptionMenu.audio:
		backMenu = OptionMenu.main;
		backOption = 0;
		alignCenter = false;
		sliderSprite = spr_optionslide_bar;
		sliderIcon = spr_optionslide_end;
		var speaker_options = ["opt_aud_mono", "opt_aud_stereo"];
//PADDINGPADDINGPADDINGPADDING
		options = [toMainPage, new option_slider("opt_aud_master", function(arg0)
		{
			global.masterVolume = arg0 / 100;
			set_volume_options();
//
		}, function(arg0)
		{
			global.masterVolume = arg0 / 100;
			set_volume_options();
			quick_write_option("Settings", "mastervol", global.masterVolume);
//PADDINGPADDINGPADDI
		}, round(global.masterVolume * 100), "event:/SFX/ui/sliderMaster"), new option_slider("opt_aud_music", function(arg0)
		{
			global.musicVolume = arg0 / 100;
			set_volume_options();
//
		}, function(arg0)
		{
			global.musicVolume = arg0 / 100;
			set_volume_options();
			quick_write_option("Settings", "musicvol", global.musicVolume);
//PADDINGPADDINGPADD
		}, round(global.musicVolume * 100), "event:/SFX/ui/sliderMusic"), new option_slider("opt_aud_sfx", function(arg0)
		{
			global.soundVolume = arg0 / 100;
			set_volume_options();
//
		}, function(arg0)
		{
			global.soundVolume = arg0 / 100;
			set_volume_options();
			quick_write_option("Settings", "soundvol", global.soundVolume);
//PADDINGPADDINGPADDINGPA
		}, round(global.soundVolume * 100), "event:/SFX/ui/sliderSFX"), new option_normal("opt_aud_focus", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "unfocusmute", arg0);
			global.unfocusedMute = arg0;
//PADDINGPADDINGPADDINGPADDINGPA
		}, global.unfocusedMute), new option_normal("opt_aud_attenuation", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "musicAttenuation", arg0);
			global.musicAttenuation = arg0;
//PADDINGPADDINGPADDING
		}, global.musicAttenuation), new option_normal("opt_aud_speaker", speaker_options, function(arg0)
		{
			quick_write_option("Settings", "speaker", arg0);
			global.speakerOption = arg0;
			fmod_studio_system_set_parameter_by_name("speakerOption", arg0, true);
		}, global.speakerOption)];
		break;
	case OptionMenu.video:
		backMenu = OptionMenu.main;
		backOption = 1;
		alignCenter = false;
		var res = [];
		
		for (var i = 0; i < array_length(global.resolutions); i++)
			array_push(res, $"{global.resolutions[i][0]}X{global.resolutions[i][1]}");
		
		var letterbox_option = ["opt_off", "opt_vid_letterbox_simple", "opt_vid_letterbox_doodle", "opt_vid_letterbox_dynamic"];
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGP
		options = [toMainPage, new option_button("opt_vid_windowmode", function()
		{
			option_goto(OptionMenu.windowMode);
//PADDINGPADD
		}), new option_normal("opt_vid_resolution", res, function(arg0)
		{
			quick_write_option("Settings", "opt_resolution", arg0);
			global.selectedResolution = arg0;
			
			if (!global.fullscreen)
			{
				set_resolution_option(global.selectedResolution);
				gameframe_restore();
			}
//PADDINGPADDINGPADDING
		}, global.selectedResolution, false), new option_normal("opt_vid_letterbox", letterbox_option, function(arg0)
		{
			quick_write_option("Settings", "letterbox", arg0);
			global.Letterbox = arg0;
			
			with (obj_screen)
				event_user(1);
//PADDINGPADDINGPADDINGPADDINGP
		}, global.Letterbox), new option_normal("opt_vid_vsync", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "vsync", arg0);
			display_reset(0, global.Vsync);
			global.Vsync = arg0;
//PADDINGPADDINGPADDINGPADDIN
		}, global.Vsync), new option_normal("opt_vid_texturefilter", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "TextureFiltering", arg0);
			global.TextureFiltering = arg0;
//PADDINGPADDINGPADDI
		}, global.TextureFiltering), new option_normal("opt_vid_showHUD", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "showHUD", arg0);
			global.ShowHUD = arg0;
		}, global.ShowHUD)];
		break;
	case OptionMenu.windowMode:
		backMenu = OptionMenu.video;
		backOption = 1;
		alignCenter = false;
//PADDINGPADDINGPADDINGPADD
		options = [toMainPage, new option_button("opt_vid_windowmode_windowed", function()
{
	set_fullscreen_option(0);
		}), new option_button("opt_vid_windowmode_exclusive", function()
{
	set_fullscreen_option(1);
		}), new option_button("opt_vid_windowmode_borderless", function()
		{
			set_fullscreen_option(2);
		})];
		break;
	case OptionMenu.game:
		backMenu = OptionMenu.main;
		backOption = 2;
		alignCenter = false;
		var timer_options = ["opt_off", "opt_game_timer_type_level", "opt_game_timer_type_save", "opt_game_timer_type_both"];
//PADDINGPADDINGPADDINGPADDING
		options = [toMainPage, new option_normal("opt_game_vibrate", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "vibration", arg0);
			global.controllerVibration = arg0;
//PADDINGPADDINGPADDINGPADDIN
		}, global.controllerVibration), new option_normal("opt_game_screenshake", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "screenshake", arg0);
			global.ScreenShake = arg0;
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPA
		}, global.ScreenShake), new option_normal("opt_game_timer_type", timer_options, function(arg0)
		{
			quick_write_option("Settings", "opt_timerType", arg0);
			global.option_timer_type = arg0;
//PADDINGPADDINGPADDINGPADDING
		}, global.option_timer_type), new option_normal("opt_game_timerspeedrun", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "timerspeedrun", arg0);
			global.option_speedrun_timer = arg0;
		}, global.option_speedrun_timer)];
		
		if (room == rm_mainmenu)
		{
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGP
			array_push(options, new option_button("opt_game_reset_clothes", function()
			{
				instance_create(0, 0, obj_option_clothes);
			}));
		}
		
		break;
	case OptionMenu.language:
		backMenu = OptionMenu.main;
		backOption = 4;
		alignCenter = false;
		break;
	case OptionMenu.controls:
		backMenu = OptionMenu.main;
		backOption = 3;
		alignCenter = false;
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPA
		options = [toMainPage, new option_button("opt_ctrl_keyboard", function()
{
			option_goto(OptionMenu.keyboard);
		}), new option_button("opt_ctrl_controller", function()
		{
			option_goto(OptionMenu.controller);
		})];
		break;
	case OptionMenu.keyboard:
		backMenu = OptionMenu.controls;
		backOption = 1;
		alignCenter = false;
//PADDINGPADDINGPADDINGPADDINGPADDING
		options = [toMainPage, new option_button("opt_ctrl_bindings", function()
		{
			if (!instance_exists(obj_option_keyconfig))
			{
				scr_input_varinit();
				
				with (instance_create(x, y, obj_option_keyconfig))
					gamepad = false;
			}
//PADDINGPADDINGPADD
		}), new option_normal("opt_ctrl_keyboardsuperjump", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "dsjumpkey", arg0);
			global.option_sjump_key = arg0;
//PADD
		}, global.option_sjump_key), new option_normal("opt_ctrl_keyboardgroundpound", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "dgroundpoundkey", arg0);
			global.option_groundpound_key = arg0;
		}, global.option_groundpound_key)];
		break;
	case OptionMenu.controller:
		backMenu = OptionMenu.controls;
		backOption = 2;
		alignCenter = false;
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPAD
		options = [toMainPage, new option_button("opt_ctrl_bindings", function()
		{
			if (!instance_exists(obj_option_keyconfig))
			{
				scr_input_varinit();
				
				with (instance_create(x, y, obj_option_keyconfig))
					gamepad = true;
			}
//PADDINGPADDINGPADDING
		}), new option_button("opt_ctrl_deadzones", function()
{
option_goto(OptionMenu.deadzones);
		}), new option_normal("opt_ctrl_controllersuperjump", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "dsjumpgp", arg0);
			global.option_sjump_gp = arg0;
//PADD
		}, global.option_sjump_gp), new option_normal("opt_ctrl_controllergroundpound", onOffToggle, function(arg0)
		{
			quick_write_option("Settings", "dgroundpoundgp", arg0);
			global.option_groundpound_gp = arg0;
		}, global.option_groundpound_gp)];
		break;
	case OptionMenu.deadzones:
		backMenu = OptionMenu.controller;
		backOption = 2;
		alignCenter = false;
		sliderSprite = spr_optionSlider;
		sliderIcon = spr_optionSliderIcon2;
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPADDINGPA
		options = [toMainPage, new option_slider("opt_ctrl_dz_gen", function(arg0)
		{
			global.deadzones[Deadzone.master] = arg0 / 100;
//
		}, function(arg0)
		{
			global.deadzones[Deadzone.master] = arg0 / 100;
			quick_write_option("Settings", "deadzoneMaster", global.deadzones[Deadzone.master]);
//PADDINGPA
		}, round(global.deadzones[Deadzone.master] * 100)), new option_slider("opt_ctrl_dz_vert", function(arg0)
		{
			global.deadzones[Deadzone.vertical] = arg0 / 100;
//
		}, function(arg0)
		{
			global.deadzones[Deadzone.vertical] = arg0 / 100;
			quick_write_option("Settings", "deadzoneVertical", global.deadzones[Deadzone.vertical]);
//PADDINGP
		}, round(global.deadzones[Deadzone.vertical] * 100)), new option_slider("opt_ctrl_dz_horiz", function(arg0)
		{
			global.deadzones[Deadzone.horizontal] = arg0 / 100;
//
		}, function(arg0)
		{
			global.deadzones[Deadzone.horizontal] = arg0 / 100;
			quick_write_option("Settings", "deadzoneHorizontal", global.deadzones[Deadzone.horizontal]);
//PADDINGPA
		}, round(global.deadzones[Deadzone.horizontal] * 100)), new option_slider("opt_ctrl_dz_press", function(arg0)
		{
			global.deadzones[Deadzone.press] = arg0 / 100;
//
		}, function(arg0)
		{
			global.deadzones[Deadzone.press] = arg0 / 100;
			quick_write_option("Settings", "deadzonePress", global.deadzones[Deadzone.press]);
//PADDINGPA
		}, round(global.deadzones[Deadzone.press] * 100)), new option_slider("opt_ctrl_dz_superjump", function(arg0)
		{
			global.deadzones[Deadzone.sjump] = arg0 / 100;
//
		}, function(arg0)
		{
			global.deadzones[Deadzone.sjump] = arg0 / 100;
			quick_write_option("Settings", "deadzoneSJump", global.deadzones[Deadzone.sjump]);
//PADDINGPA
		}, round(global.deadzones[Deadzone.sjump] * 100)), new option_slider("opt_ctrl_dz_crouchwalk", function(arg0)
		{
			global.deadzones[Deadzone.crouch] = arg0 / 100;
//
		}, function(arg0)
		{
			global.deadzones[Deadzone.crouch] = arg0 / 100;
			quick_write_option("Settings", "deadzoneCrouch", global.deadzones[Deadzone.crouch]);
		}, round(global.deadzones[Deadzone.crouch] * 100))];
		break;
}

trace("New Options");
trace(options);
