if (place_meeting_collision(x, y))
{
    y += vsp;
    vsp += grav;
}
else
    scr_collision();

if (grounded)
{
    grav = 0;
    vsp = 0;
    fmod_studio_event_instance_stop(falling_sound, false);
}
