with (instance_nearest(x, y, obj_parent_player))
{
	var bumpstates = [States.mach3, States.mach2, States.machroll, States.grabdash];
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && object_index != obj_chocofrogsmall && array_contains(bumpstates, state))
	{
		event_play_oneshot("event:/SFX/player/splat", x, y);
		state = States.bump;
		hsp = -xscale * 5;
		vsp = -2;
		sprite_index = spr_bump;
		image_index = 0;
		with other.id
		{
			image_index = 0;
			if (obj_parent_player.x < ((x - sprite_xoffset) + (sprite_width / 2)))
				sprite_index = spr_chocofrogbig_bumpL;
			else
				sprite_index = spr_chocofrogbig_bumpR;
		}
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == States.cotton && movespeed >= 8)
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x + hsp, y + vsp, other.id) || place_meeting(x + xscale, y + sign(vsp), other.id)) && state == States.cottondig)
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == States.cotton && sprite_index == spr_player_PZ_werecotton_drill_h)
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == States.cottonroll)
	{
		with other.id
			instance_destroy();
	}
	if (((place_meeting(x, y + vsp, other.id) && vsp > 0) || place_meeting(x, y + 1, other.id)) && state == States.cottondrill)
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == States.minecart)
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && (state == States.fireass || state == States.fireassdash))
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x, y + vsp, other.id) || place_meeting(x, y + sign(vsp), other.id)) && (state == States.fireass || state == States.fireassdash))
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == States.oldtaunt)
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x, y + vsp, other.id) || place_meeting(x, y + sign(vsp), other.id)) && state == States.oldtaunt)
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == States.oldtaunt)
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x, y + vsp, other.id) || place_meeting(x, y + sign(vsp), other.id)) && state == States.oldtaunt)
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && (state == States.frostburnnormal || state == States.frostburnjump || state == States.frostburnslide))
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x, y + vsp, other.id) || place_meeting(x, y + sign(vsp), other.id)) && (state == States.frostburnjump || state == States.frostburnslide))
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == States.bottlerocket && substate == 0)
	{
		with other.id
			instance_destroy();
	}
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == States.doughmountspin)
	{
		with other.id
			instance_destroy();
	}
}

with obj_creamThief
{
	if (place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id))
	{
		with other.id
			instance_destroy();
	}
}

if (place_meeting(x, y, obj_bombExplosionPlayer) && instance_place(x, y, obj_bombExplosionPlayer).frog)
	instance_destroy();

if (sprite_animation_end())
{
	switch sprite_index
	{
		case spr_chocofrogbig_bumpR:
		case spr_chocofrogbig_bumpL:
			sprite_index = spr_chocofrogbig;
			break;
	}
}
