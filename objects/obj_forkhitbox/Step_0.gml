var target_player = instance_nearest(x, y, obj_parent_player);
if (!instance_exists(ID) || (target_player.state == States.mach3
|| target_player.state == States.fireassdash || target_player.state == States.minecart
|| target_player.state == States.doughmountspin))
	instance_destroy();
if instance_exists(ID)
{
	x = ID.x;
	y = ID.y;
	image_xscale = ID.image_xscale;
	image_index = ID.image_index;
	with ID
	{
		switch object_index
		{
			case obj_knight:
				if (state != States.frozen && state != States.frozen)
				{
					hitboxcreate = 0;
					instance_destroy(other.id);
				}
				break;
			case obj_boxFrog:
				if ((vsp >= 0 && grounded) || state != States.titlescreen)
				{
					hitboxcreate = false;
					instance_destroy(other.id);
				}
				break;
			case obj_miniHarry:
				if (state != States.titlescreen)
				{
					hitboxcreate = 0;
					instance_destroy(other.id);
				}
				break;
			case obj_sluggy:
				if (vsp >= 0 || state != States.titlescreen)
				{
					hitboxcreate = 0;
					instance_destroy(other.id);
				}
				break;
			case obj_bananaCharger:
			case obj_swedishfish:
				if (state != States.charge)
				{
					hitboxcreate = 0;
					instance_destroy(other.id);
				}
				break;
			case obj_doggy:
				if (sprite_index != spr_badmarsh_rage)
					instance_destroy(other.id);
				break;
				break;
			case obj_betonbacon:
				if (state != States.titlescreen && state != States.frozen)
					instance_destroy(other.id);
				break;
		}
	}
}
