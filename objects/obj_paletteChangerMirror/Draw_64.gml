if !global.ShowHUD
	exit;

var lang_key = global.CharacterPalette[global.playerCharacter].palettes[global.PlayerPaletteIndex].palName;
var lang_key_desc = lang_get($"{lang_key}_desc");
var scrib = scribble($"[fa_center][spr_promptfont][fa_bottom][alpha,{alpha}]{lang_get(lang_key)}\n{lang_key_desc}");
scrib.wrap(camera_get_view_width(view_camera[0]) - 200);
scrib.draw(480, 524);
