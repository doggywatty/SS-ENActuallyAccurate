function scr_setTransfoTip(_transfo_state)
{
	switch _transfo_state
	{
		case States.cotton:
		case States.cottondrill:
		case States.cottonroll:
		case States.cottondig:
			global.TransfoPrompt = "prompt_werecotton";
			break;
		case States.minecart:
		case States.minecart_bump:
		case States.minecart_launched:
			global.TransfoPrompt = "prompt_minecart";
			break;
		case States.fling:
			global.TransfoPrompt = "prompt_fling";
			break;
		case States.fireass:
		case States.fireassdash:
			global.TransfoPrompt = "prompt_fireass";
			break;
		default:
			global.TransfoPrompt = "";
			break;
	}
	global.TransfoState = _transfo_state;
	return global.TransfoPrompt;
}

function scr_transformationCheck(_transfo_state)
{
	var transfo = undefined;
	if _transfo_state == States.oldtaunt
		_transfo_state = tauntStored.state;
	switch _transfo_state
	{
		default:
			transfo = undefined;
			break;
		case States.tumble:
			transfo = "Ball";
			break;
		case States.cotton:
		case States.cottondrill:
		case States.cottonroll:
		case States.cottondig:
			transfo = "Werecotton";
			break;
		case States.fling:
		case States.fling_launch:
			transfo = "Fling";
			break;
		case States.minecart:
		case States.minecart_bump:
		case States.minecart_launched:
			transfo = "Minecart";
			break;
		case States.frostburnnormal:
		case States.frostburnjump:
		case States.frostburnslide:
		case States.frostburnstick:
			transfo = "Frostburn";
			break;
		case States.doughmount:
		case States.doughmountspin:
		case States.doughmountjump:
		case States.doughmountballoon:
			transfo = "Marshdog";
			break;
		case States.bottlerocket:
			transfo = "Rocket";
			break;
	}
	return transfo;
}
