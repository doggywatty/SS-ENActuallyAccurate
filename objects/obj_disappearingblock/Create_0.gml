event_inherited();
canCollide = function(_obj, player = obj_parent_player)
{
	var in_object = false;
	with player
		in_object = place_meeting(xprevious, yprevious, _obj);
	return !_obj.destroyed && !in_object;
};
dissolveBufferMax = 100;
dissolveBuffer = dissolveBufferMax;
image_speed = 0.35;
depth = 4;
destroyed = false;
mask_index = spr_caramel_idle;
sprite_index = spr_caramel_idle;
