if (obj_parent_player.state == states.mach3 && obj_parent_player.sprite_index == obj_parent_player.spr_gotTreasure)
{
	drawnImageIndex += 0.35;
	draw_sprite(spr_treasureeffect, drawnImageIndex, x, y);
	draw_self();
}
else
{
	draw_sprite_ext(sprite_index, image_index, x, y + bobsin, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
