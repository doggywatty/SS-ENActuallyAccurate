if (global.gamePauseState && !is_undefined(pausedSprite))
{
	gpu_set_blendenable(false);
	draw_sprite_stretched_ext(pausedSprite, 0, 0, 0, 960, 540, c_white, 1);
	gpu_set_blendenable(true);
}

var is_not_level = global.InternalLevelName == "none";
draw_set_alpha(whitealpha);
draw_rectangle_color(-5000, 0, 5000, 1080, #0D001B, #0D001B, #0D001B, #0D001B, false);
draw_set_alpha(1);
draw_sprite_ext(pauseBorder, is_not_level, 480, 270, borderscale, borderscale, 0, c_white, 1);

if !is_not_level
{
	draw_sprite_ext(spr_newpause_secreticon, 0, 804, 64, secretIconScale[0], secretIconScale[0], 0, c_white, secretIconVisible[0]);
	draw_sprite_ext(spr_newpause_secreticon, 1, 855, 54, secretIconScale[1], secretIconScale[1], 0, c_white, secretIconVisible[1]);
	draw_sprite_ext(spr_newpause_secreticon, 2, 906, 70, secretIconScale[2], secretIconScale[2], 0, c_white, secretIconVisible[2]);
}

draw_set_font(global.fontDefault);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
var bar_x_offsets = [507, 495, 478, 460, 443];
var bar_y_offsets = [103, 177, 249, 324, 396];
var bar_text = [
	lang_get("pause_resume"), lang_get("pause_options"),
	lang_get("pause_retry"), lang_get("pause_tasks"),
	lang_get("pause_exit")
];
var bar_sprite = asset_get_index("spr_newpause_bars" + string(selected + 1));
var _length = array_length(pause_options);

for (var i = 0; i < _length; i++)
{
	var y_pad = 73;
	var x_pos = lerp(507, 443, i / (_length - 1));
	var y_pos = ((camera_get_view_height(view_camera[0]) / 2) - round((y_pad * (_length - 1)) / 2)) + (y_pad * i);
	var current_bar_chosen = selected == i;
	var current_bar_x = x_pos - (pauseslidein * (2 + (i / 2)));
	var _txt = lang_get(pause_options[i]);
	draw_sprite_ext(bar_sprite, current_bar_chosen, current_bar_x, y_pos + (shake * current_bar_chosen), 1, 1, 0, c_white, 1);
	var entry = pause_options[selected];
	var mapentry = ds_map_find_value(pause_map, entry);
	if !is_undefined(mapentry)
		draw_sprite_ext(spr_newpause_icons, mapentry, current_bar_x + random_range(-1, 1) + 117, y_pos + random_range(-1, 1), 1, 1, 0, c_white, current_bar_chosen);
	var _max_length = 300;
	if (string_width(_txt) > _max_length)
		draw_set_font(global.smallfont);
	else
		draw_set_font(global.fontDefault);
	draw_text_color(current_bar_x - 20, y_pos + (shake * current_bar_chosen), _txt, c_gray, c_gray, c_gray, c_gray, 1);
	draw_text_color(current_bar_x - 20, y_pos + (shake * current_bar_chosen), _txt, c_white, c_white, c_white, c_white, current_bar_chosen);
}
if !is_not_level
	draw_sprite(lang_get_sprite(spr_newpause_treasure), global.Treasure, 835 + pauseslidein, 400);
if (global.gamePauseState == 1)
{
	draw_sprite_ext_flash(playerPauseSprite, playerPauseIndex, 100 - pauseslidein, 422 + pauseslidein, 1, 1, 0, #30164f, 1);
	draw_player_sprite_ext(playerPauseSprite, playerPauseIndex, 107 - pauseslidein, 411 + pauseslidein, 1, 1, 0, c_white, 1);
}

if (global.gamePauseState && round(borderscale) >= 1)
	scribble($"[pPrompt][wave]{lang_get(global.TransfoPrompt)}").align(1, 1).draw(480, 500);
