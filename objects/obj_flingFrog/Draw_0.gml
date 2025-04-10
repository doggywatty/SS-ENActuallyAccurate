draw_sprite(sprite_index, image_index, xstart, ystart);
if flingInputStarted
    draw_sprite_ext(spr_flingguide, 0, xstart, ystart + 70, 1, 1, flingDir, image_blend, image_alpha);
if (grabbedPlayer == -4)
    draw_sprite(spr_flingFrogGrab, -1, x, y);
if global.DebugVisuals
    draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, 1);
