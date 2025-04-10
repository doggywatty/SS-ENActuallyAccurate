draw_set_alpha(fadealpha);
draw_set_color(c_white);
draw_rectangle(-64, -64, 1024, 604, false);
draw_set_alpha(1);
draw_set_color(c_white);

if (fadealpha > 0 && !instance_exists(obj_rank))
{
    with obj_parent_player
        draw_player_sprite(sprite_index, image_index, other.PlayerX, other.PlayerY);
}
