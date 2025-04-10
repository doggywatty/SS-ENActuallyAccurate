if (ds_map_find_value(async_load, "type") == "fmod_studio_event_description_set_callback")
{
    global.CurrentBeat = ds_map_find_value(async_load, "beat");
    with obj_bggear
        event_user(0);
    if global.panic
    {
        with obj_siren
            event_user(0);
    }
    with obj_firefly
        event_user(0);
}
