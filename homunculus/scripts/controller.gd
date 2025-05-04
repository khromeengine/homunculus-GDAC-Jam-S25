class_name Controller
extends Node


func _ready():
	StageState.frame_update.connect(_on_frame_update)


func _on_frame_update(delta: float, time: float):
	if Input.is_action_just_pressed("Bar1"):
		GameState.set_bar_uses_input(GameState.BarID.B_ONE, true)
	if Input.is_action_just_pressed("Bar2"):
		GameState.set_bar_uses_input(GameState.BarID.B_TWO, true)
	if Input.is_action_just_released("Bar1"):
		GameState.set_bar_uses_input(GameState.BarID.B_ONE, false)
	if Input.is_action_just_released("Bar2"):
		GameState.set_bar_uses_input(GameState.BarID.B_TWO, false)
