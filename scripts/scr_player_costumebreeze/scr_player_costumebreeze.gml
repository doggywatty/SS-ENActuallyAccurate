function state_player_costumebreeze()
{
	hsp = xscale * move;
	move = key_left + key_right;
	movespeed = approach(movespeed, 0, 0.2);
	breezeCooldown--;
	
	if (breezeCooldown <= 0 || movespeed == 0)
		state = PlayerState.costumenormal;
}
