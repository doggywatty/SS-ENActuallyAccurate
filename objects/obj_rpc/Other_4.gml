var _details = (global.InternalLevelName != "none") ? ds_map_find_value(global.GameLevelMap, global.InternalLevelName).visualName : "";
var levels = ["entryway", "steamy", "mineshaft", "molasses"];
presenceDetails.largeImg = array_contains(levels, global.InternalLevelName) ? global.InternalLevelName : "none";
presenceDetails.largeImgText = global.gameframe_caption_text;
presenceDetails.details = _details;
