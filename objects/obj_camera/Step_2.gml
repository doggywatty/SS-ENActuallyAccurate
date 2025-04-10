global.hitstunalarm = approach(global.hitstunalarm, -1, 1);

if (global.freezeframe && global.hitstunalarm <= 0)
    global.freezeframe = false;

if NextFreeze
{
    NextFreeze = false;
    event_user(0);
}
