if !instance_exists(obj_option)
	exit;
draw_set_alpha(0.5);
draw_rectangle_color(-100, -100, 1060, 640, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
var timer = round((timeWait / timeWaitMax) * 5);
var selection_string = $"\n\n[{(optionSelection == 1) ? "c_gray" : "c_white"}]{lang_get("main_menu_yes")}         [{(optionSelection == 0) ? "c_gray" : "c_white"}]{lang_get("main_menu_no")}";
draw_text_scribble(480, 270, string_concat("[c_white][fa_middle][fa_center][fontDefault]", lang_get("opt_confirm", [string(timer)]), selection_string));
