var c = view_camera[0];
var dist = 32;
with obj_parent_enemy
{
	if (visible && bbox_in_camera(id, c, dist))
	{
		other.drawBaddieSprite(id);
		if global.DebugVisuals
		{
			draw_set_font(font_dev);
			draw_text(x, y - 50, $"State: {state}");
			draw_text(x, y - 150, $"hsp: {hsp}, vsp: {vsp}, Movespeed: {movespeed}");
			
			var m_id = mask_index;
			if baddieCollisionBoxEnabled
			{
				mask_index = baddieCollisionMask;
				draw_rectangle_color(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, c_green, c_green, c_green, c_green, true);
				mask_index = m_id;
			}
			draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, true);
		}
	}
}

with obj_creamThief
{
	if (visible && bbox_in_camera(id, c, dist))
		draw_self();
}

with obj_parent_player
{
	if (visible && bbox_in_camera(id, c, dist))
	{
		other.drawPlayer(id);
		if ((state == States.charge && image_index < 5) || sprite_index == spr_piledriverland)
			other.drawBaddieSprite(baddieGrabbedID);
	}
}

with obj_baddieDead
{
	if paletteSprite != -4
	{
		pal_swap_set(paletteSprite, paletteSelect, false);
		draw_sprite_ext(sprite_index, -1, drawx, drawy, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		shader_reset();
	}
	else
		draw_sprite_ext(sprite_index, -1, drawx, drawy, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
