/// @desc

if (timer == timer_max && data.completed) {
	var w = 40;
	var h = 40;
	var xx = x - w/2;
	var yy = y - h/2 - 32;
	
	draw_roundrect(xx, yy, xx+w, yy+h, 0);
	
	draw_set_color(c_black);
	draw_roundrect(xx, yy, xx+w, yy+h, 1);
	draw_set_color(c_white);
	
	draw_sprite(spr_star_score, data.stars, xx+w/2, yy+6);
	
	draw_set_text(fnt_debug_small,fa_center,,c_black);
	
	draw_text(xx+w/2, yy+22, string(data.score));
	draw_reset_text();
}

