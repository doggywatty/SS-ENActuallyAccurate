if (escapeBlockedDoor && global.panic)
{
	showDoorLight = false;
	sprite_index = spriteDoorEscape;
	
	if (spriteDoorEscape == spr_tutorialdoor)
		image_index = 1;
	
	if (!place_meeting(x, y, obj_doorblocked))
		instance_create(x, y, obj_doorblocked);
	
	exit;
}

with (obj_parent_player)
{
	if (place_meeting(x, y, other.id) && !instance_exists(obj_fadeoutTransition) && key_up && grounded && (state == states.normal || state == states.chainsaw || state == states.pistol || state == states.shotgun || state == states.Nhookshot) && state != states.grab && state != states.shotgunjump && state != states.stunned)
	{
		image_index = 0;
		state = states.grab;
		targetDoor = other.targetDoor;
		targetRoom = other.targetRoom;
		obj_camera.chargeCameraX = 0;
		
		if (ds_list_find_index(global.SaveRoom, other.id) == -1)
			ds_list_add(global.SaveRoom, other.id);
	}
}
