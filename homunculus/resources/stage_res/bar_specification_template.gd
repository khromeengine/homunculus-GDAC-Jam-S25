class_name BarSpec
extends Resource

@export_range(0, 100, 5) var initial_target: float
@export_range(0, 5, 1) var target_velocity: float
@export_range(0, 5, 1) var value_velocity: float
@export_group("Velocity Function")
@export var target_override: bool
@export var target_function: VelocityMath.types
@export var function_arguments: Array[Variant]
