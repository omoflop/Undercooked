/// @desc

depth = -99999;

active = false;

lines = [];
count = 0;

function setup(l) {
	array_push(lines, "[" + string(count) + "]: " + l);
	count ++;
}