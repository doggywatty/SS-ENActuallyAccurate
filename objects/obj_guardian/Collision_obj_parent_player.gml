if (sprite_index != spr_guardian_wakingUp && state == states.Nhookshot && chaseActive && !(other.state == states.ladder || other.state == states.parry))
{
	scr_hurtplayer(other);
	
	with (obj_achievementTracker)
		tookGuardianDamage = true;
}
