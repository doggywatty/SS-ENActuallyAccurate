scr_baddie_collide_destroyables();

if (state != enemystates.grabbed && state != enemystates.panicWait && state != enemystates.secretWait && doCollision)
	scr_collision();
