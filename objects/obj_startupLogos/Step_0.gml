scr_getinput_menu();

if ((logoChangeBuffer-- < 0 || key_jump || key_start2) && logoIndex < array_length(logoArray))
{
	logoChangeBuffer = logoChangeBufferMax;
	logoIndex++;
	instance_destroy(obj_fadeoutTransition);
}

if (!completed && logoIndex > (array_length(logoArray) - 1))
{
	completed = true;
	event_user(0);
}

if ((key_jump || key_start2) && logoIndex >= array_length(logoArray))
	obj_fadeoutTransition.fadealpha = max(obj_fadeoutTransition.fadealpha, 1.1);
