draw_self();
draw_set_font(global.npcsmallfont);
var txt = "";
var use_typist = undefined;
if !buffering
	txt = idleThoughts[idleThought];
else
{
	txt = bufferThought;
	if usePaletteThought
	{
		txt += " ";
		txt += paletteThoughts[savedPaletteIndex];
	}
	use_typist = typist;
}

var text = scribble(txt);
text.starting_format(font_get_sprite(global.npcsmallfont, true));
text.blend(c_white, fade);
text.wrap(250);
text.align(1, 1);
text.draw(x - 2, y + 4, use_typist);
