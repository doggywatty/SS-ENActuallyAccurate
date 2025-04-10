var load_sprite_count = sprite_get_number(spr_bodyloadbar);
var load_progress = 1 - (ds_list_size(textureLoaderList) / DslistMax);
var img_ind = load_progress * load_sprite_count;

for (var i = 0; i < img_ind; i++)
{
	imageIndexArray[i] = approach(imageIndexArray[i], 1, 1);
	if ((i <= 0 && rareRoach) || i > 0)
		draw_sprite_ext(spr_bodyloadbar, i, 0, 0, 1, 1, 0, c_white, imageIndexArray[i]);
}

draw_sprite(spr_bodyloadbaroutline, 0, 0, 0);
