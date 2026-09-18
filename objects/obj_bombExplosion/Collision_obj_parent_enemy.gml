if (image_index > 9 || !hurtBaddies)
	exit;

if (hurtOwner && ownerID == other.id)
	exit;

instance_destroy(other.id);
