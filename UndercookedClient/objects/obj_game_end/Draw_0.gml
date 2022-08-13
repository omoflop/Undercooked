/// @desc


var xx = room_width/2;
var yy = room_height/2;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(xx, yy, "Times\nUp!", scale, scale, 2 * sin(timer/10));

draw_set_halign(fa_left);
draw_set_valign(fa_top);
