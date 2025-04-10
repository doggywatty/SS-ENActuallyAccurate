debugText = [];
save_index = 0;
saveAlpha = 0;
depth = -200;

hudObject = function(_x, _y) constructor
{
	xstart = _x;
	ystart = _y;
	x = xstart;
	y = ystart;
	image_index = 0;
	image_speed = 0.35;
};

moveUpY = 0;
global.TooltipPrompt = "";

HUDObject_rankBubble = new hudObject(16, 16);
with HUDObject_rankBubble
{
	scale = 1;
	surface = undefined;
}

HUDObject_TV = new hudObject(845, 80);
with HUDObject_TV
{
	tvBG = spr_tvHUD_bg;
	tvBG_index = 0;
	hidden = false;
	sprite_index = spr_tvHUD_turningOn;
	queuedSprite = spr_tvHUD_turningOn;
	image_index = 0;
	sprite_image_number = 1;
	image_speed = 0.35;
	tvIdleAnimationBuffer = choose(500, 450, 400, 550);
	tvEscapeBuffer = irandom_range(300, 1000);
	tvExpressionSprite = undefined;
	tvExpressionBuffer = 0;
	tvNormalStates = false;
	tvPrevNormalStates = tvNormalStates;
	tvForceTransition = false;
	tvDoingExpression = false;
	tvPrevDoingExpression = tvDoingExpression;
	
	tvAnimations = function(_Player)
	{
		var player_state = global.freezeframe ? _Player.frozenState : _Player.state;
		if (sprite_index == spr_tvHUD_turningOn && !sprite_animation_end(,, sprite_image_number))
			exit;
		
		tvDoingExpression = false;
		if (!is_undefined(tvExpressionSprite) && tvExpressionBuffer > 0)
		{
			tvDoingExpression = true;
			queuedSprite = tvExpressionSprite;
			var _count = true;
			var _sprite_check = tvExpressionSprite;
			if (array_contains(global.TvSprPlayer_HurtExp, tvExpressionSprite))
				_sprite_check = global.TvSprPlayer_Hurt;
			switch _sprite_check
			{
				case global.TvSprPlayer_Hurt:
					_count = obj_parent_player.state != States.hurt;
					break;
				case global.TvSprPlayer_KeyGot:
					_count = obj_parent_player.state != States.gotkey;
					break;
				case global.TvSprPlayer_Secret:
					_count = !obj_parent_player.isInSecretPortal;
					break;
			}
			
			if (_count && tvExpressionBuffer-- <= 0)
			{
				tvExpressionSprite = undefined;
				tvExpressionBuffer = 0;
			}
			exit;
		}
		
		tvNormalStates = false;
		switch player_state
		{
			default:
				var from_transition = [global.TvSprPlayer_Mach2, global.TvSprPlayer_Mach3, global.TvSprPlayer_Mach4];
				tvNormalStates = true;
				
				if ((queuedSprite == global.TvSprPlayer_IdleAnim1 || queuedSprite == global.TvSprPlayer_IdleAnim2) && !sprite_animation_end(,, sprite_image_number))
					exit;
				if (array_contains(from_transition, sprite_index))
					tvForceTransition = true;
				
				queuedSprite = get_panic() ? global.TvSprPlayer_EscapeIdle : global.TvSprPlayer_Idle;
				if (queuedSprite == global.TvSprPlayer_Idle && tvIdleAnimationBuffer-- <= 0 && global.Combo < 5)
				{
					tvIdleAnimationBuffer = choose(500, 450, 400, 550);
					queuedSprite = choose(global.TvSprPlayer_IdleAnim1, global.TvSprPlayer_IdleAnim2);
					image_index = 0;
				}
				
				if (global.Combo >= 10 && !get_panic())
					queuedSprite = global.TvSprPlayer_Combo;
				if (global.Combo >= 50 && !get_panic())
					queuedSprite = global.TvSprPlayer_HighCombo;
				break;
			case States.mach1:
			case States.mach2:
			case States.mach3:
			case States.wallkick:
			case States.machslide:
			case States.climbwall:
			case States.machroll:
				tvNormalStates = true;
				var my_mvsp = global.freezeframe ? abs(_Player.frozenMoveSpeed) : abs(_Player.movespeed);
				if (player_state == States.climbwall)
					my_mvsp = global.freezeframe ? abs(_Player.frozenVerticalMovespeed) : abs(_Player.verticalMovespeed);
				var _oldQueue = queuedSprite;
				if (player_state == States.mach3 || (player_state == States.climbwall && my_mvsp >= 12)
				|| (player_state == States.machslide && _Player.sprite_index == _Player.spr_machslideboost3)
				|| (player_state == States.machroll && _Player.mach3Roll > 0))
					queuedSprite = global.TvSprPlayer_Mach3;
				if (_Player.sprite_index == _Player.spr_crazyrun || (player_state == States.climbwall
				&& my_mvsp >= 20) || (player_state == States.machroll && _Player.mach3Roll > 0 && my_mvsp >= 20))
					queuedSprite = global.TvSprPlayer_Mach4;
				if (player_state == States.wallkick)
					queuedSprite = global.TvSprPlayer_Mach2;
				if (queuedSprite != _oldQueue)
					tvForceTransition = true;
				break;
			case States.tumble:
				queuedSprite = global.TvSprPlayer_Ball;
				break;
			case States.puddle:
				queuedSprite = global.TvSprPlayer_Slipping;
				break;
			case States.oldtaunt:
				queuedSprite = global.TvSprPlayer_Hooked;
				if (_Player.sprite_index == spr_player_PZ_frostburn_hook)
					queuedSprite = global.TvSprPlayer_FrostBurn;
				break;
			case States.minecart:
				queuedSprite = global.TvSprPlayer_Minecart;
				break;
			case States.fireass:
			case States.fireassdash:
				queuedSprite = global.TvSprPlayer_FireAss;
				break;
			case States.cotton:
			case States.cottondrill:
			case States.cottonroll:
			case States.cottondig:
				queuedSprite = global.TvSprPlayer_WereCotton;
				break;
			case States.frostburnjump:
			case States.frostburnnormal:
			case States.frostburnslide:
			case States.frostburnstick:
				queuedSprite = global.TvSprPlayer_FrostBurn;
				break;
			case States.fling:
				queuedSprite = global.TvSprPlayer_Croaked;
				break;
			case States.doughmount:
			case States.doughmountspin:
			case States.doughmountballoon:
			case States.doughmountpancake:
				queuedSprite = global.TvSprPlayer_MarshMount;
				break;
		}
	};
	
	muteIconAlpha = true;
	muteIconBufferMax = 400;
	muteIconBuffer = muteIconBufferMax;
	transition = 
	{
		image_index: 0,
		image_speed: 0.3,
		activated: false,
		sprite_index: spr_tvHUD_transitionStatic
	};
	weakSignal = 
	{
		signalBuffer: 0,
		image_index: 0,
		image_speed: 0.35,
		sprite_index: spr_tvHUD_weakSignal_small
	};
	propeller = 
	{
		image_index: 0,
		image_speed: 0.5,
		activated: true
	};
	
	idleScreenSaver = 
	{
		activated: false,
		keyPositions: [
			[-62, -15], [-9, 39], [34, -4], [18, -21], [-45, 43], [-63, 28], [-17, -20]
		],
		playBackSpeed: 1,
		playbackDirection: 1
	};
	with idleScreenSaver
	{
		x = keyPositions[0][0];
		y = keyPositions[0][1];
		keyframeIndex = 0;
		keyframeNumber = array_length(keyPositions);
	}
}

HUDObject_comboMeter = new hudObject(845, 165);
with HUDObject_comboMeter
{
	displayYMax = -300;
	displayY = displayYMax;
	displayVSP = 0;
	comboDisplay = 0;
	displayState = ComboState.Off;
	comboTimeDisplay = 0;
	combofillDisplay = 0;
	comboSurface = -4;
	elm_meterFill = 
	{
		sprite_index: spr_tvHUD_comboMeter_fill,
		image_index: 0,
		image_speed: 0.35
	};
}

HUDObject_timer = new hudObject(480, 480);
with HUDObject_timer
{
	targetEscapeTime = 0;
	elm_coneBall = 
	{
		sprite_index: spr_bartimer_normalFront,
		image_index: 0,
		image_speed: 0.35
	};
	elm_clockTimer = 
	{
		image_index: 0,
		image_speed: 0.35
	};
}

HUDObject_tooltipPrompts = new hudObject(480, 500);
with HUDObject_tooltipPrompts
{
	image_alpha = 0;
	promptTimer = 0;
}
