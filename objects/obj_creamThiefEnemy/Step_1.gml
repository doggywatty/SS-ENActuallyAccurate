event_inherited();

if (!active)
{
	if (state != states.frozen)
		state = states.frozen;
	
	if (baddieStunTimer > 0)
		active = true;
}
