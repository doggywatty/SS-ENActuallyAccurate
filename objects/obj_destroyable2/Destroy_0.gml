if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	with (instance_create((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), obj_puffEffect))
	{
		image_speed = 0.3;
		sprite_index = spr_smallbreak2_dead;
	}
	event_play_multiple("event:/SFX/general/breakblock", x, y);
	event_play_multiple("event:/SFX/general/collect", x, y);
	var val = 10;
	create_small_number((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), string(val));
	create_collect_effect((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), undefined, val);
	global.Collect += val;
	global.PizzaMeter += 1;
	global.ComboFreeze = 15;
	global.ComboTime += 10;
	ds_list_add(global.SaveRoom, id);
}
