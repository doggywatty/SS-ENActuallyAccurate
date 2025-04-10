if (global.panic || instance_exists(obj_sucroseTimer))
{
	var val = 10;
	event_play_multiple("event:/SFX/general/bellcollect", (x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2));
	create_small_number((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), string(val));
	global.Collect += val;
	global.ComboTime += 10;
	create_collect_effect(x, y, sprite_index, val, col);
	instance_destroy();
}
