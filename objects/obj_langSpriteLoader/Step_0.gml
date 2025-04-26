buffer--;
if (ds_map_size(global.langSpritesAsync) < 1 && buffer < 1)
{
	lang_update_layers();
	instance_destroy();
}