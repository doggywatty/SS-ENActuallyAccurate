if (!reciever && !active && !global.freezeframe)
{
    alarm[3] = 25;
    active = true;
    event_play_oneshot("event:/SFX/general/teleporterstart", x, y);
    with obj_dogMount
    {
        visible = false;
        other.storedgrav = grav;
        other.storedimageindex = image_index;
        other.storedspriteindex = sprite_index;
        hsp = 0;
        vsp = 0;
        grav = 0;
    }
}
