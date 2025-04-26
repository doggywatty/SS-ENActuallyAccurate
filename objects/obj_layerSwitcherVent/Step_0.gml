if !place_meeting(x, y - 1, obj_parent_player)
	exit;
with obj_parent_player
{
	if (place_meeting(x, y + 1, other.id))
	{
		jumpStop = true;
		state = States.wallkick;
		fmod_studio_event_instance_start(sndWallkickStart);
		vsp = -12;
		sprite_index = spr_wallJumpIntro;
		movespeed = 4 * xscale;
		hsp = movespeed;
		dir = xscale;
		with (instance_create(x, y, obj_jumpdust))
			image_xscale = other.xscale;
		inBackgroundLayer = !inBackgroundLayer;
		var x_offset = inBackgroundLayer ? (-camera_get_view_x(view_camera[0]) * 0.05) : (camera_get_view_x(view_camera[0]) * 0.05);
		var y_offset = inBackgroundLayer ? -global.BgInstanceLayerOffset : global.BgInstanceLayerOffset;
		x += x_offset;
		y += y_offset;
		xprevious += x_offset;
		yprevious += y_offset;
	}
}
