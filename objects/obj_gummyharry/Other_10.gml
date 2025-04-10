if (DestroyedBy.object_index == obj_parent_player || DestroyedBy.object_index == obj_player1 || DestroyedBy.object_index == obj_player2)
{
    if (place_meeting(x - DestroyedBy.hsp, y, DestroyedBy))
    {
        if (DestroyedBy.state == States.mach1 || DestroyedBy.state == States.mach2)
        {
            with DestroyedBy
            {
                with other.id
                    instance_destroy();
                hsp = xscale * -4;
                vsp = -4;
                machTwo = 0;
                image_index = 0;
                sprite_index = choose(spr_player_PZ_blockbreak_1, spr_player_PZ_blockbreak_2, spr_player_PZ_blockbreak_3, spr_player_PZ_blockbreak_4, spr_player_PZ_blockbreak_5, spr_player_PZ_blockbreak_6, spr_player_PZ_blockbreak_7);
                state = States.tackle;
            }
        }
        else if (DestroyedBy.state == States.grabdash)
            instance_destroy();
        else
            instance_destroy();
    }
}
else
    instance_destroy();
