baddieCollisionBoxEnabled = state != EnemyState_Cherry.ACTIVE;

if (state == PlayerState.frozen)
	state = EnemyState_Cherry.ACTIVE;

event_inherited();
