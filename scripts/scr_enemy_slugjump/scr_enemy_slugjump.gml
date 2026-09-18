function scr_enemy_slugjump()
{
	enemyAttackTimer = jumptimerMax;
	hsp = movespeed * sign(image_xscale);
	
	if (sprite_index == spr_sluggy_jumpstart || sprite_index == spr_sluggy_land)
		hsp = 0;
	else
		movespeed = approach(movespeed, 3, 1);
	
	if (sprite_animation_end() && sprite_index == spr_sluggy_jumpstart)
	{
		sprite_index = spr_sluggy_jump;
		vsp = -11;
		grounded = false;
	}
	
	if (scr_solid(x + sign(hsp), y) && !scr_slope_ext(x + sign(hsp), y))
	{
		movespeed = 0;
		image_xscale *= -1;
	}
	
	if (sprite_index == spr_sluggy_land && sprite_animation_end())
	{
		state = states.frozen;
		sprite_index = baddieSpriteWalk;
		movespeed = 1;
	}
	
	if (sprite_index == spr_sluggy_jump && grounded)
	{
		sprite_index = spr_sluggy_land;
		
		if (place_meeting(x, y + 1, obj_dirtpatch))
		{
			image_index = 0;
			sprite_index = spr_sluggy_burrow;
			state = states.titlescreen;
			burrowTimer = burrowTimerMax;
			enemyAttackTimer = jumptimerMax;
			slide = -image_xscale * 6;
		}
	}
}
