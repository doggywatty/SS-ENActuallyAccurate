__display_set_gui_size_hook(960, 540);
if !surface_exists(global.GameSurface)
	global.GameSurface = surface_create(960, 540);

surface_set_target(global.GameSurface);
draw_clear_alpha(c_black, 0);
gpu_set_blendenable(false);
draw_surface_stretched_ext(application_surface, 0, 0, 960, 540, c_white, 1);
gpu_set_blendenable(true);
