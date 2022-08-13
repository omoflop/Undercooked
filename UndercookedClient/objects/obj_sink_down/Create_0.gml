/// @desc


// Inherit the parent event
event_inherited();

image_speed = 0;

// Current clean plate stack count
count = 0;

progress_speed = 1/120;
show_progress = 1;

sink_x = x;
sink_y = y;
side_x = x + 16;
side_y = y;

// Get plate image index
plate_subimg = find_item("Plate");
dirty_plate_subimg = find_item("Dirty Plate");

function draw() {
	for (var i = 0; i < count; i ++) {
		draw_sprite(spr_items, plate_subimg, side_x + 8, side_y+8-offset-i*2);
	}
}

function draw_item() {
	if (!item.empty) {
		item.draw(sink_x + 8, sink_y + 8 - offset);
	}
}

function interact() {
	
	// Player held item is not empty
	if (!target.item.empty) {
		
		// Check if held item is a dirty plate
		if (target.item.index == dirty_plate_subimg) {
			
			// Set current item to dirty plate
			item = target.item;
			
			// Remove player held item
			target.item = new_empty_item();
		}
	} 
	// Player is not holding any item
	else {
		
		// There currently are plates in stack
		if (count > 0) {
			
			// Remove plate
			count --;
			
			// Setup new player item
			target.item = new_plate();
		}
	}
}

function hold_interact() {
	
	// Make sure item is a dirty plate
	if (item.index == dirty_plate_subimg) {
		
		// Wash
		increase_progress();
	}
}

function progress_finished() {
	
	// Remove item
	item = new_empty_item();
	
	// Add plate
	count ++;
}