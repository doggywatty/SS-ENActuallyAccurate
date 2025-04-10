function scr_player_check_normal(player)
{
	var normalStates = [
		States.normal, States.jump, States.mach1, States.mach2, States.mach3, States.machslide,
		States.wallkick, States.grabdash, States.crouch, States.crouchjump
	];
	return array_contains(normalStates, player.state);
}
