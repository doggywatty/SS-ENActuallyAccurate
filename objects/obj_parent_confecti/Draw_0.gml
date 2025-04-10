if (place_meeting(x, y, obj_cottonsolid) && obj_parent_player.savedCottonSolid)
    gpu_set_fog(true, #CC297A, 0, 1);

draw_sprite_ext(sprite_index, -1, x, y, drawxscale * scale * abs(image_xscale), image_yscale * scale, image_angle, image_blend, image_alpha);

if (obj_parent_player.isInSecretPortal || obj_parent_player.isInLapPortal)
    draw_sprite_ext_flash(sprite_index, -1, x, y, drawxscale * scale * abs(image_xscale), image_yscale * scale, image_angle, #49298d, image_alpha * (1.5 - scale));
if wetTimer
    draw_sprite_ext_duotone(sprite_index, -1, x, y, drawxscale * scale * abs(image_xscale), image_yscale * scale, image_angle, #f87018, 0, image_alpha * 0.75 * (wetTimer / wetTimerMax));
if (place_meeting(x, y, obj_cottonsolid) && obj_parent_player.savedCottonSolid)
    gpu_set_fog(false, c_black, 0, 0);
