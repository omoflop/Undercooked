
function approach(val, goal, step) {
	return val < goal ? min(val + step, goal) : max(val - step, goal);
}

function wrap(val, divider) {
	var v = val % divider;
	if (v < 0) {
		v += divider;
	}
	return v;
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

function array_push_all(array, other_array) {
	for(var i = 0; i < array_length(other_array); i++) {
		array_push(array, other_array[i]);	
	}
}

function number_compare(elm1, elm2) {
    return elm1 - elm2;
}

function draw_set_text(font=draw_get_font(), halign, valign) {
	draw_set_font(font);
	draw_set_halign(halign);
	draw_set_valign(valign);
}

function draw_reset_text() {
	draw_set_font(fnt_main);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

function clone_struct(s) {
	var new_s = {};
	var names = variable_struct_get_names(s);
	for (var i = 0; i < array_length(names); i ++) {
		var n = names[i];

		if (is_method(s[$ n])) {
			new_s[$ n] = method(new_s, s[$ n]);
		} else {
			new_s[$ n] = clone_value(s[$ n]);
		}
	}
	return new_s;
}

function clone_value(v) {
	if (is_array(v)) {
		var a = [];
		for (var i = 0; i < array_length(v); i ++) {
			array_push(a, clone_value(v[i]));
		}
		return a;
	} else if (is_string(v) || is_real(v)) {
		return v;
	} else if (is_struct(v)) {
		return clone_struct(v);
	}
	
	return v;
}