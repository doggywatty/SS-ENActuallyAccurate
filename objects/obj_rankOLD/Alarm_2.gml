alarm[1] = -1;
alarm[0] = -1;
pshake = false;

if (countpoint != global.Collect)
{
    countpoint = approach(countpoint, global.Collect, inicollect);
    pshake = true;
    alarm[2] = 3;
}
else
{
    alarm[2] = -1;
    alarm[3] = 25;
    if global.janitorRudefollow
        alarm[6] = 25;
}
