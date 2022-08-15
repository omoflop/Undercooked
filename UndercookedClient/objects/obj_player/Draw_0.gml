/// @desc

image_blend = make_color_hsv(wrap(global.client.color_index * 10, 255), 255, 255);
draw_self();

if (item.empty) {
	var xx = x + 8 * cos(axis_angle);
	var yy = y + 8 * sin(axis_angle);

	draw_circle(xx, yy, 2, 0);
}
