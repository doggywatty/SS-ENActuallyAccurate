if (image_index > 9 || !hurtPlayers)
	exit;

if (hurtOwner && ownerID == other.id)
	exit;

scr_hurtplayer(other);
