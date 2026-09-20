with (obj_parent_player)
{
	if (place_meeting(x, y, other.id) && alarm[0] <= 0 && !instance_exists(obj_fadeoutTransition) && key_up2 && grounded && (state == PlayerState.normal || state == PlayerState.Sjumpprep || state == PlayerState.mach2 || state == PlayerState.mach3 || state == PlayerState.run) && state != PlayerState.door && state != PlayerState.victory && state != PlayerState.comingoutdoor)
	{
		with (other)
		{
			sprite_index = spr_soundTest_buttonPressed;
			alarm[0] = 5;
		}
	}
}
