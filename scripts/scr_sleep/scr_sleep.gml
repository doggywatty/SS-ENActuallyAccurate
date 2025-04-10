function scr_sleep(_freezetime = undefined)
{
	with obj_camera
	{
		if (global.hitstunalarm <= -1 && !global.freezeframe)
		{
			if is_undefined(_freezetime)
				freezetype = false;
			else
			{
				freezeval = _freezetime;
				freezetype = true;
			}
			NextFreeze = true;
		}
	}
}

function scr_sleep_ext(miliseconds)
{
	var time = current_time;
	var ms = miliseconds;
	do {}
	until current_time - time >= round(ms);
	return current_time - time;
}
