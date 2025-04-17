var cam_width = camera_get_view_width(view_camera[0]);
var cam_height = camera_get_view_height(view_camera[0]);
var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
var c = view_camera[0];
if sucrose_lighting
{
	if (sucrose_lighting && !surface_exists(sucroseSurface))
	{
		sucroseSurface = surface_create(cam_width, cam_height);
		surface_set_target(sucroseSurface);
		draw_clear_alpha(c_black, 0);
		surface_reset_target();
	}
	if (sucrose_lighting && surface_exists(sucroseSurface))
	{
		surface_set_target(sucroseSurface);
		draw_clear_alpha(c_black, 0);
		for (var i = 0; i < array_length(sucrose_color_array); i++)
		{
			with sucrose_color_array[i]
			{
				if (visible && bbox_in_camera(id, c, 32))
					draw_sprite_ext_flash(sprite_index, image_index, x - cam_x, y - cam_y, image_xscale, image_yscale, image_angle, other.sucrose_color, image_alpha);
			}
		}
		with obj_parent_enemy
		{
			if (visible && bbox_in_camera(id, c, 32))
				draw_sprite_ext_flash(sprite_index, image_index, draw_x - cam_x, draw_y - cam_y, draw_xscale, draw_yscale, image_angle, other.sucrose_color, image_alpha);
		}
		with obj_parent_player
		{
			if (visible && bbox_in_camera(id, c, 32))
			{
				draw_sprite_ext_flash(sprite_index, image_index, x - cam_x, y - cam_y, xscale * scale, yscale * scale, draw_angle, other.sucrose_color, image_alpha);
				if (state == States.charge && image_index < 5)
				{
					with baddieGrabbedID
					{
						if visible
							draw_sprite_ext_flash(sprite_index, image_index, draw_x - cam_x, draw_y - cam_y, draw_xscale, draw_yscale, image_angle, other.sucrose_color, image_alpha);
					}
				}
			}
		}
		with obj_creamThief
		{
			if (visible && bbox_in_camera(id, c, 32))
				draw_sprite_ext_flash(sprite_index, image_index, x - cam_x, y - cam_y, image_xscale, image_yscale, image_angle, other.sucrose_color, image_alpha);
		}
		with obj_baddieDead
		{
			if (visible && bbox_in_camera(id, c, 32))
				draw_sprite_ext_flash(sprite_index, -1, drawx - cam_x, drawy - cam_y, image_xscale, image_yscale, image_angle, other.sucrose_color, image_alpha);
		}
		
		gpu_set_blendmode(bm_subtract);
		
		with obj_lightsource
			draw_sprite_ext(sprite_index, image_index, x - cam_x, y - cam_y, 1, 1, 0, c_white, 1);
		with obj_bombExplosion
		{
			var set = abs((image_index / image_number) - 1);
			draw_sprite_ext(spr_lightsource_fade, image_index, x - cam_x, y - cam_y, set, set, 0, c_black, set * 2);
		}
		gpu_set_blendmode(bm_normal);
		draw_set_alpha(1);
		surface_reset_target();
		draw_surface(sucroseSurface, cam_x, cam_y);
	}
}
