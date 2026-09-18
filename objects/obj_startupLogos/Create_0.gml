depth = 3;
logoArray = [spr_FMOD_logo, spr_biggnomestudios_logo];
logoIndex = 0;
logoChangeBufferMax = 100;
logoChangeBuffer = logoChangeBufferMax;
completed = false;
playedGnome = false;
var p_i = 0;
var p_c = parameter_count();

while (p_i <= p_c)
{
	var p_s = string_lower(parameter_string(p_i));
	
	switch (p_s)
	{
		case "-nointro":
		case "--nointro":
		case "-nosplash":
		case "--nosplash":
			room_goto_fixed(rm_mainmenu);
			break;
	}
	
	p_i++;
}
