/// @desc

global.game_score = 0;
display_score = 0;
color = c_white;
color_alpha = 0;
color_alpha_step = 0.03;

function set_score_color(c) {
	color = c;
	color_alpha = 1;
	alarm_set(0, 20);
}
