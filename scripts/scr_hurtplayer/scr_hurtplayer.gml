function scr_hurtplayer(arg0 = obj_parent_player, arg1)
{
	if (!global.freezeframe && arg0.state != states.mach3 && arg0.state != states.gameover && arg0.state != states.crouchjump && arg0.state != states.superslam)
	{
		with (arg0)
		{
			if (cutscene)
				continue;
			
			if (state == states.noclip)
				continue;
			
			if (sprite_index == spr_supertaunt1 || sprite_index == spr_supertaunt2 || sprite_index == spr_supertaunt3 || sprite_index == spr_supertaunt4)
				continue;
			
			if (state == states.victory)
			{
				sprite_index = spr_player_PZ_hitWall_mach3;
				state = states.throwing;
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
			else if (state == states.bossintro || state == states.keyget || state == states.tackle || state == states.slipnslide || state == states.parry || state == states.ladder)
			{
			}
			else if (state == states.barrelmach2)
			{
			}
			else if (state != states.superslam && state != states.gottreasure && !hurted && !cutscene && state != states.throwing && state != states.runonball)
			{
				if (state == states.punch || state == states.backkick)
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
				state = states.superslam;
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
	var _states = [states.titlescreen, states.noclip, states.mach3, states.knightpep, states.Sjumpland, states.stunned, states.grab, states.shotgunjump];
	return array_contains(_states, arg0.state);
}

function player_can_hurt(arg0 = obj_parent_player)
{
	var _states = [states.bossintro, states.keyget, states.tackle, states.slipnslide, states.parry, states.ladder];
	return !array_contains(_states, arg0.state) && !player_complete_invulnerability(arg0);
}
