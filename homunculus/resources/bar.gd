class_name Bar
extends Node

var id: GameState.BarID
var value: float
var target_value: float
var progress: float
var done: bool
var value_velocity: float
var input_value_velocity: float
var leaking_value_velocity: float
var uses_input_velocity: 
	set(value):
		if value:
			value_velocity = input_value_velocity
		else:
			value_velocity = leaking_value_velocity
var target_velocity: float
var progress_velocity: float
var uses_target_velocity_function: bool
## Should be a function that takes target_velocity, returns new target velocity.
var target_velocity_function: Callable 
var function_args: Array[Variant]


func update_bar(spec: BarSpec):
	target_value = spec.initial_target
	target_velocity = spec.target_velocity
	leaking_value_velocity = spec.leaking_value_velocity
	uses_target_velocity_function = spec.target_override
	target_velocity_function = VelocityMath.math[spec.target_function]
	function_args = spec.function_arguments
	input_value_velocity = spec.input_value_velocity
	progress_velocity = spec.progress_velocity
	done = false
	uses_input_velocity = false
	

func function_step(delta: float, time: float):
	target_velocity = target_velocity_function.call(target_velocity, delta, time, function_args)
	print(target_velocity)
