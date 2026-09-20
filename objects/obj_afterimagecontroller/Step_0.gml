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
			if (identity.state == PlayerState.mach2 || (identity.state == PlayerState.mach3 && mach3Afterimage))
				image_alpha = identity.movespeed / 12;
			else
				image_alpha = 1;
			
			if (identity.isInSecretPortal || identity.isInLapPortal)
				image_alpha = 0;
		}
		
		if (instance_exists(identity) && (object_get_parent(identity.object_index) == obj_parent_player || identity.object_index == obj_parent_player) && mach3Afterimage && identity.state != PlayerState.mach3 && !(identity.state == PlayerState.run && identity.movespeed >= 12) && identity.state != PlayerState.charge && identity.state != PlayerState.mach2 && identity.state != PlayerState.grabdash && identity.state != PlayerState.machslide && identity.state != PlayerState.superslam && !(identity.state == PlayerState.machroll && identity.mach3Roll > 0) && identity.state != PlayerState.Sjump && identity.state != PlayerState.parry && identity.state != PlayerState.tumble && identity.state != 125 && identity.state != PlayerState.jump && identity.state != PlayerState.uppercut && identity.state != PlayerState.machtumble2 && identity.state != PlayerState.mach1 && identity.state != PlayerState.frostburnjump && identity.state != PlayerState.tumble && identity.state != PlayerState.Sjump && identity.state != PlayerState.wallkick)
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
