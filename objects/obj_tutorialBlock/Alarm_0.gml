instance_destroy();
repeat 6
{
    with (create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_tutorialblock_debris))
        image_index = irandom(image_number);
}
instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), obj_tutorialIcePopFly);
create_destroyable_smoke(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), 16080);
event_play_multiple("event:/SFX/general/breakblock", x, y);
ini_open(global.SaveFileName);
ini_write_string("Misc", "TutorialBlock", "1");
ini_close();
