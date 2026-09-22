global.Palette_PatternUniform = shader_get_uniform(shd_pal_swapper, "pattern_enabled");

function palette_as_player(_spr = sprite_index, _img_ind = image_index, _character = global.playerCharacter, _palind = global.PlayerPaletteIndex, _drawx = 0, _drawy = 0, _xscale = 1, _yscale = 1)
{
	if (!sprite_exists(_spr))
		exit;
	
	if (!number_in_range(_palind, 0, array_length(global.CharacterPalette[_character].palettes) - 1))
	{
		show_debug_message($"WARNING: PALETTE INDEX {_palind} IS OUT OF RANGE 0-{array_length(global.CharacterPalette[_character].palettes) - 1}. DEFAULTING TO 0");
		_palind = 0;
	}
	
	var pal_spr = global.CharacterPalette[_character].sprite;
	var pal_info = global.CharacterPalette[_character].palettes[_palind];
	pal_swap_set(pal_spr, _palind, false);
	
	if (!is_undefined(pal_info.palTexture) && sprite_exists(pal_info.palTexture))
		pattern_setup(pal_info.palTexture, global.CharacterPalette[_character].patternColors, _spr, _img_ind, _drawx, _drawy, _xscale, _yscale);
	else
		shader_set_uniform_i(global.Palette_PatternUniform, false);
}

function draw_player_sprite(_spr, _frame, _drawx, _drawy, _character = global.playerCharacter, _palind = global.PlayerPaletteIndex)
{
	draw_player_sprite_ext(_spr, _frame, _drawx, _drawy, 1, 1, 0, c_white, 1, _character, _palind);
}

function draw_player_sprite_ext(_spr, _frame, _drawx, _drawy, _xscale, _yscale, _angle, _color, _alpha, _character = global.playerCharacter, _palind = global.PlayerPaletteIndex)
{
	if (!sprite_exists(_spr))
		exit;
	
	palette_as_player(_spr, _frame, _character, _palind, _drawx, _drawy, _xscale, _yscale);
	draw_sprite_ext(_spr, _frame, _drawx, _drawy, _xscale, _yscale, _angle, _color, _alpha);
	pal_swap_reset();
}

function pattern_setup(_tex, _cols = [1, 2], _spr_ind = sprite_index, _img_ind = image_index, _drawx = 0, _drawy = 0, _xscale = 1, _yscale = 1)
{
	var shader = shd_pal_swapper;
	var u_color_array = shader_get_uniform(shader, "u_color_array");
	shader_set_uniform_f_array(u_color_array, _cols);
	var u_dest_texelDimension = shader_get_uniform(shader, "u_dest_texelDimension");
	var spr_dest_texture = sprite_get_texture(_tex, 0);
	shader_set_uniform_f(u_dest_texelDimension, texture_get_texel_width(spr_dest_texture), texture_get_texel_height(spr_dest_texture));
	var u_loop_texture = shader_get_sampler_index(shader, "u_loop_texture");
	texture_set_stage(u_loop_texture, spr_dest_texture);
	var u_src_spriteDimension = shader_get_uniform(shader, "u_src_spriteDimension");
	var spr_width = sprite_get_width(_tex);
	var spr_height = sprite_get_height(_tex);
	shader_set_uniform_f(u_src_spriteDimension, _drawx - (spr_width / 2), _drawy - (spr_height / 2), spr_width, spr_height);
	shader_set_uniform_i(global.Palette_PatternUniform, true);
}
