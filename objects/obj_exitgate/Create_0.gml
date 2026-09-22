image_speed = 0.35;
hurtpoints = 0;
escapetimepoints = 0;
treasurepoints = 0;
lastbesttimeminutes = 99;
lastbesthurt = 99;
drop = 0;
drop_state = 0;
drop_y = 0;
hsp = 0;
vsp = 0;
grav = 0.5;
depth = 49;
image_index = 0;
openSpr = spr_enterexitgate;
closingSpr = spr_exitgateclosing;
closedspr = spr_exitgateclosed;

if (isDemo && global.InternalLevelName != "none")
{
	instance_create(x, y - 119, obj_paintertopper, 
	{
		depth: depth - 1
	});
}
