if (currentState == (2 << 0))
{
	currentState = (1 << 0);
	sprite_index = spr_Pressed;
}
else if (currentState == (3 << 0))
{
	currentState = (0 << 0);
	sprite_index = spr_Released;
}
