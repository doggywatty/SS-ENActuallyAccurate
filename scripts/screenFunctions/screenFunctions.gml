function surface_prepare_aa_filter(tex)
{
	var surf_tex = surface_get_texture(tex);
	var tw = texture_get_texel_width(surf_tex);
	var th = texture_get_texel_height(surf_tex);
	shader_set(shd_pixelscale);
	gpu_set_texfilter(true);
	shader_set_uniform_f_array(uRes, sRes);
}

function calculate_letterbox_params()
{
	var res_w = window_get_width();
	var res_h = window_get_height();
	var res_scale = min(res_w / 16, res_h / 9);
	res_w = 16 * res_scale;
	res_h = 9 * res_scale;
	var screen_x = 0;
	var screen_y = 0;
	var scale_w = 1;
	var scale_h = 1;
	var scale = 1;
	if (global.Letterbox && (res_w >= 960 && res_h >= 540))
	{
		var target_w = floor(res_w / 960);
		var target_h = floor(res_h / 540);
		var target_scale = min(target_w, target_h);
		scale_w = (target_scale * 960) / res_w;
		scale_h = (target_scale * 540) / res_h;
		scale = min(scale_w, scale_h);
		screen_x = (res_w - (target_scale * 960)) / 2;
		screen_y = (res_h - (target_scale * 540)) / 2;
		screen_x *= scale;
		screen_y *= scale;
	}
	return 
	{
		screen_x: screen_x,
		screen_y: screen_y,
		scale: scale,
		scale_w: scale_w,
		scale_h: scale_h
	};
}

function set_fullscreen_option(val)
{
	var previous_val = global.fullscreen;
	global.fullscreen = val;
	with obj_screen
		alarm[0] = 1;
	option_create_confirm(previous_val, function(val)
	{
		quick_write_option("Settings", "fullscrn", global.fullscreen);
	}, function(val)
	{
		global.fullscreen = val;
		with obj_screen
			alarm[0] = 1;
	});
}