if (clone && instance_exists(realBump) && place_meeting(x, y, realBump))
	exit;
if (DestroyedBy.object_index == obj_parent_player || DestroyedBy.object_index == obj_player1 || DestroyedBy.object_index == obj_player2)
{
	if (DestroyedBy.state == States.jump)
	{
	}
	else if (place_meeting(x - DestroyedBy.hsp, y, DestroyedBy) && DestroyedBy.state == States.grabdash)
	{
		with DestroyedBy
		{
			with other.id
				instance_destroy();
			hsp = xscale * -4;
			vsp = -4;
			machTwo = 0;
			image_index = 0;
			
			if (state == States.mach1)
				sprite_index = spr_canehit;
			else
				sprite_index = choose(
					spr_player_PZ_blockbreak_1, spr_player_PZ_blockbreak_2, spr_player_PZ_blockbreak_3,
					spr_player_PZ_blockbreak_4, spr_player_PZ_blockbreak_5, spr_player_PZ_blockbreak_6,
					spr_player_PZ_blockbreak_7
				);
			state = States.tackle;
		}
	}
	else
	{
		with DestroyedBy
		{
			if (freeFallSmash < 10)
			{
				if (state == States.freefall || state == States.freefallland)
				{
					state = States.freefallland;
					var landing_sprite_transitions = [
						[spr_groundPoundfall, spr_groundPoundland],
						[spr_groundPoundstart, spr_groundPoundland],
						[spr_player_PZ_fall_outOfControl, spr_player_PZ_freeFall_land],
						[spr_diveBombfall, spr_diveBombland],
						[spr_diveBombstart, spr_diveBombland]
					];
					for (var i = 0; i < array_length(landing_sprite_transitions); i++)
					{
						if (sprite_index == landing_sprite_transitions[i][0])
							sprite_index = landing_sprite_transitions[i][1];
					}
					image_index = 0;
					vsp = 0;
				}
				else if (state == States.superslam)
				{
					sprite_index = spr_piledriverland;
					event_play_oneshot("event:/SFX/player/groundpound", x, y);
					jumpAnim = true;
					jumpStop = false;
					image_index = 0;
					camera_shake_add(20, 40);
					hsp = 0;
					bounce = 0;
					create_particle(x, y + 35, spr_bangEffect);
					create_particle(x, y, spr_landcloud);
					freefallstart = 0;
					with obj_parent_enemy
					{
						if (bbox_in_camera(id, view_camera[0]) && grounded)
						{
							image_index = 0;
							vsp = -7;
							hsp = 0;
						}
					}
					with baddieGrabbedID
					{
						x = other.x;
						y = other.y;
						scr_instakillEnemy(id, other.id);
					}
					baddieGrabbedID = -4;
				}
			}
		}
		instance_destroy();
	}
}
else
	instance_destroy();
