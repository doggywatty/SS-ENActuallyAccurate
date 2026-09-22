function scr_queueTVAnimation(_spr, _buffer = 150)
{
	with (obj_hudManager.HUDObject_TV)
	{
		var roomname = room_get_name(room);
		
		if (_spr == global.TvSprPlayer_Secret && instance_exists(obj_secretfound))
			exit;
		
		if (tvExpressionSprite != _spr)
			tvForceTransition = true;
		
		tvExpressionSprite = _spr;
		tvExpressionBuffer = _buffer;
		var vocal_collectables = [spr_tvHUD_confecti1, spr_tvHUD_confecti2, spr_tvHUD_confecti3, spr_tvHUD_confecti4, spr_tvHUD_confecti5, spr_tvHUD_janitorLap, spr_tvHUD_janitorTreasure, global.TvSprPlayer_KeyGot, global.TvSprPlayer_Happy];
		
		if (chance(50) && array_contains(vocal_collectables, _spr))
			fmod_studio_event_instance_start(get_primaryPlayer().voiceCollect);
	}
}

function scr_queueToolTipPrompt(_prompt = "", _timer = 220)
{
	with (obj_hudManager)
	{
		global.TooltipPrompt = _prompt;
		HUDObject_tooltipPrompts.promptTimer = _timer;
	}
	
	return _timer;
}
