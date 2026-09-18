draw_set_font(global.smallnumberfont);
draw_set_halign(fa_center);

if (flash)
	gpu_set_fog(true, c_white, 0, 1);

draw_text_transformed_color(x, y, number, numberScale, numberScale, 0, image_blend, image_blend, image_blend, image_blend, 1);
gpu_set_fog(false, c_black, 0, 0);
