if (!window_has_focus() || !variable_global_exists("fullscreen"))
{
	alarm[0] = 1;
	exit;
}

switch global.fullscreen
{
	case 0:
		gameframe_set_fullscreen(0);
		break;
	case 1:
		gameframe_set_fullscreen(2);
		alarm[1] = 1;
		break;
	case 2:
		gameframe_set_fullscreen(2);
		break;
}

set_resolution_option(global.selectedResolution);
