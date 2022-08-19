/// @desc

// Inherit the parent event
event_inherited();

function interact() {
	var i = target.item;
	
	// Item is empty, not a container, or doesn't contain anything
	if (i.empty || !i.is_container || i.item.empty) return false;
	
	// Make sure order controller exists
	if (instance_exists(obj_order_controller)) {
		with (obj_order_controller) {
			
			var accept_index = check_item_accept(i.item.index);
			
			// Accept order and determine success
			if (accept_index != -1) {
				
				send_info("finish_order", {id: accept_index});
				
				// Reset held item
				other.target.set_item(new_empty_item());
			}
		}
	}
}
