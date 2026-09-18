function scr_setTransfoTip(arg0)
{
	switch (arg0)
	{
		case states.bossintro:
		case (56 << 0):
		case (57 << 0):
		case (58 << 0):
			global.TransfoPrompt = "prompt_werecotton";
			break;
		case (61 << 0):
		case (63 << 0):
		case (62 << 0):
			global.TransfoPrompt = "prompt_minecart";
			break;
		case (59 << 0):
			global.TransfoPrompt = "prompt_fling";
			break;
		case (67 << 0):
		case (68 << 0):
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
	
	if (arg0 == (74 << 0))
		arg0 = tauntStored.state;
	
	switch (arg0)
	{
		default:
			transfo = undefined;
			break;
		case (54 << 0):
			transfo = "Ball";
			break;
		case states.bossintro:
		case (56 << 0):
		case (57 << 0):
		case (58 << 0):
			transfo = "Werecotton";
			break;
		case (59 << 0):
		case (93 << 0):
			transfo = "Fling";
			break;
		case (61 << 0):
		case (63 << 0):
		case (62 << 0):
			transfo = "Minecart";
			break;
		case (88 << 0):
		case (90 << 0):
		case (89 << 0):
		case (91 << 0):
			transfo = "Frostburn";
			break;
		case (41 << 0):
		case (42 << 0):
		case (43 << 0):
		case (44 << 0):
			transfo = "Marshdog";
			break;
		case (81 << 0):
			transfo = "Rocket";
			break;
	}
	
	return transfo;
}
