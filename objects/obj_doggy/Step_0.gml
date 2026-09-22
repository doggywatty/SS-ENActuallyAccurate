if (flash && alarm[2] <= 0)
{
}

if (state != PlayerState.stun)
	depth = 0;

if (state != PlayerState.charge && state != PlayerState.freezeframe)
	thrown = 0;

event_inherited();

if (state != PlayerState.titlescreen && state != PlayerState.frozen)
	scr_scareenemy();

enemyAttackTimer = max(enemyAttackTimer - 1, 0);
ragereset = max(ragereset - 1, 0);

if (state == PlayerState.frozen)
	enemyAttackTimer = 0;

if (point_in_rectangle(obj_parent_player.x, obj_parent_player.y, x - 300, y - 50, x + 300, y + 50) && obj_parent_player.state != PlayerState.door && obj_parent_player.state != PlayerState.comingoutdoor)
{
	if ((state == PlayerState.frozen || state == PlayerState.frozen) && enemyAttackTimer <= 0)
	{
		image_index = 0;
		flash = true;
		fmod_studio_event_instance_start(sndCharge);
		create_heat_afterimage(afterimagetypes.plain);
		state = PlayerState.titlescreen;
		
		if (x != obj_parent_player.x)
			image_xscale = sign(obj_parent_player.x - x);
		
		sprite_index = spr_badmarsh_ragestart;
	}
}
