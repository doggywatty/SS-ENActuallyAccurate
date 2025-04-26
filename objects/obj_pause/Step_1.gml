scr_getinput_menu();
inputBufferUp = key_up2 ? 2 : max(inputBufferUp - 1, 0);
inputBufferDown = key_down2 ? 2 : max(inputBufferDown - 1, 0);

if (!global.gamePauseState && !instance_exists(obj_fadeoutTransition) && !instance_exists(obj_endlevelfade) && !instance_exists(obj_techdiff))
{
	if (!is_undefined(pausedSprite))
	{
		sprite_delete(pausedSprite);
		pausedSprite = undefined;
	}
	var _cant_pause = false;
	with obj_parent_player
	{
		if (state == States.victory && place_meeting(x, y, obj_startGate))
			_cant_pause = true;
	}
	with obj_judgmentpainter
	{
		if active
			_cant_pause = true;
	}
	if (!global.shellactivate && key_start2 && whitealpha <= 0 && room != rank_room && room != rm_introVideo && room != rm_mainmenu && room != timesuproom && room != rm_credits && room != rm_disclaimer && room != rm_startupLogo && room != rm_titlecard && room != mineshaft_elevator && !instance_exists(obj_titlecard) && !_cant_pause && canmove)
	{
		event_user(5);
		exit;
	}
	if (global.DebugMode != DebugType.None)
	{
		if (keyboard_check_pressed(vk_f11))
		{
			screenshot_surface = surface_create(960, 540);
			surface_set_target(screenshot_surface);
			draw_clear_alpha(c_black, 0);
			gpu_set_blendenable(false);
			draw_surface(application_surface, 0, 0);
			gpu_set_colorwriteenable(0, 0, 0, 1);
			draw_set_color(c_white);
			draw_rectangle(-192, -192, 1152, 732, 0);
			gpu_set_blendenable(true);
			gpu_set_colorwriteenable(1, 1, 1, 1);
			surface_reset_target();
			var file = get_save_filename_ext("screenshot|*.png", "", working_directory, "Save your Screenshot");
			if (file != "")
				surface_save(screenshot_surface, file);
		}
	}	
}

shake = approach(shake, 0, 1);

if global.gamePauseState
{
	if canmove
	{
		var key_move = sign(inputBufferDown) - sign(inputBufferUp);
		if (key_move != 0)
		{
			selected = wrap(selected + key_move, 0, array_length(pause_options) - 1);
			shake = 10 * key_move;
			inputBufferUp = 0;
			inputBufferDown = 0;			
			var _uid = fmod_createEventInstance("event:/SFX/ui/menuMove");
			var _note = global.MenuNoteArray[global.MenuNoteArraySelect];
			fmod_studio_event_instance_set_parameter_by_name(_uid, "note", _note, true);
			fmod_studio_event_instance_start(_uid);
			fmod_studio_event_instance_release(_uid);
			global.MenuNoteArraySelect++;
			global.MenuNoteArraySelect = wrap(global.MenuNoteArraySelect, 0, array_length(global.MenuNoteArray) - 1);
		}
		
		if key_jump
		{
			var entry = pause_options[selected];
			var mapentry = ds_map_find_value(pause_map, entry);
			if !is_undefined(mapentry)
				event_user(mapentry);
		}
		if (key_slap2 || key_start2)
			event_user(0);
	}
}

if global.gamePauseState
{
	whitealpha = ceil_ext(lerp(whitealpha, 0.3, 0.4), 100);
	borderscale = floor_ext(lerp(borderscale, 1, 0.3), 100);
	pauseslidein = floor(lerp(pauseslidein, 0, 0.2));
	if (borderscale <= 1)
	{
		for (var i = 0; i < 3; i++)
		{
			if (global.SecretsFound[i])
			{
				secretIconVisible[i] = true;
				secretIconScale[i] = lerp(secretIconScale[i], 1, 0.3);
			}
		}
	}
}
else
{
	whitealpha = floor_ext(lerp(whitealpha, 0, 0.3), 100);
	borderscale = ceil_ext(lerp(borderscale, 4, 0.2), 100);
	pauseslidein = ceil(lerp(pauseslidein, 500, 0.1));
	secretIconScale = [2, 2, 2];
	secretIconVisible = [0, 0, 0];
}
