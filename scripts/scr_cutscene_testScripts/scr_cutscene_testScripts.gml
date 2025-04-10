function cutscene_shake_actor(_cutsceneActor, _shake_magx)
{
	var dump = cutscene_get_actor(_cutsceneActor);
	with dump
	{
		shake_magx = _shake_magx;
		shake_dir = 1;
		shake_timer = 0;
	}
	cutscene_event_end();
}
