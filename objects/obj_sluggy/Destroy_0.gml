if (ds_list_find_index(global.BaddieRoom, id) == -1)
{
    if killedInAir
        scr_task_notify("task_sm_slug", [room]);
}
event_inherited();
