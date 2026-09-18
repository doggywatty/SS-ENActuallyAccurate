if (switchcooldown <= 0)
{
	if (sprite_index == spr_onoffswitch_blue)
		sprite_index = spr_onoffswitch_bluetored;
	else if (sprite_index == spr_onoffswitch_red)
		sprite_index = spr_onoffswitch_redtoblue;
	
	switchcooldown = 100;
}
