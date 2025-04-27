for (var i = 0; i < ds_list_size(global.afterimage_list); i++)
{
	var b = ds_list_find_value(global.afterimage_list, i);
	with b
	{
		if (instance_exists(identity) && object_is_ancestor(identity.object_index, obj_parent_player) && (identity.isInSecretPortal || identity.isInLapPortal))
			exit;
		
		if visible
		{
			var override = false;
			if (color_choose != AfterImageType.plain)
			{
				shader_set(shd_afterimage);
				var color_blend_1 = shader_get_uniform(shd_afterimage, "blendcolor1");
				var color_blend_2 = shader_get_uniform(shd_afterimage, "blendcolor2");
				var light_color = obj_afterimagecontroller.color_arr[color_choose].light;
				var dark_color = obj_afterimagecontroller.color_arr[color_choose].dark;
				if (color_choose == AfterImageType.wallkick && instance_exists(identity) && object_is_ancestor(identity.object_index, obj_parent_player))
				{
					with identity
					{
						var _my_pal_index = global.PlayerPaletteIndex;
						if (!number_in_range(_my_pal_index, 0, array_length(global.CharacterPalette[global.playerCharacter].palettes) - 1))
						{
							show_debug_message($"WARNING: PALETTE INDEX {_my_pal_index} IS OUT OF RANGE 0-{array_length(global.CharacterPalette[global.playerCharacter].palettes) - 1}. DEFAULTING TO 0");
							_my_pal_index = 0;
						}
						var pal_info = global.CharacterPalette[global.playerCharacter].palettes[_my_pal_index].palColors;
						light_color = pal_info[3];
						dark_color = pal_info[4];
					}
				}
				shader_set_uniform_f(color_blend_1, color_get_red(light_color) / 255, color_get_green(light_color) / 255, color_get_blue(light_color) / 255);
				shader_set_uniform_f(color_blend_2, color_get_red(dark_color) / 255, color_get_green(dark_color) / 255, color_get_blue(dark_color) / 255);
			}
			else if (instance_exists(identity) && object_is_ancestor(identity.object_index, obj_parent_player))
			{
				draw_player_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, gonealpha * image_alpha);
				override = true;
			}
			else if (paletteSprite != -4 && paletteSelect != -4)
				pal_swap_set(paletteSprite, paletteSelect, false);
			
			if !override
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, gonealpha * image_alpha);
			
			pal_swap_reset();
			shader_reset();
		}
	}
}
