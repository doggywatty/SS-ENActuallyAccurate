if (state != states.charge)
	depth = 0;

if (state != states.slap && state != states.boxxedpep)
	thrown = 0;

if (state == states.slap)
	hitboxcreate = 0;

if (x != obj_parent_player.x)
{
	movespeed = 3;
	image_xscale = sign(obj_parent_player.x - x);
}
