scr_baddie_collide_destroyables();

if (state != EnemyState.grabbed && state != EnemyState.panicWait && state != EnemyState.secretWait && doCollision)
	scr_collision();
