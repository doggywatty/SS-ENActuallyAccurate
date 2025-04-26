surface_reset_target();
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
var do_letterbox = false;
if (global.Letterbox && (res_w >= 960 && res_h >= 540))
{
	do_letterbox = true;
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

if (global.TextureFiltering && !do_letterbox && ((res_w % 960) > 0 || (res_h % 540) > 0))
	surface_prepare_aa_filter(global.GameSurface);

draw_clear_alpha(c_black, 1);
draw_sprite_tiled_ext(bgSprite.sprite_index, bgSprite.image_index, screen_x, screen_y, scale, scale, c_white, 1);

for (var i = 0; i < ds_list_size(bgSpriteOld); i++)
{
	var bg = ds_list_find_value(bgSpriteOld, i);
	draw_sprite_tiled_ext(bg.sprite_index, bg.image_index, screen_x, screen_y, scale, scale, c_white, bg.image_alpha);
}

if global.Letterbox
{
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_rectangle(screen_x - 1, screen_y - 1, screen_x + (960 * scale), screen_y + (540 * scale), false);
}

if (surface_exists(global.GameSurface))
{
	gpu_set_blendenable(false);
	draw_surface_ext(global.GameSurface, screen_x, screen_y, scale, scale, 0, c_white, 1);
	gpu_set_blendenable(true);
}

gpu_set_blendenable(true);
gpu_set_blendmode(bm_normal);
gpu_set_texfilter(false);
shader_reset();
gameframe_draw();
