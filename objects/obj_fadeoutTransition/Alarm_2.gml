if (!((variable_global_exists("langSpritesTemp") && array_length(global.langSpritesTemp) > 0)
&& (titleCard || goToHub)))
{
	lang_flushed = true;
	exit;
}

if (fadealpha < 1 && !titleCard)
{
	alarm[2] = 1;
	exit;
}

loading_text = true;
var toDelete = max(15, ceil(array_length(global.langSpritesTemp) / 15));
repeat toDelete
{
	var s = array_pop(global.langSpritesTemp);
	if !is_undefined(s)
		sprite_delete(s);
}

if (array_length(global.langSpritesTemp) < 1)
{
	show_debug_message("Flushed Old Lang Textures");
	lang_flushed = true;
	exit;
}
alarm[2] = 1;