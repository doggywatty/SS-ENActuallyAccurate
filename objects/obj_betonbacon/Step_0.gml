movespeed = 2.5;

if (point_in_circle(x, y, obj_parent_player.x + (75 * obj_parent_player.xscale), obj_parent_player.y, 125) && obj_parent_player.inhaling && state != enemystates.inhale)
	state = enemystates.inhale;

if (state != states.charge)
	depth = 0;

if (state != enemystates.thrown && state != states.boxxedpep)
	thrown = 0;

ragereset = max(ragereset - 1, 0);

if (point_in_rectangle(obj_parent_player.x, obj_parent_player.y, x - 200, y - 50, x + 200, y + 50) && obj_parent_player.state != (40 << 0) && obj_parent_player.state != (26 << 0))
{
	if (state != enemystates.attack && state == enemystates.normal && ragereset <= 0)
	{
		state = enemystates.attack;
		sprite_index = baddieSpriteRage;
		
		if (x != obj_parent_player.x)
			image_xscale = sign(obj_parent_player.x - x);
		
		ragereset = 200;
		image_index = 0;
		image_speed = 0.35;
		flash = true;
		alarm[4] = 5;
		create_heat_afterimage(afterimagetypes.basic);
	}
}

if (hitboxcreate == 0 && animation_end_old(undefined, 10) && state == enemystates.attack)
{
	hitboxcreate = 1;
	
	with (instance_create(x, y, obj_forkhitbox, 
	{
		ID: other.id
	}))
	{
		ID = other.id;
		image_xscale = other.image_xscale;
		image_index = other.image_index;
		depth = -1;
	}
}

event_inherited();
