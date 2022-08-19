/// @desc

if (array_length(global.other_clients) > index) {
	data = global.other_clients[index];
} else {
	instance_destroy();
}

if (point_distance(x, y, data.x, data.y) < 50) {
	x = data.x;
	y = data.y;
} else {
	x = lerp(x, data.x, 0.2);
	y = lerp(y, data.y, 0.2);
}

depth = -bbox_bottom;