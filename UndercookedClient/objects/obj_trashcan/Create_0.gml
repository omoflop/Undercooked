/// @desc

// Inherit the parent event
event_inherited();

function interact() {
	
	// Is the player's held item a container
	if (target.item.is_container) {
		
		// Clear container
		target.item.clear();
	} else if (!target.item.special) {
		
		// Remove held item
		target.item = new_empty_item();
	}
}