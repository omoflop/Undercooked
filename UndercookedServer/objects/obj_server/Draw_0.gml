/// @desc

for (var i = 0; i < array_length(clients); i ++) {
	var xx = 10;
	var yy = 10 + 20 * i;
	var c = clients[i];
	var color = make_color_hsv(c.color_index*10, 255, 255);
	
	var t = "[" + string(i) + "] ";
	
	t += "(" + string_format(c.x, 3, 0) + ", " + string_format(c.y, 3, 0) + ")";
	
	if (c.host) {
		t += " (HOST) ";
	}
	
	draw_set_color(color);
	draw_text(xx, yy, t);
	draw_set_color(c_white);
	
	var tw = string_width(t);
	var r = 10;
	var cx = xx + tw + 5 + r;
	var cy = yy + 10;
	draw_circle(cx, cy, r, 1);
	draw_line(cx, cy, cx + r * cos(c.dir), cy + r * sin(c.dir));
}
