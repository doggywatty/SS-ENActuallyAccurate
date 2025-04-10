draw_sprite_ext(spr_minesElevatorRope, 0, x, y - 72, image_xscale, room_height, image_alpha, image_blend, image_alpha);
if (sprite_index == spr_minesElevatorClosing)
{
	var player = obj_parent_player;
	draw_sprite(spr_minesElevatorBackpiece, 0, x, y);
	draw_player_sprite_ext(player.sprite_index, player.image_index, player.x, player.y, player.xscale, player.image_yscale, player.image_angle, player.image_blend, 1);
}
draw_self();
