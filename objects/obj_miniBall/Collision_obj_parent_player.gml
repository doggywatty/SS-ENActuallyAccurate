if (tossCooldown > 0)
	exit;

event_play_oneshot("event:/SFX/general/paperballhit");
vsp = random_range(-8, -10);
image_xscale = -other.xscale;
movespeed = random_range(8, 12);
tossCooldown = 10;
