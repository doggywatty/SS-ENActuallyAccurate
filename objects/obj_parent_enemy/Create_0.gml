depth = 0;
scr_collision_init();
grav = 0.5;
defaultMovespeed = 1;
defaultMovespeedAcc = undefined;
defaultMovespeedDecc = undefined;
movespeed = 0;
doCollision = true;
state = States.frozen;
tauntBuffer = false;
baddieStunTimer = 0;
enemyAttackTimerMax = 200;
enemyAttackTimer = 0;
baddieCollisionBoxEnabled = true;
invincibleBaddie = false;
baddieInvincibilityBuffer = 0;
markedForDeath = false;
jumpedFromBlock = false;
baddieScareBuffer = 0;
hasAttacked = false;
hurtboxID = -4;
turnTimerMax = 200;
turnTimer = 0;
isFlyingEnemy = false;
canSpawnStunBird = true;
canTurnSelf = false;
canGetScared = true;
canBeStomped = true;
canBeKilled = true;
canBeGrabbed = true;
canBreakBlocks = false;
alarm[1] = 3;
frozenState = 0;
frozenSpriteIndex = spr_player_PZ_idle;
frozenImageIndex = 0;
frozenImageSpeed = 0.35;
frozenMoveSpeed = 0;
frozenGrav = 0.35;
frozenHsp = 0;
frozenVsp = 0;
hasSquashedX = false;
squashValueX = 0;
hasSquashedY = false;
squashValueY = 0;
wetTimer = 0;
wetTimerMax = 150;
wetTimerEffect = 0;
flash = 0;
doRedAfterImage = false;
redAfterImagebuffer = 0;
redAfterImagebufferMax = 10;
baddieSpriteIdle = undefined;
baddieSpriteWalk = spr_gumslime_walk;
baddieSpriteStun = spr_gumslime_stun;
baddieSpriteScared = spr_gumslime_scared;
baddieSpriteTurn = undefined;
baddieSpriteHit = undefined;
baddieSpriteDead = spr_gumslime_dead;
baddieCollisionMask = spr_enemyCollisionBox;
paletteSprite = -4;
paletteSelect = 0;
hitHsp = 0;
hitVsp = 0;
enemyAttack_TriggerEvent = undefined;
enemyState_Attack = undefined;
scr_enemySounds_init();
enemyCustomStates = undefined;

enemyDeath_SpawnBody = function()
{
	with instance_create(x, y, obj_baddieDead)
	{
		image_xscale = other.image_xscale;
		image_blend = other.image_blend;
		sprite_index = other.baddieSpriteDead;
		paletteSprite = other.paletteSprite;
		paletteSelect = other.paletteSelect;
	}
};

enemyDeath_SpawnDeathFX = function()
{
	repeat 3
		create_baddiedebris();
	create_particle(x, y, spr_bangEffect);
	event_play_oneshot("event:/SFX/enemies/kill", x, y);
	camera_shake_add(3, 3);
	enemyDeath_SpawnBody();
};

enemyDeath_awardPoints = function(_enemy = importantEnemy)
{
	global.ComboTime = 60;
	global.ComboFreeze = 15;
	if _enemy
		exit;
	obj_parent_player.superTauntBuffer++;
	global.Combo++;
	var _score = 10 + floor(global.Combo / 2);
	global.Collect += _score;
	global.ComboScore += _score;
};

enemyDraw_extra = undefined;
escapePortalEffect = -4;
dashCloudID = -4;
birdEffect = new subSprite(spr_enemyBirdEffect);
angerEffect = new subSprite(spr_angryCloud);
