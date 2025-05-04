extends Node

@export var initial_stage: StageState.GameStages

var _debug = preload("res://scenes/ui/debug_menu.tscn")
var _controller = preload("res://scenes/Controller.tscn")

func _ready():
	StageState.init_game.emit(initial_stage)
	add_child(_controller.instantiate())
	if OS.is_debug_build():
		add_child(_debug.instantiate())
