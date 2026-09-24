if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	create_small_number(xorigin + (sprite_width / 2), yorigin + (sprite_height / 2), "50");
	global.Collect += 50;
	global.PizzaMeter += 1;
	global.ComboTime += 20;
}
