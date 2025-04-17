helptimer = -1;

with other
{
    sprite_index = spr_creamthief_grab;
    image_index = 0;
    state = States.frozen;
    ds_list_add(global.SaveRoom, id, true);
    instance_create(x, y, obj_creamThiefCar);
}

event_play_oneshot("event:/SFX/general/loserace");

repeat (6)
    create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_confecticage_debris);

instance_destroy();
ds_list_add(global.SaveRoom, id);

