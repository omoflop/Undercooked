/// @desc

sw = sprite_get_width(spr_star) * 3;
sh = sprite_get_height(spr_star);

surf = -1;

cur_step = 0;
steps = cur_level().score_steps;
amount = 0;

progress = [0,0,0];

star_shine_alpha = [0,0,0];

done = false;
shine_x = 0;

active = false;

function calculate_stars(s) {
	if (s < steps[0]) {
		return 0;
	} else if (s < steps[1]) {
		return 1;
	} else if (s < steps[2]) {
		return 2;
	} else {
		return 3;
	}
}

score_goal = global.game_score;

var s = global.level_completion_data[global.level_index];
s.score = max(s.score, global.game_score);
s.completed = true;
s.stars = calculate_stars(score_goal);

global.game_score = 0;