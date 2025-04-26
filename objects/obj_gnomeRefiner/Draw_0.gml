if (gemsRefined < 4)
{
    draw_sprite(spr_donutbubble, donutIndex, x, y - 35);
    draw_set_font(global.npcfont);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_scribble(x + 10, y - 35, $"[c_black]{4 - gemsRefined}");
}

pal_swap_set(pal_gnome, colorID, false);
draw_self();
pal_swap_reset();
