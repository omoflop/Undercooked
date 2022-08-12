
function approach(val, goal, step) {
	return val < goal ? min(val + step, goal) : max(val - step, goal);
}


function log(str) {
	for (var i = 1; i < argument_count; i ++) {
		var arg = argument[i];
		str = string_replace(str, "%s", string(arg));
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
