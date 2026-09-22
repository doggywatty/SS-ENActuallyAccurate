direction = angle_rotate(direction, point_direction(x, y, obj_parent_player.x, obj_parent_player.y), speed / 1.2);
speed += 0.05;
buffer = approach(buffer, 0, 1);
afterimage++;

if (afterimage > 6)
{
	create_afterimage(afterimagetypes.plain);
	afterimage = 0;
}

if (place_meeting(x, y, obj_parent_player) && buffer <= 0)
{
	event_play_multiple("event:/SFX/general/collect", (x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2));
	create_collect_effect(x, y, sprite_index, 3000);
	instance_destroy();
}
