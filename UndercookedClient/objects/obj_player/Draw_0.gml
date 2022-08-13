/// @desc



draw_self();

if (item.empty) {
	var xx = x + 8 * cos(axis_angle);
	var yy = y + 8 * sin(axis_angle);

	draw_set_color(c_red);
	draw_circle(xx, yy, 2, 0);
	draw_set_color(c_white);
}