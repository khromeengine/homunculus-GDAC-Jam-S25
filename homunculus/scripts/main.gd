extends Node

@export var initial_stage: StageState.GameStages

var debug = preload("res://scenes/ui/debug_menu.tscn")


func _ready():
	StageState.init_game.emit(initial_stage)
	if OS.is_debug_build():
		add_child(debug.instantiate())
