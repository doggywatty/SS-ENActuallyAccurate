var lay_id = layer_get_id("Backgrounds_spire");
var back_id = layer_background_get_id_fixed(lay_id);
layer_background_index(back_id, 1);
if (ds_list_find_index(global.SaveRoom, id) == -1)
{
	var rep = 3 + round(sprite_width / 16);
	repeat rep
		create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_blockdebris);
	event_play_multiple("event:/SFX/player/break", x, y);
	ds_list_add(global.SaveRoom, id);
}
