event_inherited();

if (state == PlayerState.frozen && !instance_exists(hurtboxID))
{
	with (instance_create(x, y, obj_forkhitbox, 
	{
		ID: other.id
	}))
	{
		other.hurtboxID = id;
		ID = other.id;
		sprite_index = spr_swordhitbox;
		mask_index = sprite_index;
		image_xscale = other.image_xscale;
		image_index = other.image_index;
	}
}
