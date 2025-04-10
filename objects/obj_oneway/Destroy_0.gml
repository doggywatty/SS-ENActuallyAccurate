if (ds_list_find_index(global.SaveRoom, id) == -1)
{
    with (instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_baddieDead))
        sprite_index = other.onewayDeathSprite;
    
    repeat 3
    {
        instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), obj_slapstar);
        instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), obj_baddieGibs);
    }
    
    create_particle(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_bangEffect);
    event_play_oneshot("event:/SFX/enemies/kill");
    ds_list_add(global.SaveRoom, id);
}

if instance_exists(solidid)
{
    with solidid
        instance_destroy();
}

ini_open(global.SaveFileName);
ini_write_string("PlantBlocks", string($"Block{onewayRank}"), 1);
ini_close();
