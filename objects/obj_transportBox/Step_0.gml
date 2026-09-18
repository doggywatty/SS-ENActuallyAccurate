with (obj_parent_player)
{
	if (other.image_yscale == 1)
	{
		if (((key_down && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id) && (state == states.facestomp || state == states.cheeseball || state == states.climbdownwall)) || ((state == states.slam || state == states.skateboard) && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id))) && !instance_exists(obj_fadeoutTransition) && state != states.grab && state != states.stunned)
		{
			with (other)
			{
				event_user(0);
				sprite_index = spr_pizzabox_front;
				depth = -30;
			}
			
			event_play_oneshot("event:/SFX/general/box", x, y);
			obj_parent_player.box = true;
			image_index = 0;
			image_speed = 0.35;
			machTwo = 0;
			obj_camera.chargeCameraX = 0;
			x = other.x;
			obj_parent_player.targetDoor = other.targetDoor;
			obj_parent_player.targetRoom = other.targetRoom;
			sprite_index = spr_downpizzabox;
			state = states.grab;
		}
	}
	
	if (other.image_yscale == -1)
	{
		if ((((key_up || state == states.highjump || state == states.cheesepep) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id) && (state == states.chainsawpogo || state == states.cheesepep || state == states.cheeseball || state == states.ufofloat || state == states.highjump || state == states.pistol || state == states.shotgun)) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id)) && !instance_exists(obj_fadeoutTransition))
		{
			event_play_oneshot("event:/SFX/general/box");
			
			with (other)
			{
				event_user(0);
				sprite_index = spr_pizzabox_front;
				depth = -30;
			}
			
			event_play_oneshot("event:/SFX/general/box", x, y);
			obj_parent_player.box = true;
			image_index = 0;
			image_speed = 0.35;
			machTwo = 0;
			obj_camera.chargeCameraX = 0;
			x = other.x;
			obj_parent_player.targetDoor = other.targetDoor;
			obj_parent_player.targetRoom = other.targetRoom;
			sprite_index = spr_uppizzabox;
			state = states.grab;
		}
	}
}
