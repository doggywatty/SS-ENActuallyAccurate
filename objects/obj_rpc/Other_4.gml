var _details = (global.InternalLevelName != "none") ? ds_map_find_value(global.GameLevelMap, global.InternalLevelName).visualName : "";
var levels = ["tutorial", "entryway", "steamy", "mineshaft", "molasses"];
presenceDetails.largeImg = array_contains(levels, global.InternalLevelName) ? global.InternalLevelName : "none";
presenceDetails.largeImgText = scr_gamecaptions(room) ?? presenceDetails.largeImgText;
presenceDetails.details = _details;
