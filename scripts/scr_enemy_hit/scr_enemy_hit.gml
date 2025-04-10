function scr_enemy_hit()
{
	weakThrowHit = false;
	sprite_index = baddieSpriteDead;
	image_speed = 0.35;
	with (create_afterimage(AfterImageType.plain, image_xscale))
	{
		image_alpha = 0.6;
		vanish = true;
	}
	
	var impact = false;
	var old_weakThrowHit = weakThrowHit;
	if !weakThrowHit && throwAntiGrav
	{
		if (abs(hitHsp) > abs(hitVsp))
			hitVsp = 0;
		hsp = hitHsp;
		vsp = hitVsp;
	}
	if weakThrowHit
	{
		hitHsp = hsp;
		hitVsp = vsp;
	}
	
	if ((vsp > 0 && (place_meeting_collision(x, y + 1) || place_meeting(x, y + 1, obj_vertical_hallway)) && !place_meeting(x, y + 1, obj_destructibles)) || (hsp != 0 && (place_meeting_collision(x + sign(hitHsp), y) || place_meeting(x + sign(hitHsp), y, obj_hallway)) && !place_meeting(x + sign(hitHsp), y, obj_destructibles)))
	{
		vsp = -5;
		weakThrowHit = false;
		if (hitHsp != 0 || hsp != 0)
		{
			hsp = 5 * -sign(hsp);
			hitHsp = 5 * -sign(hitHsp);
		}
		impact = true;
	}
	if ((vsp < 0 || hitVsp != 0) && (place_meeting_collision(x, y - 1) || place_meeting(x, y - 1, obj_vertical_hallway)) && !place_meeting(x, y + hitVsp, obj_destructibles) && (!weakThrowHit || shoulderbashed <= 0))
	{
		vsp = 5;
		weakThrowHit = false;
		impact = true;
	}
	
	if impact
	{
		repeat 2
		{
			instance_create(x, y, obj_slapstar);
			instance_create(x, y, obj_baddieGibs);
		}
		
		create_particle(x, y, spr_enemypuncheffect);
		event_play_oneshot("event:/SFX/player/punch", x, y);
		flash = true;
		throwAntiGrav = false;
		
		if (object_get_parent(object_index) == obj_parent_boss)
		{
			hsp *= 1.5;
			baddieStunTimer = 0;
			state = States.frozen;
			exit;
		}
		if canBeKilled
		{
			instance_destroy();
			exit;
		}
		state = States.charge;
	}
}
