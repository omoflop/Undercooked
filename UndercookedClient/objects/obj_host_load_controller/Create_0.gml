/// @desc

function make_level_data() {
	var ids = [];
	if (instance_exists(obj_countertop)) {
		with (obj_countertop) {
			array_push(ids, id);
		}
	}
	send_info("assign_objects_id", {ids: ids});
}


instance_create_depth(0, 0, -99999, obj_load_warning);

room_goto(rm_game);

