image_speed = 0.35;
depth = -6;
followQueue = ds_queue_create();
hsp = 0;
vsp = 0;
grav = 0.23;
movespeed = 3;
panic = 0;
distance = 0;
magnitude = 0;
drawxscale = image_xscale;
targetx = xstart;
targety = ystart;
scale = 1;
wetTimer = 0;
wetTimerEffect = 3;
confecti_dir = 0;
wetTimerMax = 150;
interpolation = 0;
use_interpolation = true;
scr_confecti_init();
sprite_index = spr_appear;
mask_index = spr_crouchmask;
state = confectistate.appear;

enum confectistate
{
	normal,
	taunt,
	appear,
	unlock
}