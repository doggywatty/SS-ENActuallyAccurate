if (place_meeting(x, y, obj_miniBall) && sprite_index != spr_trashcan_score)
{
    event_play_oneshot("event:/SFX/general/paperballwin");
    instance_destroy(obj_miniBall);
    image_index = 0;
    sprite_index = spr_trashcan_score;
    repeat 5
    {
        with instance_create(x + 48, y + 20, obj_confettiEffect)
            paperDunk = true;
    }
}
if (sprite_animation_end() && sprite_index == spr_trashcan_score)
    sprite_index = spr_trashcan_full;
