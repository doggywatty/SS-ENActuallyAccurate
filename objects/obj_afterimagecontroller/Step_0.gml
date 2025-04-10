for (var i = 0; i < ds_list_size(global.afterimage_list); i++)
{
	var b = ds_list_find_value(global.afterimage_list, i);
	with b
	{
		for (var l = 0; l < array_length(alarm); l++)
		{
			if (alarm[l] >= 0 && !global.freezeframe)
				alarm[l]--;
		}
		if blink
			visible = global.BlinkTrail;
		if (instance_exists(identity) && object_is_ancestor(identity.object_index, obj_parent_player))
		{
			if (identity.state == States.mach2 || (identity.state == States.mach3 && mach3Afterimage))
				image_alpha = identity.movespeed / 12;
			else
				image_alpha = 1;
			if (identity.isInSecretPortal || identity.isInLapPortal)
				image_alpha = 0;
		}
		if (instance_exists(identity) && (object_get_parent(identity.object_index) == obj_parent_player
		|| identity.object_index == obj_parent_player) && mach3Afterimage && identity.state != States.mach3
		&& !(identity.state == States.run && identity.movespeed >= 12) && identity.state != States.charge
		&& identity.state != States.mach2 && identity.state != States.grabdash && identity.state != States.machslide
		&& identity.state != States.superslam && !(identity.state == States.machroll && identity.mach3Roll > 0)
		&& identity.state != States.Sjump && identity.state != States.parry && identity.state != States.tumble
		&& identity.state != 125 && identity.state != States.jump && identity.state != States.uppercut
		&& identity.state != States.machtumble2 && identity.state != States.mach1 && identity.state != States.frostburnjump
		&& identity.state != States.tumble && identity.state != States.Sjump && identity.state != States.wallkick)
			vanish = true;
		if !mach3Afterimage && !fakeMach3Afterimage
			vanish = true;
		if vanish
			gonealpha = approach(gonealpha, 0, vanishSpd);
		
		x += hsp;
		y += vsp;
		
		if (alarm[0] == 0 || !instance_exists(identity))
			vanish = true;
		
		if (alarm[1] == 0 || gonealpha == 0)
		{
			delete b;
			ds_list_delete(global.afterimage_list, i);
			i--;
		}
	}
}

if !global.freezeframe
{
	if blinkingBuffer > 0
		blinkingBuffer--;
	else
	{
		event_user(0);
		blinkingBuffer = 3;
	}
}
