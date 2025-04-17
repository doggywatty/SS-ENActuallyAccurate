with obj_parent_player
{
    if (other.image_yscale == 1)
    {
        if (((key_down && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id)
		&& (state == States.crouch || state == States.wallkick || state == States.machroll))
		|| ((state == States.freefall || state == States.freefallland)
		&& !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id)))
		&& !instance_exists(obj_fadeoutTransition) && state != States.door && state != States.comingoutdoor)
        {
            with other
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
            state = States.door;
        }
    }
    if (other.image_yscale == -1)
    {
        if ((((key_up || state == States.Sjump || state == States.climbwall) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id) && (state == States.jump || state == States.climbwall || state == States.wallkick || state == States.uppercut || state == States.Sjump || state == States.mach2 || state == States.mach3)) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id)) && !instance_exists(obj_fadeoutTransition))
        {
            event_play_oneshot("event:/SFX/general/box");
            with other
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
            state = States.door;
        }
    }
}

