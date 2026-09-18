function scr_queueTVAnimation(arg0, arg1 = 150)
{
	with (obj_hudManager.HUDObject_TV)
	{
		var roomname = room_get_name(room);
		
		if (arg0 == global.TvSprPlayer_Secret && instance_exists(obj_secretfound))
			exit;
		
		if (tvExpressionSprite != arg0)
			tvForceTransition = true;
		
		tvExpressionSprite = arg0;
		tvExpressionBuffer = arg1;
		var vocal_collectables = [spr_tvHUD_confecti1, spr_tvHUD_confecti2, spr_tvHUD_confecti3, spr_tvHUD_confecti4, spr_tvHUD_confecti5, spr_tvHUD_janitorLap, spr_tvHUD_janitorTreasure, global.TvSprPlayer_KeyGot, global.TvSprPlayer_Happy];
		
		if (chance(50) && array_contains(vocal_collectables, arg0))
			fmod_studio_event_instance_start(get_primaryPlayer().voiceCollect);
	}
}

function scr_queueToolTipPrompt(arg0 = "", arg1 = 220)
{
	with (obj_hudManager)
	{
		global.TooltipPrompt = arg0;
		HUDObject_tooltipPrompts.promptTimer = arg1;
	}
	
	return arg1;
}
