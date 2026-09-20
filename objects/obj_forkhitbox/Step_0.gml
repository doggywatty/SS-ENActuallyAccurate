var target_player = instance_nearest(x, y, obj_parent_player);

if (!instance_exists(ID) || (target_player.state == PlayerState.mach3 || target_player.state == PlayerState.fireassdash || target_player.state == PlayerState.minecart || target_player.state == PlayerState.doughmountspin))
	instance_destroy();

if (instance_exists(ID))
{
	x = ID.x;
	y = ID.y;
	image_xscale = ID.image_xscale;
	image_index = ID.image_index;
	
	with (ID)
	{
		switch (object_index)
		{
			case obj_knight:
				if (state != PlayerState.frozen && state != PlayerState.frozen)
				{
					hitboxcreate = 0;
					instance_destroy(other.id);
				}
				
				break;
			case obj_boxFrog:
				if ((vsp >= 0 && grounded) || state != PlayerState.titlescreen)
				{
					hitboxcreate = false;
					instance_destroy(other.id);
				}
				
				break;
			case obj_miniHarry:
				if (state != PlayerState.titlescreen)
				{
					hitboxcreate = 0;
					instance_destroy(other.id);
				}
				
				break;
			case obj_sluggy:
				if (vsp >= 0 || state != PlayerState.titlescreen)
				{
					hitboxcreate = 0;
					instance_destroy(other.id);
				}
				
				break;
			case obj_bananaCharger:
			case obj_swedishfish:
				if (state != PlayerState.charge)
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
				if (state != PlayerState.titlescreen && state != PlayerState.frozen)
					instance_destroy(other.id);
				
				break;
		}
	}
}
