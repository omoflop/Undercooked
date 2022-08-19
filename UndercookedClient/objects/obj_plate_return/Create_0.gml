/// @desc

event_inherited();

// Current plate stack count
count = 0;

// Plate respawn time (seconds)
timer = 3;

// Get dirty plate image index
item_subimg = get_item_id("Dirty Plate");

function add_plate() {
	count ++;
}

function interact() {
	
	// Make sure player isn't holding anything
	if (!target.item.empty) return;
	
	// There are plates in the stack
	if (count > 0) {
		
		// Remove plate
		send_info("update_stack_count", {id: unique_id, count: -1});
		
		// Setup new player item
		target.set_item(new_plate_dirty());
	}
}
