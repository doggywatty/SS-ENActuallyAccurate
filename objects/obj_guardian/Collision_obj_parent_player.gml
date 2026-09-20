if (sprite_index != spr_guardian_wakingUp && state == PlayerState.run && chaseActive && !(other.state == PlayerState.fling || other.state == PlayerState.fling_launch))
{
	scr_hurtplayer(other);
	
	with (obj_achievementTracker)
		tookGuardianDamage = true;
}
