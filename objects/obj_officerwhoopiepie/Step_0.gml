if (state != PlayerState.stun)
	depth = 0;

if (state != PlayerState.charge && state != PlayerState.freezeframe)
	thrown = 0;

if (state == PlayerState.charge)
	hitboxcreate = 0;

if (x != obj_parent_player.x)
{
	movespeed = 3;
	image_xscale = sign(obj_parent_player.x - x);
}
