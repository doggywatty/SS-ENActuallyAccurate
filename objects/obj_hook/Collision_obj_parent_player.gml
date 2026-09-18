if (state == states.frozen)
{
	if (other.state != states.freefall && other.state != states.frozen && other.state != states.hang && other.state != states.gottreasure)
	{
		with (other)
		{
			other.x = other.xstart;
			other.y = other.ystart;
			scr_taunt_storeVariables();
			state = states.freefall;
			other.playerID = id;
		}
		
		state = states.titlescreen;
	}
}
