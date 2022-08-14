/// @desc

// Inherit the parent event
event_inherited();

image_speed = 0;

progress_speed = 1/120;

show_progress = true;

function interact() {
	
	// Swap player and countertop items
	swap();
	
	// Determine if an item is present on countertop
	if (!item.empty) {
		image_index = 1;
	} else {
		image_index = 0;
	}
}

function hold_interact() {
	// Make sure item can be chopped
	if (item.is_applicable_to(RecipeType.chopping)) {
		
		// Chop item
		increase_progress();
	}
}

function progress_finished() {
	
	// Make sure item can be chopped
	if (item.is_applicable_to(RecipeType.chopping)) {
		
		// Turn item into chopped item
		item = new_item(make_recipe(RecipeType.chopping, [item.index]));
	}
}