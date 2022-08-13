/// @desc

draw_self();

var size = 16;


draw_item();

draw();
	
if (player_hover) {
	gpu_set_fog(1, c_white, 1, 0);
	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, 0.4);
	gpu_set_fog(0, c_white, 1, 0);
}

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
