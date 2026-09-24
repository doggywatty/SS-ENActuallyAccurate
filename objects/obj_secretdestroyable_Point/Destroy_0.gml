if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	var val = 10;
	create_small_number(xorigin + (sprite_width / 2), yorigin + (sprite_height / 2), string(val));
	create_collect_effect(xorigin + (sprite_width / 2), yorigin + (sprite_height / 2), , val);
	global.Collect += val;
	global.PizzaMeter += 1;
	global.ComboTime += 10;
}

event_inherited();
