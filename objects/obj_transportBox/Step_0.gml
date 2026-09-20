with (obj_parent_player)
{
	if (other.image_yscale == 1)
	{
		if (((key_down && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id) && (state == PlayerState.crouch || state == PlayerState.wallkick || state == PlayerState.machroll)) || ((state == PlayerState.freefall || state == PlayerState.freefallland) && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id))) && !instance_exists(obj_fadeoutTransition) && state != PlayerState.door && state != PlayerState.comingoutdoor)
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
			state = PlayerState.door;
		}
	}
	
	if (other.image_yscale == -1)
	{
		if ((((key_up || state == PlayerState.Sjump || state == PlayerState.climbwall) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id) && (state == PlayerState.jump || state == PlayerState.climbwall || state == PlayerState.wallkick || state == PlayerState.uppercut || state == PlayerState.Sjump || state == PlayerState.mach2 || state == PlayerState.mach3)) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id)) && !instance_exists(obj_fadeoutTransition))
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
			state = PlayerState.door;
		}
	}
}
