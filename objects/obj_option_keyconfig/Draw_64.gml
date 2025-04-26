draw_set_font(global.fontDefault);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(c_white);
var s = selected;
var c_hover = (s == -1) ? c_white : c_gray;
draw_text_color(32, 50, lang_get("opt_back"), c_hover, c_hover, c_hover, c_hover, 1);
var dx = 352;
var pady = 0;
var target_scroll = 0;
for (var i = 0; i < array_length(inputs); i++)
{
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var ci = inputs[i];
	c_hover = (s == i) ? c_white : c_gray;
	var dy = (128 + (i * scroll_pad) + pady) - scroll_y;
	pady += ((gamepad ? 48 : 32) * (ci.lineCount - 1));
	if (i == s)
		target_scroll = dy + pady + 64 + (8 * i);
	if (ci.iconIndex > -1)
		draw_sprite_ext(spr_optionBindings, ci.iconIndex, dx, dy, 1, 1, 0, c_hover, 1);
	else
		scribble(ci.text).align(0, 1).starting_format(font_get_name(global.fontDefault), c_hover).wrap(300).draw(dx - 16, dy);

	ci.draw(928, dy, c_hover);
}

scroll_y = round(lerp(scroll_y, target_scroll, 0.1));
if (reading || exiting)
{
	draw_set_alpha(0.5);
	draw_rectangle_color(0, 0, 960, 540, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	if reading
		draw_text_color(480, 270, lang_get("opt_keyconfig_inputprompt"), c_white, c_white, c_white, c_white, 1);
	else
	{
		scribble(lang_get("opt_keyconfig_cancel")).starting_format(font_get_name(global.fontDefault), (select2 == 0) ? c_white : c_gray).align(1, 1).draw(480, 135);
		scribble(lang_get("opt_keyconfig_deny")).starting_format(font_get_name(global.fontDefault), (select2 == 1) ? c_white : c_gray).align(1, 1).draw(480, 270);
		scribble(lang_get("opt_keyconfig_save")).starting_format(font_get_name(global.fontDefault), (select2 == 2) ? c_white : c_gray).align(1, 1).draw(480, 405);
	}
}
else
{
	draw_set_alpha(1);
	var ty = 415;
	var menu_text = [lang_get("opt_keyconfig_bind"), lang_get("opt_keyconfig_clear"), lang_get("opt_keyconfig_reset")];
	menu_text[0] += $": [c_white]{get_control_sprite(gamepad ? "menuconfirmC" : "menuconfirm")}";
	menu_text[1] += $": [c_white]{get_control_sprite(gamepad ? "menudeleteC" : "menudelete")}";
	menu_text[2] += ": [c_white][spr_key_empty][keyDrawFont][offset,-23,0]F1[offsetPop]";
	var final_text = $"{menu_text[0]}\n{menu_text[1]}\n{menu_text[2]}";
	scribble(final_text).starting_format(font_get_name(global.fontDefault), c_white).align(0, 1).line_spacing(gamepad ? "125%" : "150%").draw(25, ty);
}
