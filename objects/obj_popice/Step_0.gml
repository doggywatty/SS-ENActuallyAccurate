if (flash && alarm[2] <= 0)
{
}

if (state != states.charge)
	depth = 0;

if (state != states.slap && state != states.boxxedpep)
	thrown = 0;

event_inherited();

if (state != states.titlescreen)
	scr_scareenemy();

enemyAttackTimer = max(enemyAttackTimer - 1, 0);
ragereset = max(ragereset - 1, 0);

if (((obj_parent_player.x > (x - 400) && obj_parent_player.x < (x + 400)) && (y <= (obj_parent_player.y + 60) && y >= (obj_parent_player.y - 60))) && obj_parent_player.state != states.bossintro && obj_parent_player.state != states.keyget && obj_parent_player.state != states.grab && obj_parent_player.state != states.tackle)
{
	if (state != states.Nhookshot && state != states.titlescreen && enemyAttackTimer <= 0 && obj_parent_player.state != states.bossintro)
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
