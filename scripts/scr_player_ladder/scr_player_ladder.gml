function state_player_ladder()
{
	floatyGrab = 18;
	jumpAnim = true;
	landAnim = false;
	crouchAnim = false;
	turning = 0;
	jumpStop = false;
	movespeed = 0;
	hsp = 0;
	flash = false;
	grav = 0;
	if key_up
	{
		sprite_index = spr_laddermove;
		if (vsp > -6)
			vsp = -6;
		if !stepEffectBuffer--
		{
			instance_create(x, y + 43, obj_puffEffect);
			event_play_oneshot("event:/SFX/player/step", x, y);
			stepEffectBuffer = 12;
		}
		image_speed = 0.35;
	}
	else if key_down
	{
		sprite_index = spr_ladderdown;
		if vsp < 10
			vsp = 10;
		image_speed = -0.35;
	}
	else
	{
		sprite_index = spr_Ladder;
		vsp = 0;
	}
	
	machTwo = 0;
	jumpAnim = true;
	landAnim = false;
	if !place_meeting(x, y, obj_ladder)
	{
		landAnim = false;
		jumpAnim = false;
		state = States.normal;
		image_index = 0;
		var _y = y;
		var i = 0;
		if (vsp < 0)
		{
			while !place_meeting_collision(x, y + 1)
			{
				y++;
				i++;
				if (i >= 10)
				{
					y = _y;
					break;
				}
			}
		}
		inputLadderBuffer = 5;
		vsp = 0;
	}
	
	if (inputBufferJump > 0)
	{
		fmod_studio_event_instance_start(sndJump);
		inputBufferJump = 0;
		sprite_index = spr_jump;
		image_index = 0;
		ladderBuffer = 20;
		jumpAnim = true;
		state = States.jump;
		vsp = -9;
		inputLadderBuffer = 20;
	}
	if (key_down && scr_solid_player(x, y + 1))
	{
		state = States.normal;
		image_index = 0;
	}
}
