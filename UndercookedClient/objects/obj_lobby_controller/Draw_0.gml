/// @desc

var xx = x;
var yy = y;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(make_color_hsv(wrap(global.client.color_index*10, 255), 255, 255))
draw_circle(xx, yy, size, 0);


for (var i = 0; i < array_length(global.other_clients); i ++) {
	
	xx += (margin + size);
	
	var c = global.other_clients[i];
	
	draw_set_color(make_color_hsv(wrap(c.color_index*10, 255), 255, 255));
	draw_circle(xx, yy, size, 0);
}

draw_set_color(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);