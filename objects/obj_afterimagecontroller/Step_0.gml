for (var i = 0; i < ds_list_size(global.afterimage_list); i++)
{
	var b = ds_list_find_value(global.afterimage_list, i);
	
	with (b)
	{
		for (var l = 0; l < array_length(alarm); l++)
		{
			if (alarm[l] >= 0 && !global.freezeframe)
				alarm[l]--;
		}
		
		if (blink)
			visible = global.BlinkTrail;
		
		if (instance_exists(identity) && object_is_ancestor(identity.object_index, obj_parent_player))
		{
			if (identity.state == states.pistol || (identity.state == states.shotgun && mach3Afterimage))
				image_alpha = identity.movespeed / 12;
			else
				image_alpha = 1;
			
			if (identity.isInSecretPortal || identity.isInLapPortal)
				image_alpha = 0;
		}
		
		if (instance_exists(identity) && (object_get_parent(identity.object_index) == obj_parent_player || identity.object_index == obj_parent_player) && mach3Afterimage && identity.state != states.shotgun && !(identity.state == states.Nhookshot && identity.movespeed >= 12) && identity.state != states.slap && identity.state != states.pistol && identity.state != states.pistalaim && identity.state != states.machfreefall && identity.state != states.secondjump && !(identity.state == states.climbdownwall && identity.mach3Roll > 0) && identity.state != states.highjump && identity.state != states.gameover && identity.state != states.runonball && identity.state != 125 && identity.state != states.chainsawpogo && identity.state != states.ufofloat && identity.state != states.crouch && identity.state != states.machroll && identity.state != states.pal && identity.state != states.runonball && identity.state != states.highjump && identity.state != states.cheeseball)
			vanish = true;
		
		if (!mach3Afterimage && !fakeMach3Afterimage)
			vanish = true;
		
		if (vanish)
			gonealpha = approach(gonealpha, 0, vanishSpd);
		
		x += hsp;
		y += vsp;
		
		if (alarm[0] == 0 || !instance_exists(identity))
			vanish = true;
		
		if (alarm[1] == 0 || gonealpha == 0)
		{
			b = undefined;
			ds_list_delete(global.afterimage_list, i);
			i--;
		}
	}
}

if (!global.freezeframe)
{
	if (blinkingBuffer > 0)
	{
		blinkingBuffer--;
	}
	else
	{
		event_user(0);
		blinkingBuffer = 3;
	}
}
