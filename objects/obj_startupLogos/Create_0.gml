depth = 3;
logoArray = [spr_FMOD_logo, spr_biggnomestudios_logo];
logoIndex = 0;
logoChangeBufferMax = 100;
logoChangeBuffer = logoChangeBufferMax;
completed = false;
playedGnome = false;
for (var p_i = 0, p_c = parameter_count(); p_i <= p_c; p_i++)
{
	var p_s = string_lower(parameter_string(p_i));
	switch p_s
	{
		case "-nointro":
		case "--nointro":
		case "-nosplash":
		case "--nosplash":
			room_goto_fixed(rm_mainmenu);
			break;
	}
}