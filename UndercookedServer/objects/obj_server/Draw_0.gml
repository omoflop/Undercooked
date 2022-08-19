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

draw_set_halign(fa_right);

var xx = room_width-10;
draw_text(xx, 10, timer_controller.get_timer_string());
draw_text(xx, 30, timer_controller.alarm[1]);
draw_text(xx, 50, "Game Active: " + bool_string(game_active));
draw_text(xx, 70, "Level Active: " + bool_string(level_active));
draw_text(xx, 100, "Active Orders: " + string(array_length(global.active_orders)));
order_controller.draw(xx, 120);

draw_set_halign(fa_left);

draw_set_valign(fa_bottom);

draw_text(10, room_height-10, "Time: " + string_format(current_time/1000, 0, 1));

draw_set_valign(fa_top);