if (other.state == PlayerState.grabdash)
{
	other.vsp = -2;
	other.hsp = -6 * other.xscale;
	other.state = PlayerState.bump;
	instance_destroy();
}
