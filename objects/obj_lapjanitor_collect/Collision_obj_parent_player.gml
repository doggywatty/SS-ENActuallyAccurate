if (ds_list_find_index(global.SaveRoom, id) == -1)
{
    instance_create(x, y, obj_lapjanitor);
    with instance_create(x, y, obj_mushroomCloudEffect)
    {
        sprite_index = spr_taunteffect;
        depth = -2;
    }
    event_play_oneshot("event:/SFX/general/collectfollower");
    global.ComboFreeze = 15;
    global.ComboTime = 60;
    ds_list_add(global.SaveRoom, id);
    instance_destroy();
}
