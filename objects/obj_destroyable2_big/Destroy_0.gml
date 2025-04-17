if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	with (instance_create((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), obj_puffEffect))
	{
		image_speed = 0.3;
		sprite_index = spr_bigbreak2_dead;
	}
	event_play_multiple("event:/SFX/general/breakblock", x, y);
	event_play_multiple("event:/SFX/general/collect", x, y);
	var val = 100;
	create_small_number((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), string(val));
	var vis_val = floor(val / 10);
	repeat vis_val
		create_collect_effect((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2),, vis_val);
	global.ComboFreeze = 15;
	global.ComboTime += 45;
	global.Collect += val;
	global.PizzaMeter += 5;
	ds_list_add(global.SaveRoom, id);
}
