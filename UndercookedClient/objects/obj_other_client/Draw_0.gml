/// @desc

image_blend = make_color_hsv(wrap(data.color_index * 10, 255), 255, 255);
draw_self();

var xx = x + 8 * cos(data.dir);
var yy = y + 8 * sin(data.dir);

draw_circle(xx, yy, 2, 0);