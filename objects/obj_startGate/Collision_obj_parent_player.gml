if (instance_exists(obj_titlecard))
	exit;

var enter_gate = false;

with (obj_parent_player)
{
	var other_id = other.id;
	
	if (key_up && grounded && (state == states.normal || state == states.machroll || state == states.pistol || state == states.shotgun) && !instance_exists(obj_fadeoutTransition) && state != states.shotgunjump && state != states.stunned)
		enter_gate = true;
}

if (enter_gate)
{
	hasInteracted = true;
	stop_music(false);
	self.gotoLevel(level);
}

if (!secretcanspit && array_contains(secrets, true) && level != "tutorial")
{
	secretcanspit = true;
	
	repeat (5)
		create_radiating_particle(x, y - 128, spr_secretpoof);
}
