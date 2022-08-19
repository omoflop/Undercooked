/// @desc

if (!instance_exists(obj_transition) && !done) {
	active = true;
}

if (!active) return;


var goal = min(steps[cur_step], score_goal);

if (cur_step == 2) {
	goal = score_goal;
}

amount = lerp(amount, goal, 0.1);

if (abs(amount - goal) < 10 && score_goal >= steps[cur_step]) {
	if (cur_step < 2) {
		star_shine_alpha[cur_step] = 1;
		progress[cur_step] = 1;
		cur_step ++;
	} else if (!done) {
		shine_x += 4;
	}
}

if (abs(amount - goal) < 5 && !done && alarm[0] == -1) {
	alarm_set(0, 80);
}

if (done) {
	if (keyboard_check_pressed(vk_anykey)) {
		send_info("endscreen_done", {});
		active = false;
	}
}

for (var i = 0; i < array_length(star_shine_alpha); i ++) {
	var a = star_shine_alpha[i];
	star_shine_alpha[i] = approach(a, 0, 0.02);
}