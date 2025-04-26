depth = -25;
sucrose_lighting = false;
sucrose_color = 0;
sucrose_color_array = [
	obj_parent_follower, obj_baddieSpawner, obj_parent_collect, obj_rocketdud, obj_dashpad,
	obj_chocofrog, obj_confectibox, obj_eyescreammine, obj_transportBox
];
sucroseSurface = -4;
drawPlayer = function(_id = id)
{
	with _id
	{
		draw_player_sprite_ext(sprite_index, image_index, x, y, xscale * scale, yscale * scale, draw_angle, image_blend, image_alpha);
		if wetTimer > 0
			draw_sprite_ext_duotone(sprite_index, -1, x, y, xscale * scale, yscale * scale, draw_angle, #f87018, 0, image_alpha * 0.75 * (wetTimer / wetTimerMax));
		if flash
			draw_sprite_ext_flash(sprite_index, image_index, x, y, xscale * scale, yscale * scale, draw_angle, c_white, image_alpha);
		if isInSecretPortal
			draw_sprite_ext_flash(sprite_index, image_index, x, y, xscale * scale, yscale * scale, draw_angle, #49298d, image_alpha * (1.5 - scale));
		if global.DebugVisuals
			draw_rectangle(bbox_left + 1, bbox_top + 1, bbox_right - 1, bbox_bottom - 1, true);
	}
};

drawBaddieSprite = function(_id = id)
{
	with _id
	{
		var _drawx = x + (46 * squashValueY);
		var _drawy = y + (46 * squashValueX);
		if (global.freezeframe && markedForDeath)
		{
			_drawx += irandom_range(-1, 1);
			_drawy += irandom_range(-1, 1);
		}
		
		var _xs = (abs(image_xscale) + squashValueX) * sign(image_xscale);
		var _ys = yscale - squashValueX;
		if hasSquashedY
		{
			_xs = yscale - squashValueY;
			_ys = (abs(image_xscale) + squashValueY) * sign(image_xscale);
		}
		if (yscale <= -1)
			_drawy += 47;
		if !is_undefined(paletteSprite)
		{
			pal_swap_set(paletteSprite, paletteSelect, false);
			draw_sprite_ext(sprite_index, image_index, _drawx, _drawy, _xs, _ys, image_angle, image_blend, image_alpha);
			pal_swap_reset();
		}
		else
			draw_sprite_ext(sprite_index, image_index, _drawx, _drawy, _xs, _ys, image_angle, image_blend, image_alpha);
		
		if wetTimer > 0
			draw_sprite_ext_duotone(sprite_index, image_index, _drawx, _drawy, _xs, _ys, image_angle, #f87018, 0, image_alpha * 0.75 * (wetTimer / wetTimerMax));
		if flash
			draw_sprite_ext_flash(sprite_index, image_index, _drawx, _drawy, _xs, _ys, image_angle, c_white, image_alpha);
		
		if (canSpawnStunBird && baddieStunTimer >= 50 && state == States.charge)
		{
			birdEffect.draw(x, y - 40, 1, 1, 0, c_white, 1);
			birdEffect.update();
		}
		if tauntBuffer
		{
			angerEffect.draw(x, y, 1, 1, 0, c_white, 1);
			angerEffect.update();
		}
		if is_callable(enemyDraw_extra)
			enemyDraw_extra();
	}
};
