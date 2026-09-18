function state_player_coasterpeep()
{
	hsp = 2;
	
	if (dir == 0)
		vsp = -2;
	else if (dir == 1)
		vsp = 2;
	
	if (grounded)
	{
		vsp = 0;
		hsp = 5;
	}
}
