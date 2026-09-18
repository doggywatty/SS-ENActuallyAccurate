draw_self();

if (wetTimer > 0)
	draw_sprite_ext_duotone(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, 1601784, 0, image_alpha * 0.75 * (wetTimer / wetTimerMax));
