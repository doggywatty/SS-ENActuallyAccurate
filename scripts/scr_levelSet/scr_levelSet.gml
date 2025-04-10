function scr_levelSet()
{
	randomize();
	global.RandomSeed = random_get_seed();
	switch global.InternalLevelName
	{
		case "entryway":
			global.doorindex = 1;
			break;
		case "steamy":
			global.doorindex = 2;
			break;
		case "mineshaft":
			global.doorindex = 3;
			break;
		case "molasses":
			global.doorindex = 4;
			break;
		default:
			global.doorindex = 0;
	}
	
	instance_destroy(obj_endlevelfade);
	if (object_index != obj_fadeoutTransition)
		instance_destroy(obj_fadeoutTransition);
	instance_destroy(obj_cutsceneManager);
	instance_destroy(obj_coneball_timesUp);
	instance_destroy(obj_snowwalkparticles);
	instance_destroy(obj_cafedrawer);
	instance_destroy(obj_sucroseTimer);
	instance_destroy(obj_devilboy);
	instance_destroy(obj_lap2visual);
	instance_destroy(obj_minesgem);
	instance_destroy(obj_collect_giver);
	global.CafeDrawer = -4;
	global.cutsceneManager = -4;
	if instance_exists(obj_cutsceneManager)
		instance_destroy(obj_cutsceneManager);
	global.ExitGateTaunt = 0;
	global.TransfoPrompt = "";
	global.TransfoState = States.normal;
	global.freezeframe = false;
	global.greyscalefade = 0;
	global.EscapeTime = 4000;
	global.ComboFreeze = 0;
	global.ComboScore = 0;
	global.secretfound = 0;
	global.SecretsFound = [false, false, false];
	global.LevelFrames = 0;
	global.LevelSeconds = 0;
	global.LevelMinutes = 0;
	global.panic = 0;
	global.HurtCounter = global.HurtMilestone;
	global.LocalHurtCounter = 0;
	global.minesProgress = false;
	global.rocketLauncher = false;
	global.tempRocketLauncher = false;
	global.PainterTopperIndex = irandom_range(0, sprite_get_number(spr_paintertopper) - 1);
	obj_parent_player.visible = true;
	camera_set_view_angle(view_camera[0], 0);
	ds_list_clear(global.SaveRoom);
	ds_list_clear(global.EscapeRoom);
	ds_list_clear(global.BaddieRoom);
	ds_list_clear(global.collectParticleList);
	ds_list_clear(global.particleList);
	instance_destroy(obj_confectimallow);
	instance_destroy(obj_confecticrack);
	instance_destroy(obj_confectichoco);
	instance_destroy(obj_confectiworm);
	instance_destroy(obj_confecticandy);
	instance_destroy(obj_icegrandson);
	instance_destroy(obj_rudejanitor);
	instance_destroy(obj_lapjanitor);
	instance_destroy(obj_spookey);
	ds_list_clear(global.FollowerList);
	ds_list_clear(global.KeyFollowerList);
	global.MallowFollow = false;
	global.CrackFollow = false;
	global.ChocoFollow = false;
	global.WormFollow = false;
	global.CandyFollow = false;
	global.Donutfollow = false;
	global.janitorRudefollow = false;
	global.janitorLapfollow = false;
	global.Treasure = false;
	global.lapcount = 0;
	global.lapmusic = false;
	scr_reset_achievement_tracker();
	scr_get_chef_tasks(global.InternalLevelName);
	scr_get_palettes();
	with obj_camera
	{
		global.currentrank = "D";
		lastRank = "D";
		bubblescale = 0;
		ds_list_clear(cameraShakeList);
		NextFreeze = false;
		DrawHUD = true;
		DrawY = 0;
		global.targetCamX = obj_parent_player.x;
		global.targetCamY = obj_parent_player.y;
		global.ClassicCameraShake = 0;
		global.ClassicCameraShakeAcc = 3 / room_speed;
		var target = obj_parent_player;
		var _cam_x = target.x - (camera_get_view_width(view_camera[0]) / 2);
		var _cam_y = target.y - (camera_get_view_height(view_camera[0]) / 2);
		chargeCameraX = 0;
		chargeCameraY = 0;
		_cam_x = clamp(_cam_x, Camera_xorigin, (Camera_xorigin + Camera_width) - camera_get_view_width(view_camera[0]));
		_cam_y = clamp(_cam_y, Camera_yorigin, (Camera_yorigin + Camera_height) - camera_get_view_height(view_camera[0]));
		_cam_x = clamp(_cam_x, 0, room_width - camera_get_view_width(view_camera[0]));
		_cam_y = clamp(_cam_y, 0, room_height - camera_get_view_height(view_camera[0]));
		Cam_x = _cam_x;
		Cam_y = _cam_y;
		cam_langle = 0;
		cam_lzoom = 1;
		cam_angle = 0;
		cam_zoom = 1;
		oldPointCollect = 0;
		pointCollectShake = 0;
		cameraLock = false;
	}
	
	ini_open(global.SaveFileName);
	var pre_check = ini_read_string("Game", "Judgment", "none") == "none" && scr_check_completion();
	ini_close();
	with obj_parent_player
	{
		hasSeenProgressionPrompt = !pre_check;
		wetTimer = 0;
		oldPromptText = "";
		floatyGrab = 18;
		conveyorHsp = 0;
		global.playerCharacter = mainPlayerCharacter;
		previousCharacter = mainPlayerCharacter;
		slamHurt = 0;
		minesGemCount = 0;
		inBackgroundLayer = false;
		transfoSound = undefined;
		oldTransfoSound = undefined;
		oldComboTitle = 0;
		upsideDownJump = false;
		machFourMode = false;
		grabClimbBuffer = 0;
		crouchSlipBuffer = 0;
		crouchSlipAntiBuffer = 0;
		hsp = 0;
		vsp = 0;
		hspCarry = 0;
		vspCarry = 0;
		fracHsp = 0;
		fracVsp = 0;
		true_hsp = 0;
		true_vsp = 0;
		prevHsp = 0;
		prevVsp = 0;
		slideHsp = 0;
		draw_angle = 0;
		slopeAngle = 0;
		secretPortal = false;
		scale = 1;
		groundedSlope = false;
		targetDoor = "A";
		fireTrailBuffer = 0;
		state = States.comingoutdoor;
		image_index = 0;
		sprite_index = spr_walkfront;
		trace("Levelset");
		sJumpCanDoubleJump = true;
		playComboVariable = -4;
		dashpadBuffer = 0;
		dashpadBuffer = 0;
		vertical = false;
		verticalOffset = 0;
		superTauntBuffer = 0;
		superTauntCharged = false;
		scr_characterSprite();
		for (var i = 0; i < 11; i++)
			alarm[i] = -1;
		grav = 0.5;
		hsp = 0;
		vsp = 0;
		xscale = 1;
		yscale = 1;
		steppy = false;
		movespeedmax = 5;
		jumpStop = false;
		visible = true;
		turn = 0;
		jumpAnim = true;
		landAnim = false;
		machSlideAnim = false;
		crouchAnim = true;
		stompAnim = false;
		turning = 0;
		hurted = false;
		machTwo = 0;
		inputBufferJump = 0;
		inputBufferSecondJump = 8;
		inputBufferHighJump = 8;
		targetRoom = rm_missing;
		flash = false;
		global.Collect = 0;
		global.ComboScore = 0;
		global.Treasure = false;
		global.Combo = 0;
		global.HighestCombo = 0;
		global.ComboTime = 0;
		global.ComboLost = false;
		global.ToppinTotal = 0;
		keyParticles = false;
		idle = 0;
		machPunchAnim = false;
		punch = false;
		windingAnim = 0;
		ladderBuffer = 0;
		dashdust = 0;
		throwforce = 0;
		bouncebackspeed = 0;
		idleAnim = 0;
		momentum = false;
		cutscene = false;
		dir = xscale;
		shotgunAnim = false;
		fallingAnimation = 0;
		slapbuffer = 0;
		slaphand = 1;
		suplexMove = false;
		colors[0] = choose(0, 1, 2, 3);
		headless = false;
		substate = 0;
		hp = 6;
		global.rocketLauncher = false;
	}
	
	global.TooltipPrompt = "";
	with obj_hudManager
	{
		moveUpY = 0;
		with HUDObject_TV
		{
			y = ystart;
			sprite_index = spr_tvHUD_turningOn;
			queuedSprite = spr_tvHUD_turningOn;
			image_index = 0;
			sprite_image_number = sprite_get_number(spr_tvHUD_turningOn);
			tvIdleAnimationBuffer = choose(500, 450, 400, 550);
			tvExpressionSprite = undefined;
			tvExpressionBuffer = 0;
			tvEscapeBuffer = irandom_range(300, 1000);
			transition.activated = false;
			tvNormalStates = false;
			tvPrevNormalStates = tvNormalStates;
			tvDoingExpression = false;
			tvPrevDoingExpression = tvDoingExpression;
		}
		with HUDObject_comboMeter
		{
			y = ystart;
			displayY = displayYMax;
		}
		with HUDObject_timer
		{
			y = ystart + 150;
			targetEscapeTime = 0;
			elm_coneBall.sprite_index = spr_bartimer_normalFront;
			elm_coneBall.image_index = 0;
		}
		with HUDObject_tooltipPrompts
		{
			y = ystart;
			image_alpha = 0;
			promptTimer = 0;
		}
	}
	
	stop_music(true);
	fmod_studio_system_set_parameter_by_name("transfo", false, true);
	global.MenuNoteArraySelect = 0;
	global.MenuNoteArray = scr_defineLevelMenuTune(global.InternalLevelName);
	
	with obj_music
	{
		global.RoomMusic = undefined;
		global.RoomIsSecret = false;
		currentSecretStatus = false;
		panicStart = false;
	}
}
