if (!global.ShowHUD)
	exit;

draw_set_font(global.MoneyFont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed_color(x, y + obj_camera.cakeHud.y, number, 1, 1, 0, image_blend, image_blend, image_blend, image_blend, image_alpha);
