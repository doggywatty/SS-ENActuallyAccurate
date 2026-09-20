with (obj_parent_player)
{
	if (place_meeting(x, y, other.id) && key_up && grounded == 1 && (state == PlayerState.normal || state == PlayerState.Sjumpprep || state == PlayerState.mach1 || state == PlayerState.mach2 || state == PlayerState.mach3) && !instance_exists(obj_fadeoutTransition) && state != PlayerState.door && state != PlayerState.victory && state != PlayerState.comingoutdoor && global.janitortype == 1)
	{
		if (ds_list_find_index(global.SaveRoom, other.id) != -1)
		{
			machTwo = 0;
			image_index = 0;
			obj_camera.chargeCameraX = 0;
			targetDoor = other.targetDoor;
			targetRoom = other.targetRoom;
			state = PlayerState.door;
		}
		else if (global.janitorRudefollow == 1)
		{
			state = PlayerState.victory;
			image_index = 0;
			obj_camera.chargeCameraX = 0;
			targetDoor = other.targetDoor;
			targetRoom = other.targetRoom;
			
			with (other)
			{
				ds_list_add(global.SaveRoom, id);
				image_index = 0;
				sprite_index = spr_lapdooropen;
				image_speed = 0.35;
			}
			
			instance_destroy(obj_rudejanitor);
			instance_create(x, y, obj_lock);
		}
	}
}
