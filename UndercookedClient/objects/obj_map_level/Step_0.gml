/// @desc

hover = distance_to_object(obj_map_player) < 16;
image_index = hover;

if (hover) {
	timer = approach(timer, timer_max, 1);
} else {
	timer = 0;
}

if (hover && global.key_action && !pressed) {
	pressed = true;
	send_info("select_level", {level_index: level_index});
}