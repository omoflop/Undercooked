/// @desc

event_inherited();

item_type = 0;

function interact() {
	
	// Player has no item
	if (target.item.empty && item.empty) {
		
		// Get item from source
		target.item = new_item(item_type);
	} 
	// Countertop or player has an item
	else {
		
		// Swap player and countertop items
		swap();	
	}
}
