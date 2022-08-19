/// @desc

draw_self();

var size = 16;

draw();
draw_item();


	
if (player_hover) {
	gpu_set_fog(1, c_white, 1, 0);
	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, 0.4);
	gpu_set_fog(0, c_white, 1, 0);
}

