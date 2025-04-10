function scr_enemy_float()
{
	if (object_index != obj_frothCloud && object_index != obj_fizzCloud)
		hsp = image_xscale * movespeed;
	else
		hsp = 0;
	
	image_speed = 0.35;
	if (object_index != obj_frothCloud || substate == 0)
	{
		vsp = 0;
		if (!place_meeting_collision(x, y - 1) && y > ystart)
			y--;
		if (!place_meeting_collision(x, y + 1) && y < ystart)
			y++;
	}
	if (place_meeting_collision(x + sign(hsp), y, Exclude.SLOPES) && y <= ystart)
		image_xscale *= -1;
	if (object_index == obj_cottonblimp)
	{
		if (turntimer > 0)
			turntimer--;
		if (turntimer == 0)
		{
			turntimer = turnmax;
			image_xscale *= -1;
		}
	}
	
	if (sprite_index == spr_thundercloud_throw)
		sprite_index = baddieSpriteWalk;
	if (object_index == obj_frothCloud)
	{
		var _dir = obj_parent_player.x - x;
		if (substate == 0)
		{
			vsp = 0;
			if (abs(_dir) <= 250 && sprite_index != spr_snowcloudnotice)
			{
				image_index = 0;
				sprite_index = spr_snowcloudnotice;
			}
			if (abs(_dir) > 250 && sprite_index == spr_snowcloudnotice)
			{
				image_index = 0;
				sprite_index = spr_snowcloudnotice_reverse;
			}
			if sprite_animation_end()
			{
				if (sprite_index == spr_snowcloudnotice)
					image_index = image_number - 2;
				if (sprite_index == spr_snowcloudnotice_reverse)
					sprite_index = spr_snowcloudwalk;
			}
			if (abs(_dir) < 90 && y == ystart && !solid_in_line(obj_parent_player) && obj_parent_player.y >= y)
			{
				substate = 1;
				vsp = 0;
				image_index = 0;
				sprite_index = spr_snowclouddive;
			}
		}
		if (substate == 1)
		{
			vsp += 0.5;
			if (sprite_index == spr_snowclouddive && sprite_animation_end())
				sprite_index = spr_snowclouddiveboil;
			if grounded
			{
				substate = 0;
				sprite_index = spr_snowcloudwalk;
			}
		}
	}
}
