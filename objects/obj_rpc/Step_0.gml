if !global.gamePauseState
{
	if (global.InternalLevelName != "tutorial" && room != rm_mainmenu && room != rm_introVideo
	&& !is_hub() && room != rank_room)
    {
        presenceDetails.state = $"{global.Collect} | Rank {global.currentrank}";
        presenceDetails.smallImg = $"rank_{string_lower(global.currentrank)}";
        presenceDetails.smallImgText = $"Rank {global.currentrank}";
    }
    else
    {
        presenceDetails.state = "";
        presenceDetails.smallImg = "";
        presenceDetails.smallImgText = "";
    }
}

np_setpresence_more(presenceDetails.smallImgText, presenceDetails.largeImgText, false);
np_setpresence(presenceDetails.state, presenceDetails.details, presenceDetails.largeImg, presenceDetails.smallImg);
np_update();
