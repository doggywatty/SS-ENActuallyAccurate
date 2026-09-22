function scr_player_check_normal(_state)
{
	var normalStates = [PlayerState.normal, PlayerState.jump, PlayerState.mach1, PlayerState.mach2, PlayerState.mach3, PlayerState.machslide, PlayerState.wallkick, PlayerState.grabdash, PlayerState.crouch, PlayerState.crouchjump];
	return array_contains(normalStates, _state.state);
}
