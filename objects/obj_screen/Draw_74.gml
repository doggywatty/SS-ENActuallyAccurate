var surfW = 960;
var surfH = 540;
var guiW = display_get_gui_width();
var guiH = display_get_gui_height();
if (!surface_exists(finalApplicationSurface))
	finalApplicationSurface = surface_create(960, 540);
if (!surface_exists(guiSurface))
	guiSurface = surface_create(guiW, guiH);
if (surface_get_width(guiSurface) != guiW || surface_get_height(guiSurface) != guiH)
	surface_resize(guiSurface, guiW, guiH);

screen_draw_app_surf();
