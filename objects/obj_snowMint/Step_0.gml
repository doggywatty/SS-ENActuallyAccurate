if (point_in_circle(x, y, obj_parent_player.x + ((75 * obj_parent_player.xscale) + inhaleStrength), obj_parent_player.y, 125) && obj_parent_player.inhaling && state != enemystates.inhale)
	state = enemystates.inhale;

enemyAttackTimer = max(enemyAttackTimer - 1, 0);

if (((obj_parent_player.x > (x - 400) && obj_parent_player.x < (x + 400)) && (y <= (obj_parent_player.y + 60) && y >= (obj_parent_player.y - 60))) && obj_parent_player.state != states.bossintro && obj_parent_player.state != states.keyget && obj_parent_player.state != states.grab && obj_parent_player.state != states.tackle)
{
	if (state != states.titlescreen && enemyAttackTimer <= 0 && obj_parent_player.state != states.bossintro)
	{
		if (state == states.frozen || state == states.frozen)
		{
			image_index = 0;
			state = states.titlescreen;
			
			if (x != obj_parent_player.x)
				image_xscale = sign(obj_parent_player.x - x);
			
			sprite_index = spr_throw;
		}
	}
}

if (state != states.charge)
	depth = 0;

if (state != states.slap && state != states.boxxedpep)
	thrown = 0;

event_inherited();
scr_scareenemy();
