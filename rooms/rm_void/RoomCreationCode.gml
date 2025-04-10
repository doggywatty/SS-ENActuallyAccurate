with obj_hudManager
{
	var _string = "[spr_promptfont]What now?";
	var time = scr_queueToolTipPrompt(_string, -4, 99999999999999);
	showtext = 1;
	scr_queueTVAnimation(global.TvSprPlayer_HighCombo, time);
}
