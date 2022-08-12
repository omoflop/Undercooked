/// @desc



draw_self();

var size = 16;

if (item != -1) {
	draw_item(x + size/2, y + size/2 - offset, item);
}

if (player_hover) {
	draw_set_alpha(0.5);
	draw_rectangle(x, y - offset, x+size - 1, y+sprite_height - 1, 0);
	draw_set_alpha(1);
}

if (item != -1 && item.progress > 0) {
	var w = 24;
	var h = 5;
	var ysep = 2;
	var yy = y - ysep - h;
	var xx = x - w/2;
	draw_rectangle(xx, yy, xx+w, yy+h, 1);
	draw_rectangle(xx, yy, xx+w*item.progress, yy+h, 0);
}

