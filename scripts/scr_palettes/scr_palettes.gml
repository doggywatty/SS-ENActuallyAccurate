global.Palette_PatternUniform = shader_get_uniform(shd_pal_swapper, "pattern_enabled");

function palette_as_player(arg0 = sprite_index, arg1 = image_index, arg2 = global.playerCharacter, arg3 = global.PlayerPaletteIndex, arg4 = 0, arg5 = 0, arg6 = 1, arg7 = 1)
{
	if (!sprite_exists(arg0))
		exit;
	
	if (!number_in_range(arg3, 0, array_length(global.CharacterPalette[arg2].palettes) - 1))
	{
		show_debug_message($"WARNING: PALETTE INDEX {arg3} IS OUT OF RANGE 0-{array_length(global.CharacterPalette[arg2].palettes) - 1}. DEFAULTING TO 0");
		arg3 = 0;
	}
	
	var pal_spr = global.CharacterPalette[arg2].sprite;
	var pal_info = global.CharacterPalette[arg2].palettes[arg3];
	pal_swap_set(pal_spr, arg3, false);
	
	if (!is_undefined(pal_info.palTexture) && sprite_exists(pal_info.palTexture))
		pattern_setup(pal_info.palTexture, global.CharacterPalette[arg2].patternColors, arg0, arg1, arg4, arg5, arg6, arg7);
	else
		shader_set_uniform_i(global.Palette_PatternUniform, false);
}

function draw_player_sprite(arg0, arg1, arg2, arg3, arg4 = global.playerCharacter, arg5 = global.PlayerPaletteIndex)
{
	draw_player_sprite_ext(arg0, arg1, arg2, arg3, 1, 1, 0, c_white, 1, arg4, arg5);
}

function draw_player_sprite_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = global.playerCharacter, arg10 = global.PlayerPaletteIndex)
{
	if (!sprite_exists(arg0))
		exit;
	
	palette_as_player(arg0, arg1, arg9, arg10, arg2, arg3, arg4, arg5);
	draw_sprite_ext(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
	pal_swap_reset();
}

function pattern_setup(arg0, arg1 = [1, 2], arg2 = sprite_index, arg3 = image_index, arg4 = 0, arg5 = 0, arg6 = 1, arg7 = 1)
{
	var shader = shd_pal_swapper;
	var u_color_array = shader_get_uniform(shader, "u_color_array");
	shader_set_uniform_f_array(u_color_array, arg1);
	var u_dest_texelDimension = shader_get_uniform(shader, "u_dest_texelDimension");
	var spr_dest_texture = sprite_get_texture(arg0, 0);
	shader_set_uniform_f(u_dest_texelDimension, texture_get_texel_width(spr_dest_texture), texture_get_texel_height(spr_dest_texture));
	var u_loop_texture = shader_get_sampler_index(shader, "u_loop_texture");
	texture_set_stage(u_loop_texture, spr_dest_texture);
	var u_src_spriteDimension = shader_get_uniform(shader, "u_src_spriteDimension");
	var spr_width = sprite_get_width(arg0);
	var spr_height = sprite_get_height(arg0);
	shader_set_uniform_f(u_src_spriteDimension, arg4 - (spr_width / 2), arg5 - (spr_height / 2), spr_width, spr_height);
	shader_set_uniform_i(global.Palette_PatternUniform, true);
}
