showDoorLight = false;
if (escapeBlockedDoor && global.panic)
{
	sprite_index = spriteDoorEscape;
	exit;
}
sprite_index = spriteDoorUnlocked;
if (ds_list_find_index(global.SaveRoom, other.id) == -1 || place_meeting(x, y, obj_doorblocked))
	sprite_index = spriteDoorLocked;
with obj_parent_player
{
	if (place_meeting(x, y, other.id) && !instance_exists(obj_fadeoutTransition) && key_up && grounded
	&& (state == States.normal || state == States.Sjumpprep || state == States.mach2
	|| state == States.mach3) && state != States.door && state != States.victory
	&& state != States.comingoutdoor)
	{
		if (ds_list_size(global.KeyFollowerList) <= 0 && ds_list_find_index(global.SaveRoom, other.id) == -1)
			exit;
		image_index = 0;
		state = States.door;
		targetDoor = other.targetDoor;
		targetRoom = other.targetRoom;
		obj_camera.chargeCameraX = 0;
		if (ds_list_find_index(global.SaveRoom, other.id) == -1)
		{
			var target_x = (x - sprite_xoffset) + (sprite_width / 2);
			var target_y = (y - sprite_yoffset) + (sprite_height / 2);
			with (ds_list_find_value(global.KeyFollowerList, 0))
			{
				instance_create(x, y, obj_spookeyUnlocking, 
				{
					targetX: target_x,
					targetY: target_y,
					image_xscale: image_xscale
				});
				instance_destroy();
			}
			ds_list_delete(global.KeyFollowerList, 0);
			instance_create((x - sprite_xoffset) + (sprite_width / 2), (y - sprite_yoffset) + (sprite_height / 2), obj_lock, 
			{
				sprite_index: other.spriteDoorLock
			});
			state = States.victory;
			event_play_oneshot("event:/SFX/general/cheers", x, y);
			event_play_oneshot("event:/SFX/general/keyunlock", x, y);
			fmod_studio_event_instance_start(obj_parent_player.voiceCollect);
			with other
			{
				ds_list_add(global.SaveRoom, id);
				sprite_index = spriteDoorUnlocked;
				image_index = 0;
				image_speed = 0.35;
			}
			with obj_guardian
				instance_destroy();
		}
	}
}
