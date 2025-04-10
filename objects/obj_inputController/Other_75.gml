var ev = ds_map_find_value(async_load, "event_type");
var gp = ds_map_find_value(async_load, "pad_index");
trace($"{ev} for gamepad {gp}");
switch ev
{
	case "gamepad discovered":
		if (gamepad_get_device_count() < 1)
			break;
		show_debug_message($"Found gamepad {gp}: {gamepad_get_description(gp)}");
		device_found = true;
		showtext = true;
		textflash = 5;
		break;
	case "gamepad lost":
		device_found = false;
		showtext = true;
		textflash = 5;
		break;
}
