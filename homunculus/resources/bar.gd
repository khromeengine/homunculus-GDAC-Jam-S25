class_name Bar
extends Node

const done_progress: float = 100

var id: GameState.BarID
var value: float
var target_value: float
var progress: float
var done: bool
var value_velocity: float
var target_velocity: float
var progress_velocity: float
var uses_target_velocity_function: bool
## Should be a function that takes target_velocity, returns new target velocity.
var target_velocity_function: Callable 
var function_args: Array[Variant]


func update_bar(spec: BarSpec):
	target_value = spec.initial_target
	target_velocity = spec.target_velocity
	value_velocity = spec.value_velocity
	uses_target_velocity_function = spec.target_override
	target_velocity_function = VelocityMath.math[spec.target_function]
	function_args = spec.function_arguments
	done = false
	

func function_step(delta: float, time: float):
	target_velocity_function.call(target_velocity, delta, time, function_args)
