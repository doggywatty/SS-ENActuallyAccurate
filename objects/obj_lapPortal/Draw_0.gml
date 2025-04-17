if (sprite_index == spr_lappingportal_inactive)
    draw_sprite_ext(sprite_index, image_index, x, y + wave(-2, 2, 1, 5), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
else
    draw_self();
if (sprite_index == spr_lappingportal_idle)
    draw_sprite_ext(spr_lappingportal_icon, 0, x, y + wave(-5, 5, 0.5, 5), 1, 1, 0, c_white, 1);
