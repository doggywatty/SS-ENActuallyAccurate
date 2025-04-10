global.gamePauseState = 0;
pausecount = -1;

if (surface_exists(pauseSurface))
	surface_free(pauseSurface);
if (sprite_exists(pausedSprite))
	sprite_delete(pausedSprite);

scr_unpause_instances(true);
fmod_studio_event_instance_stop(pauseMusic, false);
fmod_studio_event_instance_set_paused(pauseMusic, true);

var inputSilenceArr = ["jump", "slap"];
for (var i = 0; i < array_length(inputSilenceArr); i++)
{
	var in = inputSilenceArr[i];
	input_get(in).clear_input();
	input_get(string(in) + "C").clear_input();
}

with obj_parent_player
{
	key_jump = false;
	key_jump2 = false;
	inputBufferJump = 0;
}
