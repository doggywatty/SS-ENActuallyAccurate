function scr_enemy_thief()
{
	if (thiefSubstate == 0)
	{
		hsp = image_xscale * movespeed;
		
		if (thiefKeyInv == 0)
		{
			sprite_index = baddieSpriteWalk;
		}
		else if (thiefKeyInv == 1)
		{
			sprite_index = spr_theif_keywalk;
			movespeed = 4;
		}
		
		if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope))
			image_xscale *= -1;
		
		if (obj_parent_player.x > (x - 200) && obj_parent_player.x < (x + 200) && y <= (obj_parent_player.y + 60) && y >= (obj_parent_player.y - 60) && snatchcooldown == 0 && thiefKeyInv == 0)
		{
			thiefSubstate = 2;
			sprite_index = spr_theif_snatch;
			image_index = 0;
			image_xscale = -sign(x - obj_parent_player.x);
		}
	}
	
	if (thiefSubstate == 1)
	{
		movespeed = 0;
		hsp = 0;
		
		if (sprite_animation_end() && sprite_index == spr_theif_keyget)
		{
			sprite_index = spr_theif_keywalk;
			thiefSubstate = 0;
			movespeed = 4;
		}
	}
	
	if (thiefSubstate == 2)
	{
		hsp = image_xscale * movespeed;
		movespeed = 5;
		
		if ((place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)) || sprite_animation_end())
		{
			thiefSubstate = 0;
			snatchcooldown = 100;
			movespeed = 2;
		}
		
		if (place_meeting(x + sign(hsp), y, obj_parent_player))
		{
			scr_hurtplayer();
			snatchcooldown = 100;
		}
	}
	
	if (snatchcooldown > 0 && thiefSubstate != 2)
		snatchcooldown -= 0.2;
}
