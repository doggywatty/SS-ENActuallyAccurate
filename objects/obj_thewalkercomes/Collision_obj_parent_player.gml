if !instance_exists(obj_thewalkercage)
{
    if deadly
    {
        show_error("THE SUN IS LEAKING", true);
        with other
        {
            hsp = 9 * other.xscale;
            state = States.gameover;
            sprite_index = spr_player_PZ_fall_outOfControl;
        }
    }
    else
    {
        event_inherited();
        other.movespeed = movespeed;
        other.sprite_index = spr_player_PZ_fall_outOfControl;
    }
}

