if (place_meeting(x, y + vsp + grav, obj_parent_player && image_speed == 0))
{
	DestroyedBy = obj_parent_player;
	event_user(0);
}

if (place_meeting(x, y - 1, obj_parent_player) && image_speed == 0)
{
	DestroyedBy = obj_parent_player;
	event_user(0);
}

if (sprite_animation_end())
	image_speed = 0;
