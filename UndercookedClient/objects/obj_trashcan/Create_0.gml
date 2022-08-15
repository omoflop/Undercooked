/// @desc

// Inherit the parent event
event_inherited();

function interact() {
	
	// Is the player's held item a container
	if (target.item.is_container) {
		
		// Clear container
		target.item.clear();
		target.update_item();
		
	} else if (!target.item.special) {
		
		// Remove held item
		//target.item = new_empty_item();
		target.set_item(new_empty_item());
	}
}