draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(-64, -64, 1024, 604, false);
draw_set_alpha(1);
draw_set_color(c_white);
var _text = "main_menu_leavegame";
var _string = string($"[c_white][spr_fileBye,{image_index}][spr_font][c_white][fa_center][fa_middle]{lang_get(_text)}[c_white][spr_fileBye,{image_index}]\n[{(optionSelection == 1) ? "c_gray" : "c_white"}]{lang_get("main_menu_yes")}         [{(optionSelection == 0) ? "c_gray" : "c_white"}]{lang_get("main_menu_no")}");
draw_text_scribble(480, 270, _string);
