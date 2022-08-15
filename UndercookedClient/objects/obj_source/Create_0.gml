/// @desc

event_inherited();

item_id = 0;

function interact() {
	
	// Player has no item
	if (target.item.empty && item.empty) {
		
		// Get item from source
		target.set_item(new_item(item_id));
		//target.item = new_item(item_id);
	} 
	// Countertop or player has an item
	else {
		
		// Swap player and countertop items
		swap();	
	}
}

function draw() {
	
	draw_sprite_ext(spr_items, item_id, x+8, y+3, 1, 1, 0, c_gray, 1);
}