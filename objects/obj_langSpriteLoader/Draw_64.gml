if !instance_exists(obj_option)
	exit;
draw_set_alpha(0.5);
draw_rectangle_color(-100, -100, 1060, 640, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
draw_text_scribble(480, 270, string_concat("[c_white][fa_middle][fa_center][global.creditsfont]", lang_get("loadingSprites")));
