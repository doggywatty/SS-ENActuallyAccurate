if (!global.showtiles || array_length(global.secret_layers) <= 0)
	exit;

shader_set(shd_secretwall);
var alp = shader_get_uniform(shd_secretwall, "alpha");
for (var i = 0; i < array_length(global.secret_layers); i++)
{
	var a = global.secret_layers[i];
	if (a.alpha <= 0)
		continue;
	if (layer_exists(global.secret_layers[i].id))
	{
		shader_set_uniform_f(alp, a.alpha);
		var tilemap = layer_tilemap_get_id_fixed(global.secret_layers[i].id);
		draw_tilemap(tilemap, 0, 0);
		shader_set_uniform_f(alp, 1);
	}
}

shader_reset();
