function scr_enemy_panicWait()
{
	visible = false;
	hsp = 0;
	vsp = 0;
	x = -900;
	y = -200;
	invincibleBaddie = true;
	
	if global.panic
	{
		var _player = instance_nearest(xstart, ystart, obj_parent_player);
		if (!instance_exists(escapePortalEffect) && point_in_rectangle(xstart, ystart, _player.x - 500,
		obj_parent_player.y - 100, obj_parent_player.x + 500, obj_parent_player.y + 100))
		{
			escapePortalEffect = instance_create(xstart, ystart, obj_panicPortal);
			event_play_oneshot("event:/SFX/enemies/escapespawn", xstart, ystart);
			instance_create(xstart, ystart, obj_poofeffect);
			x = xstart;
			y = ystart;
			hasSquashedX = true;
			squashValueX = 0;
			baddieStunTimer = 20;
			if !scr_enemyDestroyableCheck(x, y)
			{
				invincibleBaddie = false;
				visible = true;
				flash = true;
				state = States.charge;
				sprite_index = baddieSpriteStun;
				image_index = 0;
			}
		}
	}
}

function scr_enemy_secretWait()
{
	visible = false;
	hsp = 0;
	vsp = 0;
	x = -900;
	y = -200;
	invincibleBaddie = true;
	if !place_meeting(xstart, ystart, obj_bigdestructibles)
	{
		x = xstart;
		y = ystart;
		visible = true;
		jumpedFromBlock = true;
		hasSquashedX = true;
		squashValueX = 0;
		baddieStunTimer = 3;
		vsp = -8;
		grounded = false;
		state = States.charge;
		sprite_index = baddieSpriteWalk;
	}
}
