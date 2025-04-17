signatureShow = 1;
signatureScale = 1;
var drawSignature = info.x != -4 && info.y != -4;
if drawSignature
{
	repeat 4
		create_debris(info.x, info.y, spr_titlecardsignature_debris);
	event_play_oneshot("event:/SFX/player/goopfloor", obj_player1.x, obj_player1.y);
}
