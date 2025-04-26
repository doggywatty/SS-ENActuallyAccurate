draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(-64, -64, 1024, 604, false);
draw_set_alpha(1);
draw_set_color(c_white);
var _sprite = spr_fileDelete_snore;
if (deleteFileBuffer > 0)
	_sprite = spr_fileDelete_unlit;
if (deleteFileBuffer > (deleteFileBufferMax / 2))
	_sprite = spr_fileDelete;

var _text = "main_menu_filedelete";
var _filenum = string(other.selectedFile + 1);
var circle_visual = $"[{sprite_get_name(spr_holdCircle)},{(deleteFileBuffer / deleteFileBufferMax) * sprite_get_number(spr_holdCircle)}]";
var _string = $"[c_white][{sprite_get_name(_sprite)},{image_index}][fontDefault][c_red][fa_center][fa_middle]{lang_get(_text, [_filenum])}[c_white][{sprite_get_name(_sprite)},{image_index}]\n[{(optionSelection == 1) ? "c_gray" : "c_white"}]{lang_get("main_menu_yes")}{circle_visual}         [{(optionSelection == 0) ? "c_gray" : "c_white"}]{lang_get("main_menu_no")}";
draw_text_scribble(480, 270, _string);
