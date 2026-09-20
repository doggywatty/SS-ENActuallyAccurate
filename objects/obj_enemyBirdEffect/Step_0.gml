if (!instance_exists(baddieID))
{
	instance_destroy();
	exit;
}

updateBirdPosition();

if (!global.freezeframe && (baddieID.baddieStunTimer < 50 || baddieID.state != PlayerState.charge))
{
	baddieID.birdCreated = false;
	instance_destroy();
}
