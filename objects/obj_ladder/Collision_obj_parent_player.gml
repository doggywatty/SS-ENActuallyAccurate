with (other)
{
	if (key_up && !place_meeting_collision(other.x + (other.sprite_width / 2), round(y), Exclude.MOVINGANDPLATFORMS) && !inputLadderBuffer && (state == states.normal || state == states.ufofloat || state == states.pistol || state == states.shotgun || state == states.machroll || state == states.chainsawpogo) && state != states.superslam && state != states.machfreefall && state != states.slam && state != states.skateboard)
	{
		hsp = 0;
		vsp = 0;
		state = states.grabbing;
		x = other.x + (other.sprite_width / 2);
		y = round(y);
		
		if ((y % 2) == 1)
			y -= 1;
	}
}
