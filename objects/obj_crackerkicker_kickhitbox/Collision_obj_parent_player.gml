if (place_meeting(x, y, obj_parryhitbox) || global.freezeframe)
	exit;

with (other.id)
{
	if (instance_exists(other.baddieID) && !cutscene && scr_transformationCheck(state) == undefined && !hurted && state != PlayerState.door && state != PlayerState.victory && state != PlayerState.comingoutdoor && state != PlayerState.noclip && state != PlayerState.tumble && state != PlayerState.fling && state != PlayerState.fling_launch && state != PlayerState.dodgetumble && state != PlayerState.cotton && state != PlayerState.cottondrill && state != PlayerState.cottonroll && sprite_index != spr_tumbleend)
	{
		state = PlayerState.tumble;
		image_speed = 0.35;
		xscale = other.baddieID.image_xscale;
		movespeed = 10;
		vsp = 0;
		sprite_index = spr_tumble;
	}
}

if (instance_exists(baddieID))
	baddieID.baddieInvincibilityBuffer = 50;
