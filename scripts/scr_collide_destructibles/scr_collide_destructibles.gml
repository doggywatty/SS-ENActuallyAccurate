global.instancelist = ds_list_create();

function check_and_destroy(arg0, arg1, arg2, arg3 = -4)
{
	if (!place_meeting(arg0, arg1, arg2))
		return false;
	
	var _result = false;
	var _num = instance_place_list(arg0, arg1, arg2, global.instancelist, false);
	
	if (_num > 0)
	{
		for (var i = 0; i < ds_list_size(global.instancelist); i++)
		{
			with (ds_list_find_value(global.instancelist, i))
			{
				if (arg3 == -4 || arg3(other.id, id))
				{
					DestroyedBy = other.id;
					event_user(0);
					_result = true;
				}
			}
		}
		
		ds_list_clear(global.instancelist);
	}
	
	return _result;
}

function scr_collide_destructibles()
{
	static dont_break_worms = function(arg0, arg1)
	{
		return arg1.object_index != obj_gummyWormBump;
	};
	
	var old_mask = mask_index;
	
	if (state == states.crouch)
		mask_index = spr_player_mask;
	
	var _player_dir = sign(obj_player1.hsp) ? max(obj_player1.xscale, obj_player1.hsp) : min(obj_player1.xscale, obj_player1.hsp);
	var side_to_side_states = [(32 << 0), (4 << 0), (22 << 0), (88 << 0), (90 << 0), (89 << 0), (16 << 0), (39 << 0), (75 << 0), (69 << 0), (33 << 0), (3 << 0), (86 << 0), (12 << 0), (57 << 0), (65 << 0), (66 << 0), (48 << 0), (51 << 0), (53 << 0), (54 << 0), (40 << 0), (26 << 0), (61 << 0), (41 << 0), (42 << 0), (68 << 0), (58 << 0), (8 << 0), (7 << 0)];
	
	if (array_contains(side_to_side_states, state) || (state == states.handstandjump && sprite_index == spr_swingDing) || (state == states.barrelmach2 && substate == 0))
	{
		check_and_destroy(x + hsp, y, obj_destructibles);
		check_and_destroy(x + sign(hsp), y, obj_destructibles);
		check_and_destroy(x + xscale, y, obj_destructibles);
	}
	
	if ((state == states.bossintro && ((momentum && movespeed >= 12) || sprite_index == spr_player_PZ_werecotton_spin)) || state == states.cheeseball || state == states.mach2 || state == states.slipnslide || state == states.parry)
	{
		check_and_destroy(x + hsp, y + vsp, obj_destructibles);
		check_and_destroy(x + sign(hsp), y + sign(vsp), obj_destructibles);
	}
	
	if (((state == states.crouch || state == states.slipnslide || state == states.secondjump || state == states.freefallprep) && vsp >= 0) || (state == states.keyget || (state == states.barrelmach2 && substate == 2) || state == states.mach2) || ((state == states.cheesepep || state == states.cheeseball || state == states.ufofloat) && vsp < 0))
	{
		check_and_destroy(x, y + vsp, obj_destructibles);
		check_and_destroy(x, y + sign(vsp), obj_destructibles);
		check_and_destroy(x, y + vsp + 2, obj_destructibles);
	}
	
	if (vsp >= 0 && (state == states.freefallprep || state == states.pal || state == states.secondjump || state == states.cheeseball || (state == states.slam || state == states.skateboard)))
	{
		if (state == states.freefallprep || (state == states.pal && sprite_index == spr_player_PZ_frostburn_spin) || (state == states.secondjump && freeFallSmash >= 10) || ((state == states.slam || state == states.skateboard) && freeFallSmash >= 10))
		{
			check_and_destroy(x, y + vsp, obj_metalblock);
			check_and_destroy(x, y + sign(vsp), obj_metalblock);
			check_and_destroy(x, y + 1, obj_metalblock);
		}
		
		check_and_destroy(x, y + vsp, obj_destructibles);
		check_and_destroy(x, y + sign(vsp), obj_destructibles);
		check_and_destroy(x, y + vsp + 2, obj_destructibles);
	}
	
	if ((state == states.chainsawpogo || state == states.highjump || state == states.pistol || state == states.shotgun || state == states.cheeseball) && vsp <= grav)
	{
		var ceiling_hit_head = check_and_destroy(x, y - 1, obj_destructibles, dont_break_worms);
		
		if (ceiling_hit_head && (state == states.chainsawpogo || state == states.pistol || state == states.shotgun) && !place_meeting(x, y - 1, obj_destructibles))
		{
			vsp = grav;
			jumpStop = true;
		}
		
		check_and_destroy(x, y - 1, obj_gummyWormBump);
	}
	
	if (state == states.pistalaim)
	{
		with (obj_destructibles)
		{
			if (place_meeting(x - obj_parent_player.hsp, y, obj_parent_player))
			{
				var _player = instance_nearest(x, y, obj_parent_player);
				DestroyedBy = _player;
				event_user(0);
			}
		}
	}
	
	if (state == states.machfreefall || state == states.cheesepep)
		check_and_destroy(x + sign(hsp), y + sign(vsp), obj_parent_clutterDestroyable);
	
	if (state == states.chainsawpogo || state == states.normal)
	{
		check_and_destroy(x, y + 1, obj_parent_clutterDestroyable);
		check_and_destroy(x, y + vsp, obj_parent_clutterDestroyable);
		check_and_destroy(x, y + sign(vsp), obj_parent_clutterDestroyable);
	}
	
	mask_index = old_mask;
}

function scr_baddie_collide_destroyables()
{
	if (state == states.cheesepep || canBreakBlocks)
	{
		check_and_destroy(x + hsp, y + vsp, obj_destructibles);
		check_and_destroy(x + sign(hsp), y + sign(vsp), obj_destructibles);
	}
}
