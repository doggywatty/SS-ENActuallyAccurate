function state_player_frozen()
{
	scr_getinput();
	move = key_right + key_left;
	if key_jump
		inputBufferJump = 15;
	if key_slap2
		inputBufferSlap = 12;
	if global.freezeframe
	{
		for (var i = 0; i < 10; i++)
		{
			if (alarm_get(i) > 0)
				alarm_set(i, -1);
		}
		vsp = 0;
		hsp = 0;
		image_speed = 0;
		movespeed = 0;
		cutscene = true;
	}
	else
	{
		for (var i = 0; i < 10; i++)
			alarm_set(i, frozenAlarm[i]);
		sprite_index = frozenSpriteIndex;
		image_index = frozenImageIndex;
		image_speed = frozenImageSpeed;
		movespeed = frozenMoveSpeed;
		verticalMovespeed = frozenVerticalMovespeed;
		grav = frozenGrav;
		freeFallSmash = frozenSmash;
		hsp = frozenHsp;
		vsp = frozenVsp;
		state = frozenState;
		cutscene = false;
	}
}
