visible = !global.tempRocketLauncher;

if (global.tempRocketLauncher)
	image_alpha = -2;
else
	image_alpha = approach(image_alpha, 1, 0.1);
