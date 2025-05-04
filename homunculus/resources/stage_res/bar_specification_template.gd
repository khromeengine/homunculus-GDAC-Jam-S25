class_name BarSpec
extends Resource

@export_range(0, 100, 5) var initial_target: float
@export_range(-100, 100, 2) var target_velocity: float
@export_range(-100, 100, 2) var leaking_value_velocity: float
@export_range(-100, 100, 2) var input_value_velocity: float
@export_range(0, 20, 1) var progress_velocity: float
@export_group("Velocity Function")
@export var target_override: bool
@export var target_function: VelocityMath.types
@export var function_arguments: Array[Variant]
