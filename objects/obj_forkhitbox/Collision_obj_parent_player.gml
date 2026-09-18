if (!instance_exists(ID) || (other.state == states.shotgun || other.state == states.crouchjump || other.state == states.victory))
	exit;

var impaling_creatures = [obj_knight, obj_bananaCharger, obj_sluggy];
var hurt_player = scr_hurtplayer(other.id);

if (hurt_player)
	create_particle(round((x + other.x) / 2), round((y + other.y) / 2), spr_parryeffect);
