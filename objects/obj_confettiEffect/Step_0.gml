if (vsp > 5)
	image_alpha -= 0.01;

if (image_alpha <= 0)
	instance_destroy();

var _grav = 0.5;
x += hsp;
y += vsp;

if (vsp > 0)
	_grav = 0.1;

if (vsp < 20)
	vsp += _grav;
