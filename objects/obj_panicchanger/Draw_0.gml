draw_set_alpha(fadealpha);
draw_set_color(c_white);
draw_rectangle(-64, -64, room_width + 64, room_height + 64, 0);
draw_set_alpha(1);
with obj_parent_player
    draw_player_sprite_ext(sprite_index, image_index, x, y, xscale * scale, yscale * scale, draw_angle, c_white, image_alpha);
with obj_harrydead
    event_perform(ev_draw, ev_draw_normal);
