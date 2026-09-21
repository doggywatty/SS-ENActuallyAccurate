event_inherited();

if (!active)
{
	if (state != PlayerState.frozen)
		state = PlayerState.frozen;
	
	if (baddieStunTimer > 0)
		active = true;
}
