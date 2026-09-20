baddieCollisionBoxEnabled = state != PlayerState.charcherryrun;

if (state == PlayerState.frozen)
	state = PlayerState.charcherryrun;

event_inherited();
