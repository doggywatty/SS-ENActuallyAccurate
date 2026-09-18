function scr_enemy_scared()
{
	if (!scare_jump || grounded)
		hsp = 0;
	
	image_speed = 0.35;
	scr_conveyorBeltKinematics();
	
	if (object_index == obj_fizzCloud || object_index == obj_frothCloud || object_index == obj_cottonblimp)
		vsp = 0;
}
