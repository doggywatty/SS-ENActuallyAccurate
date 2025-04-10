if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	var val = 10;
	create_small_number((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), string(val));
	create_collect_effect((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), undefined, val);
	global.Collect += val;
	global.PizzaMeter += 1;
	global.ComboFreeze = 15;
	global.ComboTime += 10;
}

event_inherited();
