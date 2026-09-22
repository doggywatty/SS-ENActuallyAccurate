//PADDINGPADDINGPADDINGPADDINGPADDINGPA
global.instancelist = ds_list_create();

function check_and_destroy(_x, _y, _obj, _checkfunc = noone)
{
	if (!place_meeting(_x, _y, _obj))
		return false;
	
	var _result = false;
	var _num = instance_place_list(_x, _y, _obj, global.instancelist, false);
	
	if (_num > 0)
	{
		for (var i = 0; i < ds_list_size(global.instancelist); i++)
		{
			with (ds_list_find_value(global.instancelist, i))
			{
				if (_checkfunc == noone || _checkfunc(other.id, id))
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
	static dont_break_worms = function(_checkfunc, _obj)
	{
		return _obj.object_index != obj_gummyWormBump;
	};
	
	var old_mask = mask_index;
	
	if (state == PlayerState.machtumble2)
		mask_index = spr_player_mask;
	
	var _player_dir = sign(obj_player1.hsp) ? max(obj_player1.xscale, obj_player1.hsp) : min(obj_player1.xscale, obj_player1.hsp);
	var side_to_side_states = [PlayerState.mach2, PlayerState.charge, PlayerState.slipnslide, PlayerState.frostburnnormal, PlayerState.frostburnjump, PlayerState.frostburnslide, PlayerState.grind, PlayerState.hang, PlayerState.trick, PlayerState.geyser, PlayerState.mach3, PlayerState.run, PlayerState.unknownrun, PlayerState.machroll, PlayerState.cottonroll, PlayerState.machtumble2, PlayerState.dodgetumble, PlayerState.uppercut, PlayerState.parry, PlayerState.puddle, PlayerState.tumble, PlayerState.door, PlayerState.comingoutdoor, PlayerState.minecart, PlayerState.doughmount, PlayerState.doughmountspin, PlayerState.fireassdash, PlayerState.cottondig, PlayerState.machtumble, PlayerState.wallkick];
	
	if (array_contains(side_to_side_states, state) || (state == PlayerState.grab && sprite_index == spr_swingDing) || (state == PlayerState.bottlerocket && substate == 0))
	{
		check_and_destroy(x + hsp, y, obj_destructibles);
		check_and_destroy(x + sign(hsp), y, obj_destructibles);
		check_and_destroy(x + xscale, y, obj_destructibles);
	}
	
	if ((state == PlayerState.cotton && ((momentum && movespeed >= 12) || sprite_index == spr_player_PZ_werecotton_spin)) || state == PlayerState.wallkick || state == PlayerState.geyser || state == PlayerState.cottondig || state == PlayerState.fling_launch)
	{
		check_and_destroy(x + hsp, y + vsp, obj_destructibles);
		check_and_destroy(x + sign(hsp), y + sign(vsp), obj_destructibles);
	}
	
	if (((state == PlayerState.machtumble2 || state == PlayerState.cottondig || state == PlayerState.superslam || state == PlayerState.puddle) && vsp >= 0) || (state == PlayerState.cottondrill || (state == PlayerState.bottlerocket && substate == 2) || state == PlayerState.geyser) || ((state == PlayerState.climbwall || state == PlayerState.wallkick || state == PlayerState.uppercut) && vsp < 0))
	{
		check_and_destroy(x, y + vsp, obj_destructibles);
		check_and_destroy(x, y + sign(vsp), obj_destructibles);
		check_and_destroy(x, y + vsp + 2, obj_destructibles);
	}
	
	if (vsp >= 0 && (state == PlayerState.puddle || state == PlayerState.frostburnjump || state == PlayerState.superslam || state == PlayerState.wallkick || (state == PlayerState.freefall || state == PlayerState.freefallland)))
	{
		if (state == PlayerState.puddle || (state == PlayerState.frostburnjump && sprite_index == spr_player_PZ_frostburn_spin) || (state == PlayerState.superslam && freeFallSmash >= 10) || ((state == PlayerState.freefall || state == PlayerState.freefallland) && freeFallSmash >= 10))
		{
			check_and_destroy(x, y + vsp, obj_metalblock);
			check_and_destroy(x, y + sign(vsp), obj_metalblock);
			check_and_destroy(x, y + 1, obj_metalblock);
		}
		
		check_and_destroy(x, y + vsp, obj_destructibles);
		check_and_destroy(x, y + sign(vsp), obj_destructibles);
		check_and_destroy(x, y + vsp + 2, obj_destructibles);
	}
	
	if ((state == PlayerState.jump || state == PlayerState.Sjump || state == PlayerState.mach2 || state == PlayerState.mach3 || state == PlayerState.wallkick) && vsp <= grav)
	{
		var ceiling_hit_head = check_and_destroy(x, y - 1, obj_destructibles, dont_break_worms);
		
		if (ceiling_hit_head && (state == PlayerState.jump || state == PlayerState.mach2 || state == PlayerState.mach3) && !place_meeting(x, y - 1, obj_destructibles))
		{
			vsp = grav;
			jumpStop = true;
		}
		
		check_and_destroy(x, y - 1, obj_gummyWormBump);
	}
	
	if (state == PlayerState.grabdash)
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
	
	if (state == PlayerState.machslide || state == PlayerState.climbwall)
		check_and_destroy(x + sign(hsp), y + sign(vsp), obj_parent_clutterDestroyable);
	
	if (state == PlayerState.jump || state == PlayerState.normal)
	{
		check_and_destroy(x, y + 1, obj_parent_clutterDestroyable);
		check_and_destroy(x, y + vsp, obj_parent_clutterDestroyable);
		check_and_destroy(x, y + sign(vsp), obj_parent_clutterDestroyable);
	}
	
	mask_index = old_mask;
}

function scr_baddie_collide_destroyables()
{
	if (state == PlayerState.climbwall || canBreakBlocks)
	{
		check_and_destroy(x + hsp, y + vsp, obj_destructibles);
		check_and_destroy(x + sign(hsp), y + sign(vsp), obj_destructibles);
	}
}
