if showDoorSprite
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
if (showDoorLight && sprite_index != spr_door_mindpalace)
    draw_sprite_ext(spriteDoorLight, lightIndex, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
