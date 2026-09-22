palette_as_player();
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, draw_angle, c_white, image_alpha * draw_alpha);
pal_swap_reset();
draw_sprite_ext_flash(sprite_index, image_index, x, y, image_xscale, image_yscale, draw_angle, #FF8BDC, image_alpha * draw_alpha);
