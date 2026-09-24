signatureShow = 1;
signatureScale = 1;
var drawSignature = info.x != noone && info.y != noone;

if (drawSignature)
{
	repeat (4)
		create_debris(info.x, info.y, spr_titlecardsignature_debris);
	
	event_play_oneshot("event:/SFX/player/goopfloor", obj_player1.x, obj_player1.y);
}
