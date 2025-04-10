function state_player_taunt()
{
	if (sprite_index != spr_player_PZ_freeFallSpin)
	{
		hsp = 0;
		movespeed = 0;
	}
	else
		hsp = xscale * movespeed;
	
	landAnim = false;
	if (sprite_index == spr_taunt || sprite_index == spr_supertaunt1 || sprite_index == spr_supertaunt2 || sprite_index == spr_supertaunt3 || sprite_index == spr_supertaunt4)
	{
		tauntTimer--;
		vsp = 0;
	}
	if (sprite_index == spr_player_PZ_freeFallSpin && place_meeting(x, y + 1, obj_solid))
	{
		state = States.machslide;
		sprite_index = spr_player_PZ_crouchSlide;
	}
	if (sprite_index == spr_taunt)
	{
		if (tauntTimer >= 5 && superTauntCharged && key_up)
		{
			event_play_oneshot("event:/SFX/player/supertaunt", x, y);
			image_index = 0;
			sprite_index = choose(spr_supertaunt1, spr_supertaunt2, spr_supertaunt3, spr_supertaunt4);
		}
		if !instance_exists(parryId)
		{
			parryId = instance_create(x, y, obj_parryhitbox, 
			{
				playerID: id,
				image_xscale: other.xscale
			});
		}
	}
	if (tauntTimer <= 0 && sprite_index == spr_taunt)
		scr_taunt_setVariables();
	
	var supertaunt_sprites = [spr_supertaunt1, spr_supertaunt2, spr_supertaunt3, spr_supertaunt4];
	if (array_contains(supertaunt_sprites, sprite_index))
	{
		vsp = 0;
		hsp = 0;
		superTauntBuffer = 0;
		if superTauntCharged
		{
			for (var i = 0; i < 9; i++)
			{
				var h_sign = (i % 3) - 1;
				var v_sign = floor(i / 3) - 1;
				if (!(h_sign == 0 && v_sign == 0))
				{
					instance_create(x, y, obj_superTauntLightningEffect, 
					{
						hspeed: h_sign * 20,
						vspeed: v_sign * 20
					});
				}
			}
			with obj_parent_enemy
			{
				if (bbox_in_camera(id, view_camera[0]) && !invincibleBaddie)
				{
					enemyDeath_SpawnBody = function()
					{
					};
					create_particle(x, y, spr_bangEffect);
					create_particle(x, y, spr_enemypuncheffect);
					create_particle(x, y, spr_parryeffect);
					repeat 3
					{
						instance_create(x, y, obj_slapstar);
						instance_create(x, y, obj_baddieGibs);
					}
					instance_destroy();
					with instance_create(x, y, obj_shake)
					{
						sprite_index = other.baddieSpriteDead;
						paletteSprite = other.paletteSprite;
						paletteSelect = other.paletteSelect;
						alarm[0] = 20;
					}
				}
			}
			with obj_dartTrap
			{
				if (bbox_in_camera(id, view_camera[0]))
				{
					enemyDeath_SpawnBody = function()
					{
					};
					create_particle(x, y, spr_bangEffect);
					create_particle(x, y, spr_enemypuncheffect);
					create_particle(x, y, spr_parryeffect);
					repeat 3
					{
						instance_create(x, y, obj_slapstar);
						instance_create(x, y, obj_baddieGibs);
					}
					instance_destroy();
					with (instance_create(x, y, obj_shake))
					{
						sprite_index = spr_dartFrog_dead;
						alarm[0] = 20;
					}
				}
			}
			scr_sleep();
			camera_shake_add(10, 30);
			superTauntCharged = false;
		}
		if sprite_animation_end()
		{
			superTauntBuffer = 0;
			superTauntCharged = false;
			scr_taunt_setVariables();
		}
	}
	if sprite_animation_end()
	{
		if (sprite_index == spr_petdog || sprite_index == spr_Timesup)
			state = States.normal;
	}
	if (sprite_index == spr_supertaunt1 || sprite_index == spr_supertaunt2 || sprite_index == spr_supertaunt3 || sprite_index == spr_supertaunt4)
		image_speed = 0.4;
	else if (sprite_index == spr_taunt)
		image_speed = 0;
	else
		image_speed = 0.35;
}
