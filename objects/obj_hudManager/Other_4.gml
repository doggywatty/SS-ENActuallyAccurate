with HUDObject_TV
{
	tvBG = spr_tvHUD_bg;
	switch global.InternalLevelName
	{
		case "entryway":
			tvBG_index = 0;
			break;
		case "steamy":
			tvBG_index = 1;
			break;
		case "mineshaft":
			tvBG_index = 2;
			break;
		case "fudge":
			tvBG_index = 3;
			break;
		case "molasses":
			tvBG_index = 4;
			break;
		case "cafe":
			tvBG_index = 5;
			break;
		case "sucrose":
			tvBG_index = 11;
			break;
		default:
			tvBG_index = 12;
			break;
	}
	if instance_exists(obj_secretfound)
	{
		tvBG = spr_tvHUD_bg_secret;
		tvBG_index = 0;
	}
}
