with obj_parent_player
{
    if (place_meeting(x, y, other.id) && alarm[0] <= 0 && !instance_exists(obj_fadeoutTransition) && key_up2 && grounded && (state == States.normal || state == States.Sjumpprep || state == States.mach2 || state == States.mach3 || state == States.run) && state != States.door && state != States.victory && state != States.comingoutdoor)
    {
        with other
        {
            sprite_index = spr_soundTest_buttonPressed;
            alarm[0] = 5;
        }
    }
}

