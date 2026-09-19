if (countdownCounter > 0 && currentState == ButtonState.pressed)
{
	countdownCounter--;
	
	if (countdownCounter <= 0)
	{
		currentState = ButtonState.reverting;
		sprite_index = spr_Reverting;
	}
}
