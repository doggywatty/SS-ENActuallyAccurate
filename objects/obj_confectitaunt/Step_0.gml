if (!instance_exists(o_id))
{
	instance_destroy();
	exit;
}

x = o_id.x;
y = o_id.y;

if (o_id.state != PlayerState.normal)
	instance_destroy();

depth = o_id.depth + 1;
