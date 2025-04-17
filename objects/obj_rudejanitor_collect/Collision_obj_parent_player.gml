if (ds_list_find_index(global.SaveRoom, id) == -1)
{
    with instance_create(x, y, obj_rudejanitor)
        global.janitorRudefollow = true;
    
    create_particle(x, y, spr_taunteffect).particle_depth(obj_rudejanitor.depth + 1);
    event_play_oneshot("event:/SFX/general/janitorGot", x, y);
    global.ComboFreeze = 15;
    global.ComboTime = 60;
    ds_list_add(global.SaveRoom, id);
    instance_destroy();
    scr_queueTVAnimation(spr_tvHUD_janitorTreasure, 150);
}
