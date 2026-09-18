instance_destroy(obj_fadeoutTransition);

with (instance_create(x, y, obj_fadeoutTransition, 
{
	levelStart: true,
	goToHub: true
}))
	fadealpha = 0.5;
