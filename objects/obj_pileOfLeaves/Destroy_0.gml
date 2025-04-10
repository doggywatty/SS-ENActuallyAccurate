event_inherited();

repeat (10 + irandom_range(0, 2))
{
	var _deb = create_debris(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), spr_leafDebris);
	with _deb
	{
		vsp = random_range(3, -10);
		terminalVelocity = 7;
	}
}
