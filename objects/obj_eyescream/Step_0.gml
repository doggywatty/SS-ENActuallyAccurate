doCollision = !(state == EnemyStates.eyescream || state == EnemyStates.eyescreamwait || scr_solid(x, y) || state == States.titlescreen);
trace(doCollision);
baddieCollisionBoxEnabled = state != EnemyStates.eyescreampopout;
if (state == States.frozen)
	state = EnemyStates.eyescream;
if (state == EnemyStates.eyescreampopout)
{
	var p = get_nearestPlayer();
	var _disttoplayer = point_distance(x, y, p.x, p.y);
	hsp = 0;
	vsp = 0;
	image_speed = 0.35;
	
	if (sprite_index != spr_eyescreamsandwich_popout)
	{
		if (abs(_disttoplayer) < 200)
		{
			sprite_index = spr_eyescreamsandwich_popout;
			image_index = 0;
		}
	}
	else if sprite_animation_end()
	{
		state = EnemyStates.eyescream;
		var dir = point_direction(x, y, p.x, p.y);
		var _spd = 5;
		hsp = lengthdir_x(_spd, dir);
		vsp = lengthdir_y(_spd, dir);
		ragereset = 100;
	}
}

if doCollision
	scr_scareenemy();
if (ragereset > 0)
	ragereset--;
event_inherited();
if (state != States.stun)
	depth = 0;
if (state != States.charge && state != States.freezeframe)
	thrown = 0;
