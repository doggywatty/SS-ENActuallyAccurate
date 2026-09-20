if (state == PlayerState.normal)
{
	x = obj_player1.x;
	y = obj_player1.y;
	rubberbandMovespeed = 0;
	movespeed = 0;
	hsp = 0;
	state = PlayerState.stun;
	sprite_index = spr_creamthief_startRace;
	image_index = 0;
	image_xscale = obj_player1.xscale;
	create_particle(x, y, spr_poofeffect);
}
