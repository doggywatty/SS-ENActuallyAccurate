if (text == "")
	exit;

draw_self();
var txt = scribble(text).starting_format(font_get_sprite(global.npcsmallfont, true)).blend(16777215, fade).wrap(250).align(1, 1);

if (image_xscale > 0)
	txt.draw(x + 6, y + 4);
else
	txt.draw(x - 6, y + 4);
