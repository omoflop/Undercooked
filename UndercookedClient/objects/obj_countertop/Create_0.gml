/// @desc


item = new_empty_item();

player_hover = false;

target = obj_player;

offset = 8;

show_progress = false;

unique_id = y * room_width + x;

progress_speed = 0;
function progress_finished() {}

function draw() {}

function set_item(i) {
	send_info("set_item", {id: unique_id, item: i});
}

function interact() {
	swap();
}
function hold_interact() {}

function draw_item() {
	if (!item.empty) {
		item.draw(x + 8, y + 8 - offset);
	}
}

function increase_progress() {
	item.progress = approach(item.progress, 1, progress_speed);
	
	if (item.progress == 1) {
		progress_finished();
	}
}

function swap() {
	if (item.is_container xor target.item.is_container) {
		var i, container;
		var player_hold_container;
		
		// Item on countertop is container
		if (item.is_container) {
			container = item;
			i = target.item;
			
			// Player is not holding the container
			player_hold_container = false;
		}
		// Player's held item is container
		else {
			container = target.item;
			i = item;
			
			// Player is holding the container
			player_hold_container = true;
		}
		
		// Item is empty or cannot be combined with container
		if (i.empty || !container.can_combine(i)) {
			
			// Swap items
			var temp = item;
			set_item(target.item);
			target.set_item(temp);
			//item = target.item;
			//target.item = temp;
		} else {
			
			// Add item to container
			container.add_item(i);
			
			// Remove other item
			if (player_hold_container) {
				set_item(new_empty_item());
				//item = new_empty_item();
			} else {
				target.set_item(new_empty_item());
				//target.item = new_empty_item();
			}
		}
	} else {
		
		
		// Swap items
		var temp = item;
		set_item(target.item);
		target.set_item(temp);
		//item = target.item;
		//target.item = temp;
	}
}

depth = -bbox_bottom;
