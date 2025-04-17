event_play_multiple("event:/SFX/general/leafDestroy", bbox_left + (bbox_width / 2), bbox_top + (bbox_height / 2));
dvsp = random_range(-7, -10);
dhsp = random_range(5, 10) * DestroyedBy.image_xscale;
spinspeed = random_range(5, 10) * DestroyedBy.image_xscale;
instance_destroy();
