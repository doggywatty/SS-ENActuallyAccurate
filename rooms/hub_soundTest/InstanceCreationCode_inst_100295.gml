sprite_index = spr_cassettetape;
image_alpha = 0;
parameters = 
{
	time: 0,
	ybob: 0
};

onStep = function()
{
	parameters.time++;
	parameters.ybob = sin(parameters.time / 7) * 4;
	y = ystart + parameters.ybob;
	var show = false;
	
	with (obj_soundTest)
		show = musicArray[currentSelection].eventPath == "event:/music/Soundtest/painterMixtape";
	
	image_alpha = approach(image_alpha, show ? 1 : 0, 0.05);
};
