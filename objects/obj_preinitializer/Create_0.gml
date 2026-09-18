scr_gameInit();
depth = 5;
draw_flush();
randomize();
window_center();
var temparray = ["Player", "Baddies", "HUD", "Structure", "Hub", "effectsGroup", "titleGroup"];
textureLoaderList = ds_list_create();

for (var i = 0; i < array_length(temparray); i++)
	ds_list_set(textureLoaderList, i, texturegroup_get_textures(temparray[i]));

DslistMax = ds_list_size(textureLoaderList);
alarm[0] = 3;
rareRoach = chance(2);
loadSpriteCount = sprite_get_number(spr_bodyloadbar) - 1;
imageIndexArray = array_create(loadSpriteCount + 1, 0);
global.texturesToLoad = [];
global.loadedTextures = [];
texture_debug_messages(true);
