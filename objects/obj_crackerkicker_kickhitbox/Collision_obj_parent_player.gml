if (place_meeting(x, y, obj_parryhitbox) || global.freezeframe)
	exit;

with (other.id)
{
	if (instance_exists(other.baddieID) && !cutscene && scr_transformationCheck(state) == undefined && !hurted && state != states.grab && state != states.shotgunjump && state != states.stunned && state != states.noclip && state != states.runonball && state != states.ladder && state != states.parry && state != states.crouchjump && state != states.bossintro && state != states.keyget && state != states.tackle && sprite_index != spr_tumbleend)
	{
		state = states.runonball;
		image_speed = 0.35;
		xscale = other.baddieID.image_xscale;
		movespeed = 10;
		vsp = 0;
		sprite_index = spr_tumble;
	}
}

if (instance_exists(baddieID))
	baddieID.baddieInvincibilityBuffer = 50;
