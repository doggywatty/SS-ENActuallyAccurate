if (countdownCounter > 0 && currentState == (1 << 0))
{
	countdownCounter--;
	
	if (countdownCounter <= 0)
	{
		currentState = (3 << 0);
		sprite_index = spr_Reverting;
	}
}
