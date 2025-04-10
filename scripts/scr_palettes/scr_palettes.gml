global.Palette_PatternUniform = shader_get_uniform(shd_pal_swapper, "pattern_enabled");
function palette_as_player(sprite = sprite_index, frame = image_index, character = global.playerCharacter, index = global.PlayerPaletteIndex, drawx = 0, drawy = 0, xscale = 1, yscale = 1)
{
    if !sprite_exists(sprite)
        exit;
    var pal_spr = global.CharacterPalette[character].sprite;
    var pal_info = global.CharacterPalette[character].palettes[index];
    pal_swap_set(pal_spr, index, false);
    if (!is_undefined(pal_info.palTexture) && sprite_exists(pal_info.palTexture))
        pattern_setup(pal_info.palTexture, global.CharacterPalette[character].patternColors, sprite, frame, drawx, drawy, xscale, yscale);
    else
        shader_set_uniform_i(global.Palette_PatternUniform, false);
}

function draw_player_sprite(sprite, frame, drawx, drawy, character = global.playerCharacter, palind = global.PlayerPaletteIndex)
{
    draw_player_sprite_ext(sprite, frame, drawx, drawy, 1, 1, 0, c_white, 1, character, palind);
}

function draw_player_sprite_ext(sprite, frame, drawx, drawy, xscale, yscale, angle, color, alpha, character = global.playerCharacter, palind = global.PlayerPaletteIndex)
{
    if !sprite_exists(sprite)
        exit;
    palette_as_player(sprite, frame, character, palind, drawx, drawy, xscale, yscale);
    draw_sprite_ext(sprite, frame, drawx, drawy, xscale, yscale, angle, color, alpha);
    pal_swap_reset();
}

function pattern_setup(texture, colors = [1, 2], sprite = sprite_index, frame = image_index, drawx = 0, drawy = 0, xscale = 1, yscale = 1)
{
	var shader = shd_pal_swapper;
    var u_color_array = shader_get_uniform(shader, "u_color_array");
    shader_set_uniform_f_array(u_color_array, colors);
    var u_dest_texelDimension = shader_get_uniform(shader, "u_dest_texelDimension");
    var spr_dest_texture = sprite_get_texture(texture, 0);
    shader_set_uniform_f(u_dest_texelDimension, texture_get_texel_width(spr_dest_texture), texture_get_texel_height(spr_dest_texture));
    var u_loop_texture = shader_get_sampler_index(shader, "u_loop_texture");
    texture_set_stage(u_loop_texture, spr_dest_texture);
    var u_src_spriteDimension = shader_get_uniform(shader, "u_src_spriteDimension");
    var spr_width = sprite_get_width(texture);
    var spr_height = sprite_get_height(texture);
    shader_set_uniform_f(u_src_spriteDimension, drawx - (spr_width / 2), drawy - (spr_height / 2), spr_width, spr_height);
    shader_set_uniform_i(global.Palette_PatternUniform, true);
}
