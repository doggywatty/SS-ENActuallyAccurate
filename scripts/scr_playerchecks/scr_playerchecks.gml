function scr_player_check_normal(arg0)
{
	var normalStates = [PlayerState.normal, PlayerState.jump, PlayerState.mach1, PlayerState.mach2, PlayerState.mach3, PlayerState.machslide, PlayerState.wallkick, PlayerState.grabdash, PlayerState.crouch, PlayerState.crouchjump];
	return array_contains(normalStates, arg0.state);
}
