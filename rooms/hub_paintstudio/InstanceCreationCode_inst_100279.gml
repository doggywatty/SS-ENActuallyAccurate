flags.do_once_per_save = false;
flags.do_once = false;
flags.do_save = false;
doThing = false;

if (chance(1))
	doThing = true;

condition = function()
{
	return global.GLOBAL_FUN == 66 && doThing && !instance_exists(obj_fadeoutTransition);
};

output = function()
{
	with (100255)
		targetRoom = !global.option_speedrun_timer ? hub_molassesB : hub_molasses;
};
