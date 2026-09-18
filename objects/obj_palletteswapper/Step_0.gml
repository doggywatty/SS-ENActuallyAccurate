draw_set_font(global.smallfont);

if (obj_parent_player.paletteSelect < array_length(palnames[curchar]))
	palettename = palnames[curchar][obj_parent_player.paletteSelect];

if (drawing)
{
	if (bgblend != 1)
		bgblend += 0.1;
	
	if (fally != 0)
		fally += 60;
}
else
{
	if (bgblend != 0)
		bgblend -= 0.1;
	
	if (fally != -540)
		fally -= 60;
}

if (fally == 0)
{
	if (textblend != 1)
		textblend += 0.1;
}
else if (fally > 0)
{
	textblend = 0;
}
