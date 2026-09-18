if (other.state == states.pistalaim)
{
	other.vsp = -2;
	other.hsp = -6 * other.xscale;
	other.state = states.throwing;
	instance_destroy();
}
