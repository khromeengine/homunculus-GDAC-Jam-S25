extends Node


enum signals_list {
	SET_TARGET_VELOCITY,
	SET_LEAKING_VELOCITY,
	SET_INPUT_VELOCITY,
	GROW_HOMUNCULUS,
}


const signal_map: Dictionary[signals_list, StringName] = {
	signals_list.SET_TARGET_VELOCITY: "set_target_velocity",
	signals_list.SET_LEAKING_VELOCITY: "set_leaking_velocity",
	signals_list.SET_INPUT_VELOCITY: "set_input_velocity",
	signals_list.GROW_HOMUNCULUS: "grow_homunculus",
}


signal set_target_velocity(args: Array[Variant])
signal add_target_velocity(args: Array[Variant])
signal set_leaking_velocity(args: Array[Variant])
signal set_input_velocity(args: Array[Variant])
signal grow_homunculus(args: Array[Variant])

signal shake(args: Array[Variant])
signal tint(args: Array[Variant])
