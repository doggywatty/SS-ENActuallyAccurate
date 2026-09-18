function scr_getDialogIcon(arg0, arg1 = "c_white", arg2 = "c_black")
{
	arg0 = string_upper(arg0);
	var spr = "spr_null";
	var ind = "0";
	
	switch (arg0)
	{
		case "HARRY":
			spr = "spr_icon_dialog";
			ind = "1";
			break;
		case "PIZZELLE":
			spr = "spr_icon_dialog";
			ind = "0";
			break;
		case "LAPLAD":
		case "LAP LAD":
		case "POLKA":
			spr = "spr_icon_dialog";
			ind = "2";
			break;
		case "INK":
			spr = "spr_icon_dialog";
			ind = "3";
			break;
		case "RUDY":
			spr = "spr_icon_dialog";
			ind = "4";
			break;
		case "SLUGGY":
			spr = "spr_icon_dialog";
			ind = "5";
			break;
		case "COTTONWITCH":
			spr = "spr_icon_dialog";
			ind = "6";
			break;
		case "GUARDIAN":
			spr = "spr_icon_dialog";
			ind = "7";
			break;
		case "FLINGFROG":
			spr = "spr_icon_dialog";
			ind = "8";
			break;
	}
	
	return $"[{arg1}][{spr}, {ind}][{arg2}]";
}
