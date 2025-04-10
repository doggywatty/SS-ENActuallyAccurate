var target_x = xstart;
if (obj_soundTest.pauseStatus)
{
	if (obj_soundTest.musicPlaying)
	{
		sprite_index = spr_st_painterQueen_dance;
		target_x += wave(-75, 75, 8, 0);
	}
	else
	{
		sprite_index = spr_st_painterQueen_idle;
		target_x += wave(-25, 25, 12, 0);
	}
}
else
	sprite_index = spr_st_painterQueen_idle;

x = lerp(x, target_x, 0.3);
