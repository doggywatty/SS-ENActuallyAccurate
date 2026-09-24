with (instance_nearest(x, y, obj_parent_player))
{
	var bumpstates = [PlayerState.mach3, PlayerState.mach2, PlayerState.machroll, PlayerState.grabdash, PlayerState.machtumble2];
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && object_index != obj_chocofrogsmall && array_contains(bumpstates, state))
	{
		event_play_oneshot("event:/SFX/player/splat", x, y);
		state = PlayerState.bump;
		hsp = -xscale * 5;
		vsp = -2;
		sprite_index = spr_bump;
		image_index = 0;
		
		with (other.id)
		{
			image_index = 0;
			
			if (obj_parent_player.x < (xorigin + (sprite_width / 2)))
				sprite_index = spr_chocofrogbig_bumpL;
			else
				sprite_index = spr_chocofrogbig_bumpR;
		}
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == PlayerState.cotton && movespeed >= 8)
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x + hsp, y + vsp, other.id) || place_meeting(x + xscale, y + sign(vsp), other.id)) && state == PlayerState.cottondig)
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == PlayerState.cotton && sprite_index == spr_player_PZ_werecotton_drill_h)
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == PlayerState.cottonroll)
	{
		with (other.id)
			instance_destroy();
	}
	
	if (((place_meeting(x, y + vsp, other.id) && vsp > 0) || place_meeting(x, y + 1, other.id)) && state == PlayerState.cottondrill)
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == PlayerState.minecart)
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && (state == PlayerState.fireass || state == PlayerState.fireassdash))
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x, y + vsp, other.id) || place_meeting(x, y + sign(vsp), other.id)) && (state == PlayerState.fireass || state == PlayerState.fireassdash))
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == PlayerState.oldtaunt)
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x, y + vsp, other.id) || place_meeting(x, y + sign(vsp), other.id)) && state == PlayerState.oldtaunt)
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == PlayerState.oldtaunt)
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x, y + vsp, other.id) || place_meeting(x, y + sign(vsp), other.id)) && state == PlayerState.oldtaunt)
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && (state == PlayerState.frostburnnormal || state == PlayerState.frostburnjump || state == PlayerState.frostburnslide))
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x, y + vsp, other.id) || place_meeting(x, y + sign(vsp), other.id)) && (state == PlayerState.frostburnjump || state == PlayerState.frostburnslide))
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == PlayerState.bottlerocket && substate == 0)
	{
		with (other.id)
			instance_destroy();
	}
	
	if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && state == PlayerState.doughmountspin)
	{
		with (other.id)
			instance_destroy();
	}
}

with (obj_creamThief)
{
	if (place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id))
	{
		with (other.id)
			instance_destroy();
	}
}

if (place_meeting(x, y, obj_bombExplosionPlayer) && instance_place(x, y, obj_bombExplosionPlayer).frog)
	instance_destroy();

if (sprite_animation_end())
{
	switch (sprite_index)
	{
		case spr_chocofrogbig_bumpR:
		case spr_chocofrogbig_bumpL:
			sprite_index = spr_chocofrogbig;
			break;
	}
}
