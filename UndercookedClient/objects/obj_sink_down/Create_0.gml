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
plate_subimg = get_item_id("Plate");
dirty_plate_subimg = get_item_id("Dirty Plate");

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
	
	// Player held item is not empty and sink doesn't currently have a plate
	if (!target.item.empty && item.empty) {
		
		// Check if held item is a dirty plate
		if (target.item.index == dirty_plate_subimg) {
			
			// Set current item to dirty plate
			set_item(target.item);
			
			// Remove player held item
			target.set_item(new_empty_item());
		}
	} 
	// Player is not holding any item
	else {
		
		// There currently are plates in stack
		if (count > 0) {
			
			// Remove plate
			send_info("update_stack_count", {id: unique_id, count: -1});
			
			// Setup new player item
			target.set_item(new_plate());
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
	set_item(new_empty_item());
	
	// Add plate
	send_info("update_stack_count", {id: unique_id, count: 1});
}