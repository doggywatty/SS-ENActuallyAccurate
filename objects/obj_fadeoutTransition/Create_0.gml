fadealpha = 0;
fadein = 0;
fadespeed = 0.1;
gotonoplayer = 0;
loaded = false;
unloaded = false;
loading_text = false;
titleCard = false;
groupArr = [];

while (array_length(global.texturesToLoad) > 0)
{
	var t = array_pop(global.texturesToLoad);
	if !is_undefined(t)
		array_push(groupArr, texturegroup_get_textures(t));
}

if goToHub
	alarm[1] = 1;
else
	unloaded = true;

alarm[0] = 5;
depth = -998;
