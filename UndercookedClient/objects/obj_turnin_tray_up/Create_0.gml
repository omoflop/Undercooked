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
			
			// Accept order and determine success
			if (accept_order(i.item.index)) {
				
				// Reset held item
				other.target.item = new_empty_item();
				
				// Make sure a plate return exists
				if (instance_exists(obj_plate_return)) {
					
					// Trigger plate return
					obj_plate_return.trigger();
				}
			}
		}
	}
}
