optionBG[(0 << 0)] = 0;
optionBG[(1 << 0)] = 1;
optionBG[(2 << 0)] = 2;
optionBG[(3 << 0)] = 2;
optionBG[(4 << 0)] = 3;
optionBG[(5 << 0)] = 5;
optionBG[(6 << 0)] = 4;
optionBG[(7 << 0)] = 4;
optionBG[(8 << 0)] = 4;
optionBG[(9 << 0)] = 4;

handle_savedoption = function()
{
	if (!is_struct(savedSliderOption))
		exit;
	
	if (activeSFX != -4)
		kill_sounds([activeSFX]);
	
	activeSFX = -4;
	savedSliderOption.moving = false;
	
	if (!is_undefined(savedSliderOption.on_stop))
		savedSliderOption.on_stop(savedSliderOption.value);
	
	savedSliderOption = -4;
	trace("Stopped");
};

options = [];
optionSelected = 0;
alignCenter = true;
scr_input_varinit();
bg_alpha = [1, 0, 0, 0, 0, 0, 0];
inputBuffer = 1;
activeSFX = -4;
optionMenu = (0 << 0);
backMenu = -4;
backOption = 0;
scrollbuffer = 0;
savedSliderOption = -4;
sliderSprite = spr_optionslide_bar;
sliderIcon = spr_optionslide_end;
bgx = 0;
bgy = 0;
depth = -99;
old_desc = "";
descfadeout = false;
description = "";
showdesc = false;
descalp = 0;
savedDesc = -4;
changedAnyOption = false;
event_user(0);
