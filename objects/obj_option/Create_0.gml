optionBG[OptionMenu.Base] = 0;
optionBG[OptionMenu.Audio] = 1;
optionBG[OptionMenu.Video] = 2;
optionBG[OptionMenu.Window] = 2;
optionBG[OptionMenu.Game] = 3;
optionBG[OptionMenu.Language] = 5;
optionBG[OptionMenu.Controls] = 4;
optionBG[OptionMenu.Keyboard] = 4;
optionBG[OptionMenu.Gamepad] = 4;
optionBG[OptionMenu.Deadzones] = 4;

handle_savedoption = function()
{
	if !is_struct(savedSliderOption)
		exit;
	if activeSFX != -4
		kill_sounds([activeSFX]);
	activeSFX = -4;
	savedSliderOption.moving = false;
	if !is_undefined(savedSliderOption.on_stop)
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
optionMenu = OptionMenu.Base;
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
