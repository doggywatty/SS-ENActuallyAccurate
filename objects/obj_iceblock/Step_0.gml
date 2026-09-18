sprite_index = spr_iceblock;

if (global.freezeframe)
{
	vsp = 0;
	exit;
}

baddieInvincibilityBuffer = max(baddieInvincibilityBuffer - 1, 0);
var p = get_nearestPlayer();

switch (state)
{
	default:
		hsp = 0;
		vsp = 0;
		
		if (p.sprite_index != p.spr_machslideboost3)
			baddieOnPlayerCollisions();
		
		break;
	case enemystates.thrown:
		if (markedForDeath)
		{
			movespeed = 16;
			hsp = image_xscale * movespeed;
		}
		else
		{
			hsp = approach(hsp, 0, 0.5);
			
			if (hsp == 0)
				state = enemystates.normal;
			
			if (p.sprite_index != p.spr_machslideboost3)
				baddieOnPlayerCollisions();
		}
		
		var _old_hsp = hsp;
		check_and_destroy(x + hsp, y, obj_destructibles);
		scr_collision();
		
		if (hsp == 0 && markedForDeath)
		{
			state = enemystates.cherryWait;
			visible = false;
			
			if (content != -4)
			{
				with (instance_create(x + _old_hsp, y, content))
				{
					vsp = -10;
					baddieStunTimer = 30;
					state = enemystates.thrown;
					other.baddieID = id;
					create_particle(x, y, spr_poofeffect);
				}
			}
		}
		
		break;
	case enemystates.cherryWait:
		if (baddieID != -4 && !instance_exists(baddieID))
		{
			instance_destroy();
			ds_list_add(global.SaveRoom, id);
		}
		
		break;
}
