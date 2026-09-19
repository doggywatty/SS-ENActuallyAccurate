//PADDINGPADDINGPA
image_yscale=0;
geyserHeightInterval=1/3;
geysertimer=300;
geyserGoDown=false;
geyserSolid=false;
geyserPredeploy=false;
image_speed=0.35;
depth=11;
sound=event_play_oneshot("event:/SFX/general/geyser",(x - sprite_xoffset) + (sprite_width / 2),bbox_top);
ambianceSND=fmod_createEventInstance("event:/SFX/general/geyserambiance");
fmod_studio_event_instance_start(ambianceSND);
solidCollideFunc=function(arg0=obj_parent_player)
{
	switch (arg0.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state=global.freezeframe ? arg0.frozenState : arg0.state;
			return _state != states.grabbing;
			break;
		default:
			return true;
			break;
	}
};
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDIN
nonsolidCollideFunc=function(arg0=obj_parent_player)
{
	switch (arg0.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			return false;
			break;
		default:
			return true;
			break;
	}
};
canCollide=nonsolidCollideFunc;
