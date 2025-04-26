if !markedForDeath
{
	var _state = global.freezeframe ? frozenState : state;
	wasInAir = _state == States.titlescreen && !grounded;
}

event_inherited();
canGetScared = grounded && state != States.titlescreen && state != States.burrow;
enemyAttack_TriggerEvent();
burrowTimer = max(burrowTimer - 1, 0);

if (state == States.titlescreen && sprite_index == spr_sluggy_jump)
{
	canBreakBlocks = true;
	doRedAfterImage = true;
	if !instance_exists(hurtboxID)
	{
		with (instance_create(x, y, obj_forkhitbox, 
		{
			ID: other.id
		}))
		{
			other.hurtboxID = id;
			ID = other.id;
			image_xscale = other.image_xscale;
			image_index = other.image_index;
			depth = -1;
			mask_index = spr_sluggy_jumphitbox;
			sprite_index = spr_sluggy_jumphitbox;
		}
	}
}

if (burrowTimer <= 0 && place_meeting(x, y + 1, obj_dirtpatch) && state == States.frozen)
{
	hsp = 0;
	movespeed = 0;
	image_index = 0;
	sprite_index = spr_sluggy_burrow;
	state = States.burrow;
	burrowTimer = burrowTimerMax;
}

var target_player = get_nearestPlayer();
var is_underground = sprite_index == spr_sluggy_underground || (sprite_index == spr_sluggy_undergroundjumpstart && image_index <= 6);
baddieCollisionBoxEnabled = !is_underground || target_player.state == States.mach3;
