if (fadein)
{
	draw_sprite(lang_get_sprite(spr_titlecards), info.image_index, 0, 0);
	draw_sprite(lang_get_sprite(spr_titlecards_title), info.image_index, irandom_range(-1, 1), irandom_range(-1, 1));
	
	var drawSignature = signatureShow && info.x != -4 && info.y != -4;
	if drawSignature
	{
		draw_sprite_ext(spr_titlecardsignature, signatureStage, info.x, info.y, 1, 1, 0, c_white, 1);
		signatureStage = approach(signatureStage, 8, 0.35);
		for (var i = 0; i < ds_list_size(global.particleList); i++)
		{
			var b = ds_list_find_value(global.particleList, i);
			with b
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		}
	}
}

draw_set_alpha(fadealpha);
draw_rectangle_color(0, 0, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]), c_black, c_black, c_black, c_black, 0);
draw_set_alpha(1);
