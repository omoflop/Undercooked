/// @desc


display_score = ceil(lerp(display_score, global.game_score, 0.1));

if (alarm[0] == -1) {
	color_alpha = approach(color_alpha, 0, color_alpha_step);
}
