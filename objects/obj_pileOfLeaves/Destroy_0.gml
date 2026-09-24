event_inherited();

repeat (10 + irandom_range(0, 2))
{
	var _deb = create_debris(bbox_xrange, bbox_yrange, spr_leafDebris);
	
	with (_deb)
	{
		vsp = random_range(3, -10);
		terminalVelocity = 7;
	}
}
