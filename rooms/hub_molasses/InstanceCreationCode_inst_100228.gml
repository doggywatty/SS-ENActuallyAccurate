text = scr_painterdemodialogue();
mybubble = spr_npcbubblepainter;
myrope = spr_npcropepainter;
bubblesubimg = -1;
bubblesubimg2 = -1;
ropetype = RopeType.bottom;
ini_open(global.SaveFileName);

if (ini_read_string("Game", "Judgment", "none") != "none")
	instance_destroy();

ini_close();
