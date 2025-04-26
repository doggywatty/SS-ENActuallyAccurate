var _state = global.freezeframe ? frozenState : state;
if !global.freezeframe
	yscale = 1;
if _state == States.stun
	scr_enemy_grabUpdatePosition(obj_player1);