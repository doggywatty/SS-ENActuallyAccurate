if !scr_player_check_normal(other)
    exit;
if (ds_list_find_index(global.SaveRoom, id) == -1)
{
    with other
    {
        if (state != States.gotkey && sprite_index != spr_player_PZ_gotKey && sprite_index != spr_player_PZ_pileDriver_jump)
        {
            global.ComboFreeze = 15;
            global.ComboTime = 60;
            event_play_oneshot("event:/SFX/general/collectKey");
            image_index = 0;
            if grounded
            {
                hsp = 0;
                vsp = 0;
                sprite_index = spr_player_PZ_gotKey;
            }
            else
            {
                image_index = 0;
                sprite_index = spr_player_PZ_freeFall_1;
            }
            state = States.gotkey;
            keyParticles = true;
            alarm[7] = 30;
            scr_queueTVAnimation(global.TvSprPlayer_KeyGot, 60);
            ds_list_add(global.KeyFollowerList, instance_create(x, y, obj_spookey));
            with other
            {
                ds_list_add(global.SaveRoom, id);
                instance_destroy();
            }
        }
    }
}

