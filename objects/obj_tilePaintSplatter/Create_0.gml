depth = 90;
image_speed = 0.4;
scale = 0.15;
random_set_seed(global.RandomSeed + x + y);
if is_undefined(blendColor)
	blendColor = choose(#58c000, #cc297a, #30a8f8, #e03000);

image_index = irandom_range(0, 6) * 3;
end_image_index = image_index + 2;
angle = choose(0, 90, 180, 270);
random_set_seed(global.RandomSeed);
splatSurface = -4;
if createSplash
{
	create_particle((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), spr_paintSplash, undefined, undefined, undefined, 
	{
		image_blend: blendColor
	});
}
tileLayerArr = [];

var all_layers = layer_get_all();
for (var i = 0; i < array_length(all_layers); i++)
{
	var is_not_secret = true;
	var tile_id = layer_tilemap_get_id_fixed(all_layers[i]);
	for (var ii = 0; ii < array_length(global.secret_layers); ii++)
	{
		if (global.secret_layers[ii].id == all_layers[i])
		{
			is_not_secret = false;
			break;
		}
	}
	if (tile_id != -1 && is_not_secret)
		tileLayerArr[i] = all_layers[i];
}

array_sort(tileLayerArr, function(layerId_1, layerId_2)
{
	return -(layer_get_depth(layerId_1) - layer_get_depth(layerId_2));
});
