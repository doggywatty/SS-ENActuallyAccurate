if (obj_hudManager.HUDObject_tooltipPrompts.image_alpha > 0)
{
	showTextBuffer = 200;
	newdraw_y = approach(newdraw_y, 600, 2);
	exit;
}

if (showTextBuffer-- <= 0)
	showtext = false;

if (showtext)
	newdraw_y = approach(newdraw_y, 500, 5);
else
	newdraw_y = approach(newdraw_y, 600, 1);
