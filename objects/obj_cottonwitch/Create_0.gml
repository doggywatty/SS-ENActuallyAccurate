event_inherited();
baddieSpriteIdle = undefined;
baddieSpriteWalk = spr_cottonwitch_walk;
baddieSpriteStun = spr_cottonwitch_stunned;
baddieSpriteScared = spr_cottonwitch_scared;
baddieSpriteTurn = undefined;
baddieSpriteHit = undefined;
baddieSpriteDead = spr_cottonwitch_dead;
enemyAttackTimerMax = 300;

enemyAttack_TriggerEvent = function()
{
	if (enemyAttackTimer <= 0 && scr_enemy_playerisnear(410, 130) && state == States.frozen)
	{
		enemyAttackTimer = enemyAttackTimerMax;
		hsp = 0;
		state = States.titlescreen;
		sprite_index = spr_cottonwitch_vanish;
		image_index = 0;
	}
};

enemyState_Attack = function()
{
	var target_player = get_nearestPlayer();
	hsp = 0;
	
	if (sprite_index == spr_cottonwitch_vanish && sprite_animation_end())
		sprite_index = spr_cottonwitch_invis;
	
	if (sprite_index == spr_cottonwitch_invis)
		vsp = 0;
	
	if (!place_meeting_collision(target_player.x, target_player.y) && sprite_index == spr_cottonwitch_invis)
	{
		instance_create(x, y, obj_poofeffect);
		image_index = 0;
		sprite_index = spr_cottonwitch_appear;
		x = target_player.x;
		y = target_player.y;
	}
	
	if (sprite_index == spr_cottonwitch_appear && sprite_animation_end())
	{
		image_index = 0;
		sprite_index = spr_cottonwitch_beamstart;
		image_xscale = face_obj(target_player);
	}
	
	if (sprite_index == spr_cottonwitch_beamstart && sprite_animation_end())
	{
		image_index = 0;
		sprite_index = spr_cottonwitch_beam;
		fmod_studio_event_instance_start(sndBeamAttack);
		enemyAttackTimer = enemyAttackTimerMax;
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
			if (sprite_animation_end())
			{
				state = States.frozen;
				enemyAttackTimer = enemyAttackTimerMax;
			}
		}
	}
	
	if (sprite_index != spr_cottonwitch_beam)
	{
		image_speed = 0.5;
		with obj_cottonwitch_beambox
		{
			if (baddieID == other.id)
				instance_destroy();
		}
	}
	else
		image_speed = 0.35;
};

enemyDeath_SpawnBody = function()
{
	with instance_create(x, y, obj_baddieDead)
	{
		image_xscale = other.image_xscale;
		image_blend = other.image_blend;
		sprite_index = other.baddieSpriteDead;
		paletteSprite = other.paletteSprite;
		paletteSelect = other.paletteSelect;
	}
	with instance_create(x, y + 38, obj_clutterCottonWitch)
	{
		sprite_index = spr_cottonwitch_debris;
		image_xscale = other.image_xscale;
	}
};
