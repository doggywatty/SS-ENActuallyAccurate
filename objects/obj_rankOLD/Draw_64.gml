if goup
	afterimagesetup();
else
	pal_swap_set(rankpal, bgdex, 0);

draw_sprite_tiled_ext(bgspr, bgdex, bgx, bgy, 1, 1, c_white, totalalpha);
shader_reset();
if goup
{
	afterimagesetup();
	if (sprite_index == spr_rankP)
		draw_rectangle(0, 0, 960, 540, false);
	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
	shader_reset();
}
else
	draw_player_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);

draw_set_alpha(flash);
draw_rectangle(0, 0, 960, 540, false);
draw_set_alpha(1);
draw_sprite_ext(lang_get_sprite(spr_rankclipboard), 0, 716, 271 + clipy, 1, 1, 0, c_white, 1);

var i = 0;
var _string = round(string(global.HighestCombo));
var _string_length = string_length(_string);
draw_set_font(global.rankcombofont);
draw_set_alpha(totalalpha);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
for (i = 0; i < _string_length; i++)
{
	var _xx = 850 + ((30 * i) - (string_width(_string) / 2));
	var _yyoffset = ((i % 2) == 0) ? -4 : 0;
	draw_text(_xx, 105 + clipy, string_char_at(_string, i + 1));
	shader_reset();
}

draw_sprite_ext(card1spr, carddex1, 649 + (cshake1 ? irandom_range(-2, 2) : 0), 325 + (cshake1 ? irandom_range(-2, 2) : 0) + clipy, 1, 1, 0, c_white, 1);
draw_sprite_ext(card2spr, carddex2, 723 + (cshake2 ? irandom_range(-2, 2) : 0), 325 + (cshake2 ? irandom_range(-2, 2) : 0) + clipy, 1, 1, 0, c_white, 1);
draw_sprite_ext(card3spr, carddex3, 798 + (cshake3 ? irandom_range(-2, 2) : 0), 327 + (cshake3 ? irandom_range(-2, 2) : 0) + clipy, 1, 1, 0, c_white, 1);
var _janx = 558;
if (otherjandraw == 1)
{
	_janx = 585;
	draw_sprite_ext(otherjanspr, 0, 506, 88 + clipy, otherjanscale, otherjanscale, 0, c_white, 1);
}

if (jandraw == 1)
	draw_sprite_ext(janspr, 0, _janx, 88 + clipy, janscale, janscale, 0, c_white, 1);

draw_sprite_ext(spr_confecti1rank, mallowspr, 514 + (shake1 ? irandom_range(-2, 2) : 0), 190 + (shake1 ? irandom_range(-2, 2) : 0) + clipy, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_confecti2rank, chocospr, 594 + (shake2 ? irandom_range(-2, 2) : 0), 186 + (shake2 ? irandom_range(-2, 2) : 0) + clipy, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_confecti3rank, crackspr, 677 + (shake3 ? irandom_range(-2, 2) : 0), 187 + (shake3 ? irandom_range(-2, 2) : 0) + clipy, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_confecti4rank, wormspr, 754 + (shake4 ? irandom_range(-2, 2) : 0), 195 + (shake4 ? irandom_range(-2, 2) : 0) + clipy, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_confecti5rank, candyspr, 828 + (shake5 ? irandom_range(-2, 2) : 0), 199 + (shake5 ? irandom_range(-2, 2) : 0) + clipy, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_rankcake, cakedex, 499 + (pshake ? irandom_range(-4, 4) : 0), 430 + (pshake ? irandom_range(-2, 2) : 0) + clipy, 1, 1, 0, c_white, 1);
i = 0;
_string = string(round(countpoint));
_string_length = string_length(_string);
if (collected != _string)
{
	for (i = 0; i < _string_length; i++)
		colors[i] = choose(0, 1, 2, 3, 4, 5, 6);
	collected = _string;
}

var pal = colors[i];
draw_set_font(global.candlefont);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
for (i = 0; i < _string_length; i++)
{
	var _xx = ((pshake ? irandom_range(-4, 4) : 0) + 750 + ((string_width(_string) / _string_length) * i)) - (string_width(_string) / 2);
	var _yy = (pshake ? irandom_range(-4, 4) : 0) + 385;
	pal = colors[i];
	var _yyoffset = ((i % 2) == 0) ? -4 : 0;
	pal_swap_set(spr_palcandle, pal, false);
	draw_text(_xx, _yy + _yyoffset + clipy, string_char_at(_string, i + 1));
	shader_reset();
}

draw_sprite_ext(spr_rankletter, rankdex, 725, 108 + clipy, rscale, rscale, 0, c_white, 1);
if (stampani == 1)
	draw_sprite_ext(spr_rankstamp, stampdex, 480, 270 + clipy, 1, 1, 0, c_white, 1);
