spr_charge = spr_guardian_charge;
spr_windup = spr_guardian;
spr_aim = spr_guardian_aim;
spr_wakeup = spr_guardian_wakingUp;
movespeed = 0;
maxspeed = 18;
candie = 0;
dir = 0;
aimtime = 30;
accel = 0.25;
shaketime = 0;
stuntime = 0;
chaseActive = false;
offended = false;
state = States.frozen;
targetx = x;
targety = y;
targetpassed = false;
warningx = x;
warningy = y;
warningspeed = 0.3;
pathxstart = x;
pathystart = y;
pathspr = spr_guardianpath;
warningspr = spr_guardwhistle;
awoken = false;
playedSound = false;
sndMoving = fmod_createEventInstance("event:/SFX/enemies/guardianMove");
sndSob = fmod_createEventInstance("event:/SFX/enemies/guardianOffended");
sndWake = fmod_createEventInstance("event:/SFX/enemies/guardian");
alarm[0] = 1;
image_speed = 0;
depth = 0;

with (instance_create(x, y, obj_icontracker))
{
    target = other.id;
    visible_cond = function()
    {
        return target.chaseActive == true;
    };
    sprite_index = spr_guardian_icon;
}

returntimer = 0;

