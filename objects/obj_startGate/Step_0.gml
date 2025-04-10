fade = (distance_to_object(obj_parent_player) - 50) / 250;
if (fade <= 0.45)
{
	with gatePointDisplay
	{
		if !visible
		{
			visible = true;
			y = min(targetY - 650, camera_get_view_y(view_camera[0]) - (camera_get_view_height(view_camera[0]) / 2));
			for (var i = 0; i < array_length(pointText); i++)
				pointText[i].y += y - 50;
		}
	}
}

var all_text_landed = false;
with gatePointDisplay
{
	if visible
	{
		y = approach(y, targetY, 20);
		for (var i = 0; i < array_length(pointText); i++)
			pointText[i].y = approach(pointText[i].y, targetY, 20);
		if (pointText[array_length(pointText) - 1].y >= targetY)
			all_text_landed = true;
	}
}

with gateRankBubble
{
	if !visible && all_text_landed
	{
		visible = true;
		bubbleScale = 3;
	}
	bubbleScale = approach(bubbleScale, 1, 0.3);
}

var gatelands = [spr_gatesecretsplat1, spr_gatesecretsplat2, spr_gatesecretsplat3];
var gateloops = [spr_gatesecretloop1, spr_gatesecretloop2, spr_gatesecretloop3];
var play_splat = false;

for (var i = 0; i < 3; i++)
{
	if (secretcanspit && secrets[i])
	{
		with (secretCanvas[i])
		{
			if (sprite_index == spr_null)
				exit;
			
			visible = other.secretcanspit;
			
			if (sprite_index == spr_gatesecretfall)
			{
				if (vsp < 20)
					vsp += 0.3;
			}
			
			x += hsp;
			y += vsp;
			
			if (y >= (other.y + 32) && sprite_index == spr_gatesecretfall)
			{
				hsp = 0;
				vsp = 0;
				
				repeat 3
					instance_create(x, y, obj_secretpoof);
				
				sprite_index = gatelands[i];
				image_index = 0;
				play_splat = true;
			}
			
			if (sprite_animation_end() && sprite_index != spr_gatesecretfall)
				sprite_index = gateloops[i];
			
			image_index += image_speed;
		}
	}
}

if play_splat
	event_play_oneshot("event:/SFX/general/secretSplat", x, y + 32);
