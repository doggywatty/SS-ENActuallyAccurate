if (state == PlayerState.frozen)
{
	if (other.state != PlayerState.oldtaunt && other.state != PlayerState.frozen && other.state != PlayerState.noclip && other.state != PlayerState.taunt)
	{
		with (other)
		{
			other.x = other.xstart;
			other.y = other.ystart;
			scr_taunt_storeVariables();
			state = PlayerState.oldtaunt;
			other.playerID = id;
		}
		
		state = PlayerState.titlescreen;
	}
}
