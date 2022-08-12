/// @desc

draw_self();

var xx = x + reach * cos(axis_angle);
var yy = y + reach * sin(axis_angle);

draw_set_color(c_red);
draw_line(x, y, xx, yy);
draw_set_color(c_white);

if (item != -1) {
	draw_item(xx, yy, item);
}