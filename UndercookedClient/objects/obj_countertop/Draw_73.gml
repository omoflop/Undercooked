/// @desc

var size = 16;

if (show_progress) {
	if (!item.empty && item.progress > 0) {
		var w = 24;
		var h = 5;
		var ysep = 2;
		var yy = y - ysep - h;
		var xx = x + size/2 - w/2;
		draw_rectangle(xx, yy, xx+w, yy+h, 1);
		draw_rectangle(xx, yy, xx+w*item.progress, yy+h, 0);
	}
}

