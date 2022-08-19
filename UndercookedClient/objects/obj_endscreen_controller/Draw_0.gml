/// @desc


if (!surface_exists(surf)) {
	surf = surface_create(sw, sh);
}

var w = sw/3;
surface_set_target(surf);
		
	draw_clear_alpha(c_white, 0);
	
	draw_sprite(spr_star, 0, 0, 0);
	draw_sprite(spr_star, 0, w, 0);
	draw_sprite(spr_star, 0, w*2, 0);
		
	var a = 0;
	
	if (cur_step == 0) {
		progress[0] = amount/(steps[0]);
	} else if (cur_step == 1) {
		progress[1] = (amount - steps[0]) / (steps[1] - steps[0]);
	} else {
		progress[2] = (amount - steps[1]) / (steps[2] - steps[1]);
	}
		
	gpu_set_colorwriteenable(1,1,1,0);
	
	draw_set_color(c_yellow);
	for (var i = 0; i < array_length(star_shine_alpha); i ++) {
		var a = progress[i];
		var alpha = star_shine_alpha[i];
		var c = merge_color(c_yellow, c_white, alpha);
		draw_rectangle_color(w*i, 0, w*i + w*a, sh, c,c,c,c, 0);
	}
	draw_set_color(c_white);
	
	if (shine_x != 0) {
		var shine_w = 60;
		var shine_size = 20;
		var xx = shine_x - shine_w;
		draw_line_width(xx, sh, xx + shine_w, 0, shine_size);
		
		xx += shine_size + 5;
		draw_line_width(xx, sh, xx + shine_w, 0, 10);
	}
	
	gpu_set_colorwriteenable(1,1,1,1);
	
	draw_sprite(spr_star, 1, 0, 0);
	draw_sprite(spr_star, 1, w, 0);
	draw_sprite(spr_star, 1, w*2, 0);
surface_reset_target();


var sx = room_width/2 - sw/2;
var sy = room_height/2 - sh/2 - 40;

draw_surface(surf, sx, sy);

draw_set_text(fnt_score, fa_center, fa_top);
draw_text(sx + w/2, sy + sh + 15, steps[0]);
draw_text(sx + w + w/2, sy + sh + 15, steps[1]);
draw_text(sx + w*2 + w/2, sy + sh + 15, steps[2]);

draw_text(sx + sw/2, room_height - 70, string_format(amount, 4, 0));
draw_reset_text();
