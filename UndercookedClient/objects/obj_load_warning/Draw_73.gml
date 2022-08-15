/// @desc

draw_clear(c_black);

var xx = room_width/2;
var yy = room_height/2 - 40;
var scale = 2.5;

var text = "Loading...";

draw_set_text(fnt_score, fa_center, fa_middle);

draw_text_transformed(xx, yy, text, 2.5, 2.5, 0);

draw_reset_text();


var r1 = 20;
var r2 = 17;
var t = r1 + 10;

yy += r1 + string_height(text) * scale;
var a = timer;
var a_size = 40;



draw_circle(xx, yy, r1, 0);
draw_set_color(c_black);
draw_circle(xx, yy, r2, 0);

draw_triangle(xx, yy, xx + t * dcos(a + a_size), yy + t * dsin(a + a_size), xx + t * dcos(a), yy + t * dsin(a), 0);
draw_triangle(xx, yy, xx + t * dcos(a - a_size), yy + t * dsin(a - a_size), xx + t * dcos(a), yy + t * dsin(a), 0);

draw_set_color(c_white);

timer += 3;