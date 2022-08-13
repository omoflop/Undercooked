
function approach(val, goal, step) {
	return val < goal ? min(val + step, goal) : max(val - step, goal);
}


function log(str) {
	for (var i = 1; i < argument_count; i ++) {
		var arg = argument[i];
		str = string_replace(str, "%", string(arg));
	}
	show_debug_message(str);
	return str;
}

function show_log(str) {
	for (var i = 1; i < argument_count; i ++) {
		var arg = argument[i];
		str = string_replace(str, "%", string(arg));
	}
	show_message(str);
	return str;
}


function assert(bool, message) {
	if (bool) return;
	show_error(message, 1);
}

function draw_text_outline(x, y, str, outline_color=c_black) {
	var c = draw_get_color();
	
	draw_set_color(outline_color);
	draw_text(x-1, y, str);
	draw_text(x+1, y, str);
	draw_text(x, y-1, str);
	draw_text(x, y+1, str);
	
	draw_set_color(c);
	draw_text(x, y, str);
}
