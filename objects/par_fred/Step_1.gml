var dis = -4;
var _id = -4;
with obj_parent_player
{
	if ((dis < distance_to_object(other) || dis == -4) && ((other.object_index == obj_fredbounce && y < (other.y + other.sprite_height)) || (other.object_index == obj_fredturn && other.image_xscale == xscale) || other.object_index == obj_fredpissed))
	{
		dis = distance_to_object(other);
		_id = other.id;
	}
}

playerTarget = _id == id;
