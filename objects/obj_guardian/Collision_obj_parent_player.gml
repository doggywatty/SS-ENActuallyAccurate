if (sprite_index != spr_guardian_wakingUp && state == States.run && chaseActive && !(other.state == States.fling || other.state == States.fling_launch))
{
    scr_hurtplayer(other);
    with obj_achievementTracker
        tookGuardianDamage = true;
}

