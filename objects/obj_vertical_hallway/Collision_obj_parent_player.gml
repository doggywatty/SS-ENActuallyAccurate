with other.id
{
	var bbox_size = abs(bbox_right - bbox_left);
	other.playerPosX ??= x;
	other.playerPosY ??= other.y + (other.sprite_height / 2);
	x = other.playerPosX;
	y = other.playerPosY;
	var _x1 = clamp(x, other.x + bbox_size, other.bbox_right - bbox_size);
	var xpos_difference = _x1 - other.x;
	var xpos = xpos_difference / other.image_xscale;
	var xpos_offset = xpos * other.hallwayxscale;
	targetDoor = other.targetDoor;
	targetRoom = other.targetRoom;
	vertical = true;
	verticalOffset = xpos_offset;
	hallwaydirection = sign(other.image_yscale);
	if !instance_exists(obj_fadeoutTransition)
	{
		event_play_oneshot("event:/SFX/general/door");
		instance_create(x, y, obj_fadeoutTransition);
	}
}
