if (flash && alarm[2] <= 0)
{
}

if (state != states.charge)
	depth = 0;

if (state != states.slap && state != states.boxxedpep)
	thrown = 0;

event_inherited();

if (state != states.titlescreen && state != states.frozen)
	scr_scareenemy();

enemyAttackTimer = max(enemyAttackTimer - 1, 0);
ragereset = max(ragereset - 1, 0);

if (state == states.frozen)
	enemyAttackTimer = 0;

if (point_in_rectangle(obj_parent_player.x, obj_parent_player.y, x - 300, y - 50, x + 300, y + 50) && obj_parent_player.state != states.grab && obj_parent_player.state != states.stunned)
{
	if ((state == states.frozen || state == states.frozen) && enemyAttackTimer <= 0)
	{
		image_index = 0;
		flash = true;
		fmod_studio_event_instance_start(sndCharge);
		create_heat_afterimage(afterimagetypes.basic);
		state = states.titlescreen;
		
		if (x != obj_parent_player.x)
			image_xscale = sign(obj_parent_player.x - x);
		
		sprite_index = spr_badmarsh_ragestart;
	}
}
