if playerID.x != other.x
	playerID.xscale = sign(other.x - playerID.x);

with playerID
{
	if (state != States.parry)
	{
		sprite_index = choose(spr_parry1, spr_parry2, spr_parry3);
		image_index = 0;
		image_speed = 0.35;
		movespeed = 8;
		flash = true;
		create_particle(x, y, spr_parryeffect);
		repeat 3
			create_radiating_particle(x, y, spr_fuckassOrb, 0, false, 7, 10, 10);		
		event_play_oneshot("event:/SFX/player/parry", x, y);
		state = States.parry;
	}
}

with other.id
{
	switch object_index
	{
		case obj_crackerkicker_kickhitbox:
		case obj_hurtbox_baddie:
		case obj_cottonwitch_beambox:
		case obj_forkhitbox:
			if instance_exists(baddieID)
				instance_destroy(baddieID);
			break;
		case obj_blimp_proj:
			instance_destroy(id, false);
			instance_create(x, y, obj_bombExplosionMini, 
			{
				hurtPlayers: false
			});
			if instance_exists(baddieID)
				instance_destroy(baddieID);
			break;
		case obj_pickaxe:
			instance_destroy();
			break;
		case obj_snowMintProjectile:
			bumpcount++;
			var _dir = sign(image_xscale);
			if (x != other.x)
				_dir = sign(x - other.x);
			image_xscale = _dir;
			break;
		case obj_dartTrap_projectile:
			if !parried
			{
				alarm[1] = 90;
				parried = true;
				var _dir = sign(image_xscale);
				if (x != other.x)
					_dir = sign(x - other.x);
				image_xscale = _dir;
			}
			break;
		case obj_guardian:
			if (state != States.charge)
			{
				state = States.charge;
				sprite_index = spr_aim;
				image_index = 0;
				movespeed = max(movespeed, 12);
				chaseActive = false;
				stuntime = 35;
				targetx = x;
				targety = y;
			}
			break;
	}
}

with obj_parent_enemy
{
	if (distance_to_object(other.id) <= 84)
	{
		hsp = other.image_xscale * 25;
		vsp = 0;
		hp = 0;
		thrown = 1;
		markedForDeath = true;
	}
}

instance_destroy();
