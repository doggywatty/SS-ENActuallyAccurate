if (ds_exists(textureLoaderList, ds_type_list))
{
	if !ds_list_empty(textureLoaderList)
	{
		var tex = ds_list_find_value(textureLoaderList, 0);
		for (var i = 0; i < array_length(tex); i++)
		{
			if (!texture_is_ready(tex[i]))
				texture_prefetch(tex[i]);
		}
		ds_list_delete(textureLoaderList, 0);
		alarm[0] = 1;
	}
	
	if (ds_list_empty(textureLoaderList))
	{
		alarm[1] = 1;
		alarm[0] = -1;
	}
}
