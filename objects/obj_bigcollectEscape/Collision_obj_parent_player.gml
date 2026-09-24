if (global.panic || instance_exists(obj_sucroseTimer))
{
	event_play_multiple("event:/SFX/general/bellcollectbig", xorigin + (sprite_width / 2), yorigin + (sprite_height / 2));
	var val = 100;
	create_small_number(xorigin + (sprite_width / 2), yorigin + (sprite_height / 2), string(val));
	global.Collect += val;
	global.ComboTime = 60;
	create_collect_effect(x, y, sprite_index, val);
	instance_destroy();
}
