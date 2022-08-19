/// @desc

event_inherited();

if (hover) {
	window_set_cursor(cr_beam);
} else {
	window_set_cursor(cr_default);
}

if (keyboard_check(vk_anykey) && string_length(text) < max_length) {
	text += string(keyboard_string);
	keyboard_string = "";
	reset_blink();
}

if (keyboard_check(vk_backspace) && !keyboard_check_pressed(vk_backspace) && delete_timer == 2) {
	text = string_delete(text, string_length(text), 1);
	delete_timer = 0;
	keyboard_string = "";
	reset_blink();
}

if (keyboard_check_pressed(vk_backspace)) {
	text = string_delete(text, string_length(text), 1);
	delete_timer = -15;
	keyboard_string = "";
	reset_blink();
}

if (delete_timer != 2) {
	delete_timer = approach(delete_timer, 2, 1);
}

if (alarm[0] == -1) {
	alarm_set(0, 30);
}