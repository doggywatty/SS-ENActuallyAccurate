if (!instance_exists(ID) || (other.state == States.mach3 || other.state == States.dodgetumble
|| other.state == States.minecart))
	exit;

var impaling_creatures = [obj_knight, obj_bananaCharger, obj_sluggy];
var hurt_player = scr_hurtplayer(other.id);
if hurt_player
	create_particle(round((x + other.x) / 2), round((y + other.y) / 2), spr_parryeffect);
