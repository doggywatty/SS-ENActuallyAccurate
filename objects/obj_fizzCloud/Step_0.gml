if (point_in_circle(x, y, obj_parent_player.x + (75 * obj_parent_player.xscale), obj_parent_player.y, 125) && obj_parent_player.inhaling && state != EnemyState.inhaled)
	state = EnemyState.inhaled;

if (state != PlayerState.stun)
	depth = 0;

if (state != EnemyState.thrown && state != PlayerState.freezeframe)
	thrown = 0;

enemyAttackTimer = max(enemyAttackTimer - 1, 0);

if (((obj_parent_player.x > (x - 50) && obj_parent_player.x < (x + 50)) && (y <= (obj_parent_player.y + 300) && y >= (obj_parent_player.y - 300))) && obj_parent_player.state != PlayerState.cotton && obj_parent_player.state != PlayerState.cottondrill && obj_parent_player.state != PlayerState.door && obj_parent_player.state != PlayerState.cottonroll)
{
	if (state != EnemyState.attack && enemyAttackTimer <= 0 && obj_parent_player.state != PlayerState.cotton)
	{
		if (state == EnemyState.float)
		{
			image_index = 0;
			state = EnemyState.attack;
			
			if (x != obj_parent_player.x)
				image_xscale = sign(obj_parent_player.x - x);
			
			sprite_index = spr_throw;
		}
	}
}

if (state == EnemyState.thrown)
	grav = 0.5;
else
	grav = 0;

if (state == EnemyState.normal)
	state = EnemyState.float;

event_inherited();

if (state != EnemyState.attack)
	scr_scareenemy();
