if (!reciever && !active && obj_parent_player.state != States.donothing && !global.freezeframe && is_for_me)
{
    alarm[0] = 25;
    active = true;
    event_play_oneshot("event:/SFX/general/teleporterstart", x, y);
	create_particle(x, y, spr_teleportEffect);
	with obj_parent_player
    {
        visible = false;
        other.storedstate = state;
        other.storedmovespeed = movespeed;
        other.storedgrav = grav;
        other.storedimageindex = image_index;
        other.storedspriteindex = sprite_index;
        other.storedfreefallsmash = freeFallSmash;
        hsp = 0;
        vsp = 0;
        grav = 0;
        alarm[7] = 50;
        alarm[5] = 2;
        hurted = true;
        state = States.donothing;
    }
}

