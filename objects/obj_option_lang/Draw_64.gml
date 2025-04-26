if !instance_exists(obj_option)
	exit;
draw_sprite_ext(lang_get_sprite(spr_lang_flag), 0, x, y - 64, 1, 1, 0, c_white, 1);
draw_text_scribble(x, y, $"[fa_middle][fa_center][c_white][fontDefault]{string_upper(lang_get("language"))}");
for (var i = 0; i < array_length(menuArrow); i++)
{
	with (menuArrow[i])
		draw(x + offSet, other.y, 1, 1, 0, c_white, 1);
}
