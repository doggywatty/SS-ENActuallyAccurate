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
if (surface_exists(global.GameSurface))
	pausedSprite = sprite_create_from_surface(global.GameSurface, 0, 0, 960, 540, false, false, 0, 0);

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
