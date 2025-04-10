var t = array_pop(global.loadedTextures);
if !is_undefined(t)
	texture_flush(t);
var s = array_pop(global.langSpritesTemp);
if !is_undefined(s)
	sprite_delete(s);

if (array_length(global.loadedTextures) < 1 && array_length(global.langSpritesTemp) < 1)
{
	show_debug_message("Flushed Loaded Textures");
	unloaded = true;
	exit;
}

alarm[1] = 1;
