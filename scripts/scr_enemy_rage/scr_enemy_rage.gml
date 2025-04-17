function scr_enemy_rage()
{
	switch object_index
	{
		case obj_eyescream:
			var p = get_nearestPlayer();
			var _dir = point_direction(x, y, p.x, p.y);
			switch sprite_index
			{
				case spr_eyescreamsandwich_divestart:
					if sprite_animation_end()
					{
						hsp = lengthdir_x(10, _dir);
						vsp = lengthdir_y(10, _dir);
						ragereset = 50;
						sprite_index = spr_eyescreamsandwich_dive;
					}
					break;
				case spr_eyescreamsandwich_dive:
					x += hsp;
					y += vsp;
					if (ragereset <= 0)
					{
						state = EnemyStates.eyescream;
						ragereset = 200;
					}
					if (place_meeting(x, y, obj_parent_player))
					{
						giveScore = false;
						instance_destroy();
						instance_create(x, y, obj_bombExplosionHarmful);
					}
					break;
			}
			break;
		case obj_doggy:
			image_speed = 0.35;
			if (sprite_index == spr_badmarsh_ragestart)
			{
				hsp = 0;
				if sprite_animation_end()
				{
					sprite_index = spr_badmarsh_rage;
					hsp = image_xscale * 5;
					lunged = 50;
					with (instance_create(x, y, obj_forkhitbox, 
					{
						ID: other.id
					}))
					{
						ID = other.id;
						image_xscale = other.image_xscale;
						depth = -1;
					}
				}
			}
			else if (sprite_index == spr_badmarsh_rage)
			{
				hsp = approach(hsp, image_xscale * 8, 0.3);
				lunged--;
				if (lunged <= 0)
				{
					hsp = image_xscale * 4;
					movespeed = 4;
					sprite_index = spr_badmarsh_rageend;
				}
				if (place_meeting_solid(x + image_xscale, y) && !place_meeting_slope(x, y + 1))
				{
					lunged = 0;
					hsp = image_xscale * 4;
					movespeed = 4;
					sprite_index = spr_badmarsh_rageend;
				}
			}
			else if (sprite_index == spr_badmarsh_rageend)
			{
				hsp = approach(hsp, 0, 0.1);
				if sprite_animation_end()
				{
					state = States.frozen;
					movespeed = 1;
					enemyAttackTimer = 200;
				}
			}
			break;
		case obj_boxFrog:
		case obj_knight:
			if !hitboxcreate
			{
				hitboxcreate = true;
				with (instance_create(x, y, obj_forkhitbox, 
				{
					ID: other.id
				}))
				{
					ID = other.id;
					sprite_index = spr_swordhitbox;
					mask_index = sprite_index;
					image_xscale = other.image_xscale;
					image_index = other.image_index;
					depth = -1;
				}
			}
			if (sprite_index != spr_gumfrog_explode)
			{
				hsp = image_xscale * movespeed;
				movespeed = approach(movespeed, 9, 0.3);
			}
			
			if (place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_slope))
			{
				movespeed = 0;
				if hitboxcreate
				{
					with obj_forkhitbox
					{
						if (ID == other.id)
							instance_destroy();
					}
					hitboxcreate = false;
				}
				image_index = 0;
				sprite_index = spr_gumfrog_explode;
			}
			
			if (sprite_animation_end() && sprite_index == spr_gumfrog_explode)
			{
				movespeed = 1;
				sprite_index = spr_knight_stun;
				state = States.normal;
			}
			break;
		case obj_betonbacon:
			hsp = 0;
			if sprite_animation_end()
			{
				state = States.frozen;
				sprite_index = baddieSpriteWalk;
			}
			break;
		case obj_cottonwitch:
			var target_player = get_nearestPlayer();
			if (sprite_animation_end() && sprite_index == spr_cottonwitch_vanish)
			{
				sprite_index = spr_cottonwitch_invis;
				timer = 0;
			}
			if (timer <= 0 && !place_meeting_collision(target_player.x, target_player.y)
			&& sprite_index != spr_cottonwitch_appear && sprite_index != spr_cottonwitch_beamstart
			&& sprite_index != spr_cottonwitch_beam)
			{
				image_index = 0;
				sprite_index = spr_cottonwitch_appear;
				x = target_player.x;
				y = target_player.y;
			}
			if (sprite_index == spr_cottonwitch_invis)
			{
				hsp = 0;
				vsp = 0;
			}
			if (sprite_animation_end() && sprite_index == spr_cottonwitch_appear)
			{
				image_index = 0;
				sprite_index = spr_cottonwitch_beamstart;
				image_xscale = face_obj(target_player);
			}
			if (sprite_animation_end() && sprite_index == spr_cottonwitch_beamstart)
			{
				image_index = 0;
				sprite_index = spr_cottonwitch_beam;
				fmod_studio_event_instance_start(sndBeamAttack);
				enemyAttackTimer = 300;
			}
			if (sprite_index == spr_cottonwitch_beam)
			{
				hsp = 0;
				if (image_index < 8)
				{
					var hitbox_exists = false;
					with obj_cottonwitch_beambox
					{
						if (baddieID == other.id)
							hitbox_exists = true;
					}
					if !hitbox_exists
					{
						instance_create(x + (image_xscale * 50), y, obj_cottonwitch_beambox, 
						{
							image_xscale: image_xscale,
							baddieID: id
						});
					}
				}
				else
				{
					with obj_cottonwitch_beambox
					{
						if (baddieID == other.id)
							instance_destroy();
					}
					if sprite_animation_end()
					{
						state = States.frozen;
						enemyAttackTimer = 300;
					}
				}
			}
			if (sprite_index != spr_cottonwitch_beam)
				image_speed = 0.5;
			else
				image_speed = 0.35;
			break;
		case obj_sluggy:
			image_speed = 0.35;
			if (sprite_index == spr_sluggy_burrow)
			{
				enemyAttackTimer = jumptimerMax;
				hsp = 0;
				fmod_studio_event_instance_start(sndSluggyDig);
				if sprite_animation_end()
					sprite_index = spr_sluggy_underground;
			}
			
			if (sprite_index == spr_sluggy_underground)
			{
				hsp = (image_xscale * movespeed) + slide;
				slide = approach(slide, 0, 0.2);
				movespeed = 8;
				var target_player = get_nearestPlayer(x, y);
				var playerposition = x - target_player.x;
				var player_present = target_player.x > (x - 40) && target_player.x < (x + 40)
				&& y <= (target_player.y + 250) && y >= (target_player.y - 30);
				if (place_meeting_collision(x + image_xscale, y, Exclude.SLOPES))
					slide = -image_xscale * (movespeed + 4);
				if (playerposition != 0 && image_xscale != -sign(playerposition))
				{
					image_xscale = -sign(playerposition);
					slide = -image_xscale * (movespeed + 4);
				}
				if (distance_to_object(obj_parent_player) < 100 && obj_parent_player.state == States.freefallland)
				{
					hsp = 0;
					vsp = -8;
					grounded = false;
					state = States.charge;
					sprite_index = baddieSpriteStun;
				}
				if ((enemyAttackTimer <= 0 || player_present
				|| !place_meeting(x + hsp, y + 1, obj_dirtpatch))
				&& obj_parent_player.state != States.freefallland)
				{
					sprite_index = spr_sluggy_undergroundjumpstart;
					image_index = 0;
				}
			}
			if (sprite_index == spr_sluggy_undergroundjumpstart)
			{
				hsp = 0;
				if sprite_animation_end()
				{
					state = EnemyStates.slugjump;
					sprite_index = spr_sluggy_jump;
					vsp = -11;
					grounded = false;
				}
			}
			break;
		case obj_painter:
			scr_painter_dash();
			break;
		case obj_fancypancake:
			image_speed = 0.35;
			invisFrames = 100;
			if (sprite_index == spr_golfburger_golf)
			{
				with obj_parent_player
				{
					if (state == States.doughmount || state == States.doughmountspin)
					{
						movelocked = true;
						xscale = other.image_xscale;
						state = States.doughmountpancake;
						image_index = 0;
						sprite_index = spr_player_PZ_dogMount_spin;
						movespeed = abs(movespeed);
						vsp = -5;
						movespeed = 12;
					}
				}
			}
			if (animation_end_old(U, 5))
			{
				movelocked = false;
				sprite_index = spr_golfburger_walk;
				state = States.frozen;
				enemyAttackTimer = 200;
			}
			break;
		case obj_miniHarry:
			if (sprite_index == spr_miniharry_spot)
			{
				movespeed = 0;
				hsp = 0;
			}
			if (sprite_index == spr_miniharry_spot && sprite_animation_end())
				sprite_index = spr_miniharry_run;
			if (sprite_index != spr_miniharry_spot)
			{
				hsp = (image_xscale * movespeed) + slide;
				slide = approach(slide, 0, 0.2);
				movespeed = 8;
				var target_player = get_nearestPlayer(x, y);
				var playerposition = x - target_player.x;
				var player_present = target_player.x > (x - 40) && target_player.x < (x + 40)
				&& y <= (target_player.y + 250) && y >= (target_player.y - 30);
				if (place_meeting_collision(x + image_xscale, y, Exclude.SLOPES))
					slide = -image_xscale * (movespeed + 4);
				if (playerposition != 0 && image_xscale != -sign(playerposition))
				{
					image_xscale = -sign(playerposition);
					slide = -image_xscale * (movespeed + 4);
				}
			}
			image_speed = 0.35;
			break;
	}
}
