var _check = (DestroyedBy.bbox_left > (x + 32) && sign(image_xscale) == 1) || (DestroyedBy.bbox_right < (x - 32) && sign(image_xscale) == -1);

if (_check && !(DestroyedBy.object_index == obj_parent_enemy && DestroyedBy.state == PlayerState.stun))
{
	if (DestroyedBy.object_index == obj_parent_player && ((place_meeting(x, y - DestroyedBy.vsp, DestroyedBy) || place_meeting(x, y - sign(DestroyedBy.vsp), DestroyedBy)) && DestroyedBy.vsp < 0 && DestroyedBy.state == PlayerState.jump))
		DestroyedBy.vsp = 0;
	
	instance_destroy();
}
