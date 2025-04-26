loading_text = true;
var t = array_pop(global.loadedTextures);
if !is_undefined(t)
	texture_flush(t);
if (array_length(global.loadedTextures) < 1)
{
	show_debug_message("Flushed Loaded Textures");
	unloaded = true;
	exit;
}
alarm[1] = 1;
