/// @desc

draw_set_font(fnt_score);
draw_set_halign(fa_right);

var xx = room_width-5;
var yy = 5;

draw_set_color(merge_color(c_white, color, color_alpha));
draw_text(xx, yy, display_score);
draw_set_color(c_white);


draw_set_halign(fa_left);
