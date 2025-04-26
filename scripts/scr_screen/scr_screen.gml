function screen_draw_app_surf()
{
	var use_shader = false;
	var shader = -4;
	var appa = 1;
	if !global.gamePauseState
	{
		if (global.panic && global.EscapeTime <= 3600)
			shader = shd_greyscale;
		else
			shader = -4;
	}
	if !global.gamePauseState
	{
		surface_set_target(finalApplicationSurface);
		shader_set(shd_premulti);
		var fade = shader_get_uniform(shd_premulti, "fade");
		shader_set_uniform_f(fade, global.greyscalefade);
		gpu_set_blendmode_ext(bm_max, bm_inv_src_alpha);
		draw_surface_stretched_ext(application_surface, 0, 0, 960, 540, c_white, appa);
		gpu_set_blendmode(bm_normal);
		shader_reset();
		surface_reset_target();
	}
	if global.TextureFiltering
	{
		surface_prepare_aa_filter(finalApplicationSurface);
		use_shader = true;
	}
	
	surface_set_target(guiSurface);
	draw_clear_alpha(c_black, 1);
	gpu_set_blendenable(false);
	draw_surface_ext(finalApplicationSurface, 0, 0, 1, 1, 0, c_white, 1);
	gpu_set_blendenable(true);
	if use_shader
		shader_reset();
}

function screen_draw_gui_surf()
{
	if !surface_exists(guiSurface)
	{
		gpu_set_blendmode(bm_normal);
		exit;
	}
	
	var use_shader = false;
	if global.TextureFiltering
	{
		surface_prepare_aa_filter(guiSurface);
		use_shader = true;
	}
	
	draw_surface_ext(guiSurface, 0, 0, 1, 1, 0, c_white, 1);
	if use_shader
		shader_reset();
}
