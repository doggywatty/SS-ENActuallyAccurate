if (room == rank_room)
{
	x = savedCamX;
	y = savedCamY;
	x = clamp(x, 100, room_width - 100);
	y = clamp(y, 100, room_height - 100);
	instance_create(x, y, obj_coneballDead);
	event_play_oneshot("event:/SFX/general/explosion", x, y);
	event_play_oneshot("event:/SFX/player/groundpound", x, y);
}
