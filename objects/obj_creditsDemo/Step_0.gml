with obj_parent_player
	state = States.titlescreen;

var skip = input_check_pressed("jump") || input_check_pressed("slap");
var skip2 = input_check("jump") || input_check("attack");

switch creditPhase
{
	case -2:
		pizzelleFlick.setPosition(pizzelleFlick.x - 24, pizzelleFlick.y);
		if (pizzelleFlick.x <= -400)
		{
			event_play_oneshot("event:/SFX/general/creditssplat");
			creditPhase = -1;
			phaseBuffer = 120;
		}
		break;
	case -1:
		if !phaseBuffer--
		{
			if !showLogo
			{
				showLogo = true;
				phaseBuffer = 200;
			}
			else if (logoAlpha > 0)
			{
				logoAlpha = approach(logoAlpha, 0, 0.05);
				if (logoAlpha == 0)
					phaseBuffer = 60;
			}
			else
			{
				creditPhase = 1;
				showLogo = false;
			}
		}
		break;
	case 0:
		curtainSpr.image_speed = 0.35;
		curtainSpr.update();
		if (sprite_animation_end(curtainSpr.sprite_index, curtainSpr.image_index, curtainSpr.image_number, curtainSpr.image_speed))
			creditPhase = 1;
		break;
	case 1:
		event_user(1);
		creditsSpeed = approach(creditsSpeed, skip2 ? skipSpeed : defaultSpeed, 0.6);
		
		if (fadein && fadeAlpha == 1)
		{
			fadein = false;
			creditPhase = 2;
			phaseBuffer = 100;
		}
		break;
	case 2:
		endScreenSpr.visible = true;
		phaseBuffer--;
		if skip && phaseBuffer <= 0
			creditPhase = 3;
		break;
	case 3:
		curtainSpr.image_speed = 0.35;
		bgCredits.image_blend = c_black;
		endScreenSpr.image_alpha = approach(endScreenSpr.image_alpha, 0, 0.01);
		curtainSpr.setPosition(curtainSpr.x + clamp(0 - curtainSpr.x, -6, 6), 0);
		curtainSpr.update();
		if (curtainSpr.image_index >= (curtainSpr.finalFrame - 1))
			room_goto_fixed(rm_mainmenu);
		break;
}

if (creditPhase >= 1 && creditPhase != 3)
{
	bgCreditsFade = approach(bgCreditsFade, 1, 0.05);
	bgCredits.image_blend = make_color_hsv(0, 0, bgCreditsFade * 255);
}

bgCredits.x++;
fadeAlpha = approach(fadeAlpha, fadein, 0.05);
