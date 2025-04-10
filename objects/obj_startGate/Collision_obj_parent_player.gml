if instance_exists(obj_titlecard)
	exit;

var enter_gate = false;
with obj_parent_player
{
	var other_id = other.id;
	if (key_up && grounded && (state == States.normal || state == States.mach1 || state == States.mach2
	|| state == States.mach3) && !instance_exists(obj_fadeoutTransition) && state != States.victory
	&& state != States.comingoutdoor)
		enter_gate = true;
}

if enter_gate
{
	hasInteracted = true;
	stop_music(false);
	gotoLevel(level);
}

if !secretcanspit && array_contains(secrets, true) && level != "tutorial"
{
	secretcanspit = true;
	repeat 5
		instance_create(x, y - 128, obj_secretpoof);
}
