function scr_enemy_charge()
{
	scr_conveyorBeltKinematics();
	if (object_index == obj_swedishfish)
	{
		hsp = image_xscale * movespeed;
		if (place_meeting_collision(x + sign(hsp), y, Exclude.SLOPES))
		{
			hsp = sign(image_xscale) * -3;
			vsp = -3;
			image_xscale *= -1;
			sprite_index = baddieSpriteStun;
			state = States.charge;
			baddieStunTimer = 100;
		}
	}
	
	if (object_index == obj_bananaCharger)
	{
		hsp = image_xscale * movespeed;
		if (substate == 0)
		{
			movespeed = (sprite_index == spr_banana_chargestart) ? 0 : 8;
			if (sprite_animation_end(undefined, 18) && sprite_index == spr_banana_chargestart)
				movespeed = 8;
			if (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope))
				image_xscale *= -1;
			var dir = sign(obj_parent_player.x - x);
			if (image_xscale == -dir && point_distance(x, 0, obj_parent_player.x, 0) >= 50)
			{
				substate = 1;
				sprite_index = spr_banana_machturn;
				image_index = 0;
			}
			if (sprite_index == spr_banana_turnboost && sprite_animation_end())
				sprite_index = spr_banana_charge;
		}
		
		if (substate == 1)
		{
			movespeed = (1 - (image_index / image_number)) * 6;
			if (sprite_animation_end() && !grounded)
			{
				image_speed = 0;
				movespeed = approach(movespeed, 0, 0.2);
			}
			if ((sprite_animation_end() && grounded) || (image_speed == 0 && grounded))
			{
				image_xscale *= -1;
				movespeed = 8;
				substate = 0;
				sprite_index = spr_banana_turnboost;
				image_speed = 0.35;
			}
		}
	}
}
