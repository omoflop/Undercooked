/// @desc


if (hover) {
	draw_set_color(c_yellow);
}

draw_rectangle(x, y, x+width, y+height, 1);



if (text == "") {
	draw_set_color(merge_color(draw_get_color(), c_black, 0.5));
	draw_text(x+padding, y+padding, placeholder);
	draw_set_color(c_white);
} else {
	draw_text(x+padding, y+padding, text);
}

if (selected && blink) {
	draw_text(x+padding + string_width(text), y+padding, "|");
}

draw_set_color(c_white);