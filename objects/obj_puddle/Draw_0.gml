if !slipped
    iceblock.draw(x, y + 5).update();

pal_swap_set(paletteSprite, paletteSelect, 0);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, image_blend, image_alpha);
pal_swap_reset();
