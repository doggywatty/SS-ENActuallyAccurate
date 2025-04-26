var sID = ds_map_find_value(async_load, "id");
var sDict = ds_map_find_value(global.langSpritesAsync, sID);
trace($"Async Image Load :: {sID} for {sDict}");
ds_map_delete(global.langSpritesAsync, sID);
if is_undefined(sDict)
	exit;
var s = asset_get_index(sDict);
var sp = sprite_get_speed(s);
var spT = sprite_get_speed_type(s);
var xoff = sprite_get_xoffset(sID);
var yoff = sprite_get_yoffset(sID);
sprite_set_speed(sID, sp, spT);
ds_map_set(global.langSprites, s, sID);
ds_map_set(global.langSpriteKeys, sID, s);
trace($"Set localized sprite for {sDict}, ID: {sID}, Offset: ({xoff}, {yoff})");
lang_sprite_check_persistence(s, sID);
