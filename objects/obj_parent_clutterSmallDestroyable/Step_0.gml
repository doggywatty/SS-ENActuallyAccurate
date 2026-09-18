if (place_meeting(x, y + vsp + grav, obj_parent_player))
{
	DestroyedBy = obj_parent_player;
	event_user(0);
}

if (place_meeting(x, y - 1, obj_parent_player))
{
	DestroyedBy = obj_parent_player;
	event_user(0);
}
