if loaded
	exit;

if (array_length(groupArr) < 1)
	loaded = true;

if (fadealpha < 1 && !titleCard)
{
	alarm[0] = 1;
	exit;
}

var texArr = array_pop(groupArr);
if (texArr == undefined)
	exit;

loading_text = true;
for (var i = 0; i < array_length(texArr); i++)
{
	if !texture_is_ready(texArr[i])
		texture_prefetch(texArr[i]);
	array_push(global.loadedTextures, texArr[i]);
}

if (array_length(groupArr) < 1)
	show_debug_message("Loaded all textures from groupArr");

alarm[0] = 5;
