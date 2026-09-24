with (other)
{
	if (key_up && !place_meeting_collision(other.x + (other.sprite_width / 2), round(y), Exclude.MOVING | Exclude.PLATFORMS) && !inputLadderBuffer && (state == PlayerState.normal || state == PlayerState.uppercut || state == PlayerState.mach2 || state == PlayerState.mach3 || state == PlayerState.mach1 || state == PlayerState.jump) && state != PlayerState.hurt && state != PlayerState.machslide && state != PlayerState.freefall && state != PlayerState.freefallland)
	{
		hsp = 0;
		vsp = 0;
		state = PlayerState.ladder;
		x = other.x + (other.sprite_width / 2);
		y = round(y);
		
		if ((y % 2) == 1)
			y -= 1;
	}
}
