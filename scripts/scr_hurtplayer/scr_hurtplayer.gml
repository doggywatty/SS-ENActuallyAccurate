function scr_hurtplayer(arg0 = obj_parent_player, arg1)
{
	if (!global.freezeframe && arg0.state != PlayerState.actor && arg0.state != PlayerState.parry && arg0.state != PlayerState.dodgetumble && arg0.state != PlayerState.hurt)
	{
		with (arg0)
		{
			if (cutscene)
				continue;
			
			if (state == PlayerState.noclip)
				continue;
			
			if (sprite_index == spr_supertaunt1 || sprite_index == spr_supertaunt2 || sprite_index == spr_supertaunt3 || sprite_index == spr_supertaunt4)
				continue;
			
			if (state == PlayerState.minecart)
			{
				sprite_index = spr_player_PZ_hitWall_mach3;
				state = PlayerState.bump;
				hsp = 2.5 * xscale;
				vsp = -3;
				machTwo = 0;
				image_index = 0;
				instance_create(x, y, obj_bombExplosion);
				
				for (var i = 0; i < (sprite_get_number(spr_minecartdebris) - 1); i++)
				{
					with (create_debris(x + random_range(-10, 10), y + random_range(-10, 10), spr_minecartdebris))
						image_index = i;
				}
			}
			else if (state == PlayerState.cotton || state == PlayerState.cottondrill || state == PlayerState.cottonroll || state == PlayerState.cottondig || state == PlayerState.fling_launch || state == PlayerState.fling)
			{
			}
			else if (state == PlayerState.bottlerocket)
			{
			}
			else if (state != PlayerState.hurt && state != PlayerState.taunt && !hurted && !cutscene && state != PlayerState.bump && state != PlayerState.tumble)
			{
				if (state == PlayerState.doughmount || state == PlayerState.doughmountspin)
				{
					with (instance_create(x, y, obj_dogMount))
					{
						image_xscale = other.xscale;
						sprite_index = spr_dogMount_kick;
						vsp = -16;
						hsp = -image_xscale * 16;
					}
				}
				
				event_play_oneshot("event:/SFX/player/hurt", x, y);
				create_particle(x, y, spr_bangEffect);
				create_particle(x, y, spr_parryeffect);
				state = PlayerState.hurt;
				alarm[7] = 120;
				scr_sleep_ext(100);
				hurted = true;
				
				if (chance(50))
					fmod_studio_event_instance_start(voiceHurt);
				
				global.HurtCounter += 1;
				global.LocalHurtCounter += 1;
				
				if ((global.LocalHurtCounter % 10) == 0 && global.LocalHurtCounter >= 10)
				{
					var _string = lang_get("prompt_hurt", [lang_get($"prompt_{scr_getCharacterPrefix(global.playerCharacter)}"), global.LocalHurtCounter]);
					scr_queueToolTipPrompt($"[shake]{_string}");
					scr_queueTVAnimation(randomize_animations(global.TvSprPlayer_HurtExp));
				}
				else
				{
					scr_queueTVAnimation(global.TvSprPlayer_Hurt, 60);
				}
				
				sprite_index = (sign(image_xscale) == other.image_xscale) ? spr_hurtjump : spr_hurt;
				movespeed = !is_undefined(arg1) ? arg1 : 8;
				global.ComboTime = clamp(global.ComboTime - 25, 0, 60);
				var _oldcollect = global.Collect;
				global.Collect = max(global.Collect - 50, 0);
				var _repeat = clamp(round((_oldcollect - global.Collect) / 10), 0, 15);
				
				if (_oldcollect > 0)
				{
					instance_create(x, y, obj_pointLoseNumber, 
					{
						image_blend: c_red,
						number: string(global.Collect - _oldcollect)
					});
					
					repeat (_repeat)
						instance_create(x, y, obj_collectableLoss);
				}
				
				instance_create(x, y, obj_spikehurteffect);
				
				repeat (5)
				{
					create_radiating_particle(x, y, spr_fuckassOrb, 0, false, 7, 10, 10);
					instance_create(x, y, obj_hurtStars);
				}
				
				image_index = 0;
				flash = true;
				vsp = -12;
				return true;
			}
		}
	}
	
	return false;
}

function player_complete_invulnerability(arg0 = obj_parent_player)
{
	var _states = [PlayerState.titlescreen, PlayerState.noclip, PlayerState.actor, PlayerState.gameover, PlayerState.talkto, PlayerState.comingoutdoor, PlayerState.door, PlayerState.victory];
	return array_contains(_states, arg0.state);
}

function player_can_hurt(arg0 = obj_parent_player)
{
	var _states = [PlayerState.cotton, PlayerState.cottondrill, PlayerState.cottonroll, PlayerState.cottondig, PlayerState.fling_launch, PlayerState.fling];
	return !array_contains(_states, arg0.state) && !player_complete_invulnerability(arg0);
}
