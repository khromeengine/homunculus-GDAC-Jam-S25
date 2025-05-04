class_name StageSpec
extends Resource

@export_category("Gameplay")
@export var bar_specifications: Array[BarSpec]

@export_category("Other")
@export_group("Events")
@export var timed_events: Array[TimedEvent]
@export var progression_events: Array[ProgressionEvent]
