function scr_queueTVAnimation(_exp_spr, _exp_buffer = 150)
{
	with obj_hudManager.HUDObject_TV
	{
		var roomname = room_get_name(room);
		if (_exp_spr == global.TvSprPlayer_Secret && instance_exists(obj_secretfound))
			exit;
		if (tvExpressionSprite != _exp_spr)
			tvForceTransition = true;
		tvExpressionSprite = _exp_spr;
		tvExpressionBuffer = _exp_buffer;
		var vocal_collectables = [
			spr_tvHUD_confecti1, spr_tvHUD_confecti2, spr_tvHUD_confecti3, spr_tvHUD_confecti4,
			spr_tvHUD_confecti5, spr_tvHUD_janitorLap, spr_tvHUD_janitorTreasure,
			global.TvSprPlayer_KeyGot, global.TvSprPlayer_Happy
		];
		if (chance(50) && array_contains(vocal_collectables, _exp_spr))
			fmod_studio_event_instance_start(get_primaryPlayer().voiceCollect);
	}
}

function scr_queueToolTipPrompt(_toolTipPrompt = "", _toolTipPromptTimer = 220)
{
	with obj_hudManager
	{
		global.TooltipPrompt = _toolTipPrompt;
		HUDObject_tooltipPrompts.promptTimer = _toolTipPromptTimer;
	}
	return _toolTipPromptTimer;
}
