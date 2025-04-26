if (event > 0)
	afterimagesetup();
else
	pal_swap_set(spr_rankpal, bgdex, 0);

draw_sprite_tiled_ext(lang_get_sprite(bg_rank), bgdex, bgx, bgy, 1, 1, c_white, bgAlpha);
shader_reset();

if (event > 0)
{
	afterimagesetup();
	if (sprite_index == spr_rankP || sprite_index == spr_rankPend)
		draw_rectangle(0, 0, 960, 540, false);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
	if (rank_text_sprite != -4 && floor(image_index) == (image_number - 1))
		draw_sprite_ext(rank_text_sprite, 0, x, y, 1, 1, 0, c_white, 1);
	shader_reset();
}
else
{
	draw_player_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
	if (rank_text_sprite != -4 && floor(image_index) == (image_number - 1))
		draw_sprite_ext(rank_text_sprite, 0, x, y, 1, 1, 0, c_white, 1);
}

draw_set_alpha(flash);
draw_rectangle(0, 0, 960, 540, false);
draw_set_alpha(1);

if event <= 0
	exit;

draw_sprite_ext(lang_get_sprite(spr_rankclipboard), 0, 716, 271 + clipboardY, 1, 1, 0, c_white, 1);
var i = 0;
var _text_scribble = "[c_red][fa_middle][fa_center][dialogfont]";
if combo_shown
{
	var _cx = 894;
	var _cy = 68 + clipboardY;
	draw_sprite_ext(spr_rankclipboard_stamp, 0, _cx, _cy, 1, 1, 0, c_white, 1);
	draw_text_scribble(_cx, _cy, $"{_text_scribble}{global.HighestCombo}");
}

if (damage_shown)
{
	var _dx = 894;
	var _dy = 142 + clipboardY;
	draw_sprite_ext(spr_rankclipboard_stamp, 1, _dx, _dy, 1, 1, 0, c_white, 1);
	draw_text_scribble(_dx, _dy, $"{_text_scribble}{global.LocalHurtCounter}");
}

draw_set_color(c_white);

for (var c = 0; c < array_length(confecti_sprites); c++)
{
	var _xx = 555 + (75 * c);
	var _yy = 230 + clipboardY;
	draw_sprite_ext(confecti_sprites[c], confecti_index[c], _xx, _yy, 1, 1, 0, c_white, 1);
}

for (var s = 0; s < array_length(secrets_collected_visual); s++)
{
	var _xx = 650 + (75 * s);
	var _yy = 325 + clipboardY;
	var _shk = secrets_shake[s];
	var _ind = s + (secrets_collected_visual[s] * 3);
	draw_sprite_ext(spr_rank_ink, _ind, irandom_range(_xx - _shk, _xx + _shk), irandom_range(_yy - _shk, _yy + _shk), secrets_scale[s], secrets_scale[s], 0, c_white, 1);
	secrets_scale[s] = approach(secrets_scale[s], 1, 0.25);
	secrets_shake[s] = approach(secrets_shake[s], 0, 0.1);
}

var _janx = 558;
draw_sprite_ext(spr_rankcake, score_cake_index, 500, 440 + clipboardY, 1, 1, 0, c_white, 1);
i = 0;
var _string = string(round(score_total_visual));
var _string_length = string_length(_string);

if (saved_total_string != _string)
{
	for (i = 0; i < _string_length; i++)
		score_total_colors[i] = choose(0, 1, 2, 3, 4, 5, 6);
	saved_total_string = _string;
}

draw_set_font(global.candleBigFont);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

for (i = 0; i < _string_length; i++)
{
	var _xx = (750 + ((string_width(_string) / _string_length) * i)) - (string_width(_string) / 2);
	var _yy = 385;
	var pal = score_total_colors[i];
	var _yyoffset = ((i % 2) == 0) ? -4 : 0;
	pal_swap_set(spr_palcandle, pal, false);
	draw_text(irandom_range(_xx - score_shake, _xx + score_shake), irandom_range(_yy - score_shake, _yy + score_shake) + _yyoffset + clipboardY, string_char_at(_string, i + 1));
}

shader_reset();
draw_sprite_ext(spr_rankletter, rankdex + 1, 725, 108 + clipboardY, 1, 1, 0, c_white, 1);

if (score_total_visual == score_total && global.NewHighScore)
	draw_sprite_ext(spr_highscore, score_highscore_index, 886, 450 + clipboardY, 1, 1, 0, c_white, 1);