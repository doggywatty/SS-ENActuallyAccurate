if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	var val = 100;
	create_small_number((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), string(val));
	repeat val / 10
		create_collect_effect((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2),, val);
	global.ComboFreeze = 2;
	global.ComboTime += 45;
	global.Collect += val;
	global.PizzaMeter += 5;
}

event_inherited();
