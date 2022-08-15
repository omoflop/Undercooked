/// @desc


if (sprite_index != -1) {
	draw_sprite_stretched(sprite_index, hover, x, y, width, height);
} else {
	if (hover) {
		draw_set_color(c_yellow);
	}
	
	draw_rectangle(x, y, x+width, y+height, 1);

	draw_set_text(font, fa_center, fa_middle);
	
	draw_text(x+width/2, y+height/2, text);
	
	draw_reset_text();
	draw_set_color(c_white);
}