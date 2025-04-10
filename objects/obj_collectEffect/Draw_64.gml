__display_set_gui_size_hook(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));

if use_palette
    pal_swap_set(spr_collect_palette, col, 0);

draw_sprite_ext(sprite_index, -1, drawx, drawy, drawxscale, drawyscale, 0, c_white, image_alpha);
pal_swap_reset();
__display_set_gui_size_hook(960, 540);
