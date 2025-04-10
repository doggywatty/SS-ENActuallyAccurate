prevSpriteIndex = sprite_index;
grav = 0.5;

if (instance_exists(obj_cutsceneManager) && obj_cutsceneManager.exitLevelCustcene)
{
	hsp = 0;
	vsp = 0;
	grav = 0;
}

if (state != States.bump && state != States.cottonroll && state != States.crouch && state != States.tumble && sprite_index != spr_null && sprite_index != spr_player_PZ_frostburn_land_spin && state != States.Sjumpprep && state != States.machroll && state != States.hurt && state != States.crouchjump)
	mask_index = spr_player_mask;
else
	mask_index = spr_crouchmask;

scr_getinput();
inputBufferJump = key_jump ? 15 : max(inputBufferJump - 1, 0);
inputBufferSlap = key_slap2 ? 12 : max(inputBufferSlap - 1, 0);
coyoteTime = (grounded && vsp >= 0) ? 8 : max(coyoteTime - 1, 0);

if (vsp < 0)
	coyoteTime = 0;

can_jump = (grounded && vsp > 0) || (!grounded && coyoteTime > 0 && vsp > 0);
scr_playerstate();
hspCarry += slideHsp;
scr_collide_destructibles();

if (state != States.titlescreen && state != States.oldtaunt && state != States.noclip
&& state != States.door && state != States.comingoutdoor && state != States.victory
&& state != States.timesup && state != States.gameover)
	scr_collision();
else if (state == States.gameover)
{
	x += hsp;
	y += vsp;
	if (vsp < terminalVelocity)
		vsp += grav;
}

var _state = global.freezeframe ? frozenState : state;
scr_setTransfoTip(_state);
if (oldPromptText != global.TransfoPrompt)
{
	oldPromptText = global.TransfoPrompt;
	ini_open(global.SaveFileName);
	var _seen_prompt = ini_read_real("Tip", global.TransfoPrompt, false);
	if (global.TransfoPrompt != "" && !_seen_prompt)
	{
		scr_queueToolTipPrompt(lang_get(global.TransfoPrompt));
		ini_write_real("Tip", global.TransfoPrompt, true);
	}
	ini_close();
}

scr_playersounds();
cutscene = state == States.door || state == States.gotkey || state == States.actor || state == States.victory || state == States.comingoutdoor || state == States.gameover;
isInSecretPortal = false;
isInLapPortal = false;
draw_angle = 0;
