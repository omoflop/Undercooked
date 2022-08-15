/// @desc Handle interaction

// Check mouse hover
if (mouse_hover(x, y, width, height)) {
	
	// Set mouse hover flag
	hover = true;
	
	// Check press
	if (mouse_check_button_pressed(mb_left)) {
		
		// Set button pressed flag
		pressed = true;
	}
} else {
	
	// Reset mouse hover flag
	hover = false;
	
	// Reset button pressed flag
	pressed = false;
}

// Check mouse release
if (mouse_check_button_released(mb_left) && pressed) {
	
	// Check if mouse is currently hovering
	if (hover) {
		
		// Call press event
		press();
	}
	
	// Reset button pressed flag
	pressed = false;
}