function scr_enemy_grabbed()
{
	hsp = 0;
	vsp = 0;
	movespeed = 0;
	sprite_index = baddieSpriteGrabbed;
	image_speed = 0.35;
	var player_id = obj_player1;
	image_xscale = -player_id.xscale;
	baddieStunTimer = 200;
	player_id.baddieGrabbedID = id;
	if (player_id.state == States.grab)
	{
		var walk_bobbingy = 0;
		var walk_bobbingx = 0;
		if (player_id.sprite_index == player_id.spr_haulingWalk)
		{
			var yoffsets = [0, 2, 3, 9, 12, 0, -7, -6, -5, -3, 6, 5, 2];
			var xoffsets = [-4, -4, -3, -3, -2, -7, -10, -9, -8, -6, -3, -3, -3];
			walk_bobbingy = yoffsets[floor(player_id.image_index)];
			walk_bobbingx = xoffsets[floor(player_id.image_index)] * obj_player1.image_xscale;
		}
		
		var _yoff = -56 + walk_bobbingy;
		if (player_id.sprite_index == player_id.spr_haulingIntro)
		{
			var yoffsets = [-13, -35, -60, -55, -56];
			_yoff = yoffsets[floor(player_id.image_index)];
		}
		if (player_id.sprite_index == player_id.spr_haulingLand)
		{
			var yoffsets = [-31, -49, -53, -55];
			_yoff = yoffsets[floor(player_id.image_index)];
		}
		if (player_id.sprite_index == player_id.spr_haulingJump)
		{
			var yoffsets = [-22, -41, -62, -58];
			_yoff = yoffsets[floor(player_id.image_index)];
		}
		if (player_id.sprite_index == player_id.spr_haulingFall)
		{
			var yoffsets = [-58, -58, -58];
			_yoff = yoffsets[floor(player_id.image_index)];
		}
		y = player_id.y + _yoff;
		x = player_id.x + walk_bobbingx;
		image_xscale = -player_id.xscale;
	}
	if (player_id.sprite_index == player_id.spr_swingDing)
	{
		x = player_id.x;
		switch (floor(player_id.image_index))
		{
			case 0:
			case 8:
				x += (player_id.xscale * 10);
				break;
			case 1:
			case 7:
				x += (player_id.xscale * 5);
				break;
			case 3:
			case 5:
				x += (player_id.xscale * -5);
				break;
			case 4:
				x += (player_id.xscale * -10);
				break;
		}
		y = player_id.y;
	}
	
	if (player_id.state == States.superslam)
	{
		if (player_id.sprite_index != player_id.spr_piledriverland)
		{
			x = player_id.x - (player_id.xscale * 10);
			y = player_id.y - 70;
		}
		else
		{
			x = player_id.x;
			y = player_id.y;
		}
	}
	
	if (player_id.state == States.finishingblow && state != States.climbwall)
	{
		var try_x = 0;
		while (try_x < 60)
		{
			if (!scr_solid(player_id.x + (try_x * player_id.xscale), y) && !scr_slopePlatform(player_id.x + (try_x * player_id.xscale), y))
				try_x++;
			else
				break;
		}
		x = player_id.x + (try_x * player_id.xscale);
		y = player_id.y;
		hsp = 0;
		vsp = 0;
	}
	
	with obj_parent_player
	{
		if (!global.freezeframe && state != States.frozen && state != States.grab
		&& state != States.finishingblow && state != States.charge && state != States.superslam)
		{
			other.x = x;
			other.y = y;
			other.state = States.charge;
			other.image_index = 0;
		}
	}
}
