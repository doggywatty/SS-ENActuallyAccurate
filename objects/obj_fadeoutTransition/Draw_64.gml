draw_set_alpha(fadealpha);
draw_set_color(c_black);
draw_rectangle(-64, -64, 1024, 604, false);
draw_set_alpha(1);
draw_set_color(c_white);

if (loading_text && !loaded)
	draw_text_scribble(952, 532, $"[fa_right][fa_bottom][c_white][fontDefault]{lang_get("loadingGeneric")}");