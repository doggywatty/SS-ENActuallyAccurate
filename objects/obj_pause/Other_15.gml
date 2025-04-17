global.gamePauseState = 1;
selected = 0;

switch global.playerCharacter
{
	case Characters.Pizzelle:
	default:
		playerPauseSprite = spr_pizzelle_pause;
		break;
}

var guiObjects = [obj_camera, obj_hudManager];
if !global.option_speedrun_timer
	array_push(guiObjects, obj_gametimer);
if (instance_exists(obj_screen) && surface_exists(obj_screen.guiSurface))
	pausedSprite = sprite_create_from_surface(obj_screen.guiSurface, 0, 0, 960, 540, false, false, 0, 0);
else
{
	if !surface_exists(pauseSurface)
		pauseSurface = surface_create(960, 540);
	surface_set_target(pauseSurface);
	for (var i = 0; i < array_length(guiObjects); i++)
	{
		with guiObjects[i]
		{
			if (visible)
				event_perform(ev_draw, ev_gui);
		}
	}
	surface_reset_target();
	pausedSprite = sprite_create_from_surface(pauseSurface, 0, 0, 960, 540, false, false, 0, 0);
	surface_free(pauseSurface);
}

playerPauseIndex = irandom_range(0, sprite_get_number(playerPauseSprite) - 1);
scr_pause_instances(true);
fmod_studio_event_instance_start(pauseMusic);
fmod_studio_event_instance_set_paused(pauseMusic, false);
fmod_studio_event_instance_set_parameter_by_name(pauseMusic, "state", 0, false);
canmove = true;
alarm[0] = 1;

var opt_arr = ["pause_resume", "pause_options"];
if (global.InternalLevelName != "none")
	array_push(opt_arr, "pause_retry");
array_push(opt_arr, "pause_tasks");
if (global.InternalLevelName != "none")
	array_push(opt_arr, "pause_exit");
else
	array_push(opt_arr, "pause_menu");

pause_options = opt_arr;
pausecount = 29;
