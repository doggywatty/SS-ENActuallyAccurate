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
solidCollideFunc=function(_player=obj_parent_player)
{
	switch (_player.object_index)
	{
		case obj_parent_player:
		case obj_player1:
		case obj_player2:
			var _state=global.freezeframe ? _player.frozenState : _player.state;
			return _state != PlayerState.ladder;
			break;
		default:
			return true;
			break;
	}
};
//PADDINGPADDINGPADDINGPADDINGPADDINGPADDIN
nonsolidCollideFunc=function(_player=obj_parent_player)
{
	switch (_player.object_index)
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
