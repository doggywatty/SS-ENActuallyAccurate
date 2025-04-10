global.instancelist = ds_list_create();

function check_and_destroy(_x, _y, _object, checkfunc = -4)
{
	if !place_meeting(_x, _y, _object)
		return false;
	
	var _result = false;
	var _num = instance_place_list(_x, _y, _object, global.instancelist, false);
	if _num > 0
	{
		for (var i = 0; i < ds_list_size(global.instancelist); i++)
		{
			with ds_list_find_value(global.instancelist, i)
			{
				if checkfunc == -4 || checkfunc(other.id, id)
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
	static dont_break_worms = function(checkfunc, _object)
	{
		return _object.object_index != obj_gummyWormBump;
	};
	
	var old_mask = mask_index;
	if state == States.machtumble2
		mask_index = spr_player_mask;
	
	var _player_dir = sign(obj_player1.hsp) ? max(obj_player1.xscale, obj_player1.hsp) : min(obj_player1.xscale, obj_player1.hsp);
	var side_to_side_states = [
		States.mach2, States.charge, States.slipnslide, States.frostburnnormal,
		States.frostburnjump, States.frostburnslide, States.grind, States.hang,
		States.trick, States.geyser, States.mach3, States.run, States.unknownrun,
		States.machroll, States.cottonroll, States.machtumble2, States.dodgetumble,
		States.uppercut, States.parry, States.puddle, States.tumble, States.door,
		States.comingoutdoor, States.minecart, States.doughmount, States.doughmountspin,
		States.fireassdash, States.cottondig, States.machtumble, States.wallkick
	];
	
	if (array_contains(side_to_side_states, state) || (state == States.grab && sprite_index == spr_swingDing) || (state == States.bottlerocket && substate == 0))
	{
		check_and_destroy(x + hsp, y, obj_destructibles);
		check_and_destroy(x + sign(hsp), y, obj_destructibles);
		check_and_destroy(x + xscale, y, obj_destructibles);
	}
	
	if ((state == States.machroll && sprite_index == spr_dive) || (state == States.cotton && momentum && movespeed >= 12) || state == States.wallkick || state == States.geyser || state == States.cottondig || state == States.fling_launch)
	{
		check_and_destroy(x + hsp, y + vsp, obj_destructibles);
		check_and_destroy(x + sign(hsp), y + sign(vsp), obj_destructibles);
	}
	
	if (((state == States.machtumble2 || state == States.cottondig || state == States.superslam || state == States.puddle) && vsp >= 0) || (state == States.cottondrill || (state == States.bottlerocket && substate == 2) || state == States.geyser) || ((state == States.climbwall || state == States.wallkick || state == States.uppercut) && vsp < 0))
	{
		check_and_destroy(x, y + vsp, obj_destructibles);
		check_and_destroy(x, y + sign(vsp), obj_destructibles);
		check_and_destroy(x, y + vsp + 2, obj_destructibles);
	}
	
	if (vsp >= 0 && (state == States.puddle || state == States.frostburnjump || state == States.superslam || state == States.wallkick || (state == States.freefall || state == States.freefallland)))
	{
		if (state == States.puddle || (state == States.frostburnjump && sprite_index == spr_player_PZ_frostburn_spin) || (state == States.superslam && freeFallSmash >= 10) || ((state == States.freefall || state == States.freefallland) && freeFallSmash >= 10))
		{
			check_and_destroy(x, y + vsp, obj_metalblock);
			check_and_destroy(x, y + sign(vsp), obj_metalblock);
			check_and_destroy(x, y + 1, obj_metalblock);
		}
		
		check_and_destroy(x, y + vsp, obj_destructibles);
		check_and_destroy(x, y + sign(vsp), obj_destructibles);
		check_and_destroy(x, y + vsp + 2, obj_destructibles);
	}
	
	if ((state == States.jump || state == States.Sjump || state == States.mach2 || state == States.mach3 || state == States.wallkick) && vsp <= grav)
	{
		var ceiling_hit_head = check_and_destroy(x, y - 1, obj_destructibles, dont_break_worms);
		if (ceiling_hit_head && (state == States.jump || state == States.mach2 || state == States.mach3) && !place_meeting(x, y - 1, obj_destructibles))
		{
			vsp = grav;
			jumpStop = true;
		}
	}
	
	if (state == States.grabdash)
	{
		with obj_destructibles
		{
			if (place_meeting(x - obj_parent_player.hsp, y, obj_parent_player))
			{
				var _player = instance_nearest(x, y, obj_parent_player);
				DestroyedBy = _player;
				event_user(0);
			}
		}
	}
	
	if (state == States.machslide || state == States.climbwall)
		check_and_destroy(x + sign(hsp), y + sign(vsp), obj_parent_clutterDestroyable);
	
	if (state == States.jump || state == States.normal)
	{
		check_and_destroy(x, y + 1, obj_parent_clutterDestroyable);
		check_and_destroy(x, y + vsp, obj_parent_clutterDestroyable);
		check_and_destroy(x, y + sign(vsp), obj_parent_clutterDestroyable);
	}
	
	mask_index = old_mask;
}

function scr_baddie_collide_destroyables()
{
	if (state == States.climbwall || canBreakBlocks)
	{
		check_and_destroy(x + hsp, y + vsp, obj_destructibles);
		check_and_destroy(x + sign(hsp), y + sign(vsp), obj_destructibles);
	}
}
