instance_destroy();

repeat (6)
{
	with (create_debris(bbox_xrange, bbox_yrange, spr_tutorialblock_debris))
		image_index = irandom(image_number);
}

instance_create(bbox_xrange, bbox_yrange, obj_tutorialIcePopFly);
create_destroyable_smoke(bbox_xrange, bbox_yrange, #D03E00);
event_play_multiple("event:/SFX/general/breakblock", x, y);
ini_open(global.SaveFileName);
ini_write_string("Misc", "TutorialBlock", "1");
ini_close();
