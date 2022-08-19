/// @desc

width = 10;
height = 10;

if (sprite_index != -1) {
	width = sprite_get_width(sprite_index);
	height = sprite_get_height(sprite_index);
}

text = "";
padding = 4;
font = fnt_debug_small;
function setup_text(t) {
	text = t;
	
	draw_set_font(font);
	
	width = string_width(text) + padding*2;
	height = string_height(text) - 3 + padding*2;
	
	draw_set_font(fnt_main);
}

function mouse_hover(x, y, w, h) {
	return point_in_rectangle(mouse_x, mouse_y, x, y, x+w, y+h);
}

function press() {}
function press_outside() {}