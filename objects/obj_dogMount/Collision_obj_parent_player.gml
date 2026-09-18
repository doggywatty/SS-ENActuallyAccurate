other.movespeed = sign(other.xscale) * abs(other.movespeed);
other.state = states.punch;

if (!instance_exists(global.CafeDrawer))
	global.CafeDrawer = instance_create(x, y, obj_cafedrawer);

instance_destroy();
