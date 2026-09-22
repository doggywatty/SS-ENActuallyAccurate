condition = function()
{
	return ds_list_find_index(global.SaveRoom, inst_25FFE16D) != -1;
};
//PADDIN
output = function()
{
	var lay_id = layer_get_id("Assets_1");
	var sprite_id = layer_sprite_get_id(lay_id, "graphic_7E6D6EB8");
	layer_sprite_change(sprite_id, spr_clocktowerexterior_candleDead);
};
