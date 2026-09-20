if (point_in_circle(x, y, obj_parent_player.x + (75 * obj_parent_player.xscale), obj_parent_player.y, 125) && obj_parent_player.inhaling && state != enemystates.inhaled)
	state = enemystates.inhaled;

if (flash && alarm[2] <= 0)
{
}

if (state != PlayerState.stun)
	depth = 0;

if (state != enemystates.thrown && state != PlayerState.freezeframe)
	thrown = 0;

enemyAttackTimer = max(enemyAttackTimer - 1, 0);

if (state == enemystates.thrown)
	grav = 0.5;
else
	grav = 0;

if (state == enemystates.normal)
	state = enemystates.float;

event_inherited();

if (state != enemystates.float || substate == 0)
	scr_scareenemy();

if (state != enemystates.float)
	substate = 0;

if (state == enemystates.float && substate == 1 && sprite_index == spr_snowclouddiveboil)
{
	if (hitboxcreate == 0)
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
			hitboxID = id;
		}
	}
}
else if (instance_exists(hitboxID))
{
	hitboxcreate = 0;
	instance_destroy(hitboxID);
}

if (substate == 0)
	y = approach(y, ystart, 2);
