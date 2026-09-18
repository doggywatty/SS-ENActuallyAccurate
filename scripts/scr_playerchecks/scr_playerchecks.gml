function scr_player_check_normal(arg0)
{
	var normalStates = [(1 << 0), (24 << 0), (31 << 0), (32 << 0), (33 << 0), (34 << 0), (7 << 0), (10 << 0), (29 << 0), (30 << 0)];
	return array_contains(normalStates, arg0.state);
}
