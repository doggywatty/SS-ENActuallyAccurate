function scr_setTransfoTip(arg0)
{
	switch (arg0)
	{
		case states.bossintro:
		case states.keyget:
		case states.tackle:
		case states.slipnslide:
			global.TransfoPrompt = "prompt_werecotton";
			break;
		case states.victory:
		case states.Sjump:
		case states.comingoutdoor:
			global.TransfoPrompt = "prompt_minecart";
			break;
		case states.ladder:
			global.TransfoPrompt = "prompt_fling";
			break;
		case states.crouchslide:
		case states.mach1:
			global.TransfoPrompt = "prompt_fireass";
			break;
		default:
			global.TransfoPrompt = "";
			break;
	}
	
	global.TransfoState = arg0;
	return global.TransfoPrompt;
}

function scr_transformationCheck(arg0)
{
	var transfo = undefined;
	
	if (arg0 == states.freefall)
		arg0 = tauntStored.state;
	
	switch (arg0)
	{
		default:
			transfo = undefined;
			break;
		case states.runonball:
			transfo = "Ball";
			break;
		case states.bossintro:
		case states.keyget:
		case states.tackle:
		case states.slipnslide:
			transfo = "Werecotton";
			break;
		case states.ladder:
		case states.parry:
			transfo = "Fling";
			break;
		case states.victory:
		case states.Sjump:
		case states.comingoutdoor:
			transfo = "Minecart";
			break;
		case states.cotton:
		case states.pal:
		case states.uppercut:
		case states.shocked:
			transfo = "Frostburn";
			break;
		case states.punch:
		case states.backkick:
		case states.uppunch:
		case states.shoulder:
			transfo = "Marshdog";
			break;
		case states.barrelmach2:
			transfo = "Rocket";
			break;
	}
	
	return transfo;
}
