/// @desc

depth = -99999;

active = false;

lines = [];
count = 0;

function setup(l, color) {
	var a = 10;
	if (count > 0 && string_copy(lines[0], string_pos(lines[0], ":"), a) == string_copy(l, 0, a)) {
		lines[0].count ++;
	}
	
	var msg = "[" + string(count) + "]: " + l;
	var c = color;
	array_insert(lines, 0, {msg: msg, color: c, count: 1});
	array_resize(lines, min(10, array_length(lines)));
	count ++;
}