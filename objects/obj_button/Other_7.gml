if (currentState == ButtonState.lowering)
{
	currentState = ButtonState.pressed;
	sprite_index = spr_Pressed;
}
else if (currentState == ButtonState.reverting)
{
	currentState = ButtonState.released;
	sprite_index = spr_Released;
}
