function scr_player_check_normal(arg0)
{
	var normalStates = [states.normal, states.chainsawpogo, states.machroll, states.pistol, states.shotgun, states.machfreefall, states.cheeseball, states.pistalaim, states.facestomp, states.timesup];
	return array_contains(normalStates, arg0.state);
}
