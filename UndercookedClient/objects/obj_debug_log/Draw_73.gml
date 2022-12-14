/// @desc

if (!active) return;

var w = room_width;
var h = room_height/3;
var yy = h - 1;
var xx = 4;

draw_set_color(c_black);
draw_set_alpha(0.5);
draw_rectangle(0, 0, w, h, 0);
draw_set_color(c_white);
draw_set_alpha(1);

draw_set_font(fnt_debug_small);
draw_set_valign(fa_bottom);

for (var i = 0; i < array_length(lines); i ++) {
	var l = lines[i];
	var t = l.msg;
	if (l.count > 1) {
		t += " (" + string(l.count) + ")";
	}
	
	draw_set_color(l.color);
	draw_text_outline(xx, yy, t);
	yy -= string_height("M") - 2;
}

draw_set_color(c_white);
draw_set_valign(fa_top);
