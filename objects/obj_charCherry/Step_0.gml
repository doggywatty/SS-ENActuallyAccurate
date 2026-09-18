baddieCollisionBoxEnabled = state != states.minecart;

if (state == states.frozen)
	state = states.minecart;

event_inherited();
