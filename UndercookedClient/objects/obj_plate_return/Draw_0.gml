/// @desc

// Inherit the parent event
event_inherited();

// Draw plates
for (var i = 0; i < count; i ++) {
	draw_sprite(spr_items, item_subimg, x + 8, y+8-offset-i*2);
}