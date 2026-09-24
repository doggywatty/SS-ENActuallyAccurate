if (point_in_circle(x, y, obj_parent_player.x + (75 * obj_parent_player.xscale), obj_parent_player.y, 125) && obj_parent_player.inhaling && state != EnemyState.inhaled)
	state = EnemyState.inhaled;

if (state != PlayerState.stun)
	depth = 0;

if (state != EnemyState.thrown && state != PlayerState.freezeframe)
	thrown = 0;

event_inherited();

if (state != EnemyState.attack)
	scr_scareenemy();

enemyAttackTimer = max(enemyAttackTimer - 1, 0);
ragereset = max(ragereset - 1, 0);

if (point_in_rectangle(obj_parent_player.x, obj_parent_player.y, x - 100, y - 50, x + 100, y + 50) && obj_parent_player.state != PlayerState.door && obj_parent_player.state != PlayerState.comingoutdoor)
{
	if (state != EnemyState.attack && state == EnemyState.normal && (obj_parent_player.state == PlayerState.doughmount || obj_parent_player.state == PlayerState.doughmountspin) && enemyAttackTimer <= 0)
	{
		image_index = 0;
		flash = true;
		create_heat_afterimage(AfterImageType.DEFAULT);
		state = EnemyState.attack;
		sprite_index = spr_golfburger_golf;
		enemyAttackTimer = 200;
	}
}

if (sprite_index == spr_golfburger_golf || invisFrames > 0)
	baddieInvincibilityBuffer = 1;
else
	baddieInvincibilityBuffer = 0;

if (invisFrames > 0)
	invisFrames--;
