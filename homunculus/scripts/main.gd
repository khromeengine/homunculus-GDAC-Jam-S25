extends Node

@export var initial_stage: StageState.GameStages

var _debug = preload("res://scenes/ui/debug_menu.tscn")
var _controller = preload("res://scenes/Controller.tscn")

func _ready():
	$AnimationPlayer.play("start")
	StageState.init_game.emit(initial_stage)
	StageState.game_done.connect(_on_game_done)
	add_child(_controller.instantiate())
	if OS.is_debug_build():
		add_child(_debug.instantiate())


func _on_game_done():
	$AnimationPlayer.play("end")
