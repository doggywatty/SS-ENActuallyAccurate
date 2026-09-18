if (!instance_exists(baddieID))
{
	instance_destroy();
	exit;
}

updateBirdPosition();

if (!global.freezeframe && (baddieID.baddieStunTimer < 50 || baddieID.state != states.slap))
{
	baddieID.birdCreated = false;
	instance_destroy();
}
