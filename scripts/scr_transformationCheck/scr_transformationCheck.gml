function scr_setTransfoTip(_state)
{
	switch (_state)
	{
		case PlayerState.cotton:
		case PlayerState.cottondrill:
		case PlayerState.cottonroll:
		case PlayerState.cottondig:
			global.TransfoPrompt = "prompt_werecotton";
			break;
		case PlayerState.minecart:
		case PlayerState.minecart_bump:
		case PlayerState.minecart_launched:
			global.TransfoPrompt = "prompt_minecart";
			break;
		case PlayerState.fling:
			global.TransfoPrompt = "prompt_fling";
			break;
		case PlayerState.fireass:
		case PlayerState.fireassdash:
			global.TransfoPrompt = "prompt_fireass";
			break;
		default:
			global.TransfoPrompt = "";
			break;
	}
	
	global.TransfoState = _state;
	return global.TransfoPrompt;
}

function scr_transformationCheck(_state)
{
	var transfo = undefined;
	
	if (_state == PlayerState.oldtaunt)
		_state = tauntStored.state;
	
	switch (_state)
	{
		default:
			transfo = undefined;
			break;
		case PlayerState.tumble:
			transfo = "Ball";
			break;
		case PlayerState.cotton:
		case PlayerState.cottondrill:
		case PlayerState.cottonroll:
		case PlayerState.cottondig:
			transfo = "Werecotton";
			break;
		case PlayerState.fling:
		case PlayerState.fling_launch:
			transfo = "Fling";
			break;
		case PlayerState.minecart:
		case PlayerState.minecart_bump:
		case PlayerState.minecart_launched:
			transfo = "Minecart";
			break;
		case PlayerState.frostburnnormal:
		case PlayerState.frostburnjump:
		case PlayerState.frostburnslide:
		case PlayerState.frostburnstick:
			transfo = "Frostburn";
			break;
		case PlayerState.doughmount:
		case PlayerState.doughmountspin:
		case PlayerState.doughmountjump:
		case PlayerState.doughmountballoon:
			transfo = "Marshdog";
			break;
		case PlayerState.bottlerocket:
			transfo = "Rocket";
			break;
	}
	
	return transfo;
}
