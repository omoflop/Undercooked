/// @desc

event_inherited();

// Current plate stack count
count = 0;

// Plate respawn time (seconds)
timer = 3;

// Get dirty plate image index
item_subimg = find_item("Dirty Plate")

function trigger() {
	
	// Add plate timer
	var t = time_source_create(time_source_game, timer, time_source_units_seconds, add_plate);
	time_source_start(t);
}

function add_plate() {
	count ++;
}

function interact() {
	
	// Make sure player isn't holding anything
	if (!target.item.empty) return;
	
	// There are plates in the stack
	if (count > 0) {
		
		// Remove plate
		count --;
		
		// Setup new player item
		target.item = new_plate_dirty();
	}
}
