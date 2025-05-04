extends Control


@onready var T = $Panel/VBoxContainer/Title
@onready var t = $"Panel/VBoxContainer/Time"
@onready var b1 = $"Panel/VBoxContainer/BarVal1"
@onready var b2 = $"Panel/VBoxContainer/BarVal2"
@onready var c = $"Panel/VBoxContainer/Completion"


func _ready():
	StageState.frame_update.connect(_on_frame_update)


func _process(_delta):
	if Input.is_action_just_pressed("DebugMenu"):
		visible = true != visible


func _on_frame_update(delta, time):
	T.text = "Debug \t|\t Stage %d" % [StageState.current_stage]
	t.text = "Time: %8.3f \t Delta: %.3f \t FPS: %2.2f" % [time, delta, 1/delta]
	b1.text = "Bar 1 | Value: %3.1f \t Target: %3.1f" % [GameState.get_bar_value(GameState.BarID.B_ONE),
															GameState.get_bar_target(GameState.BarID.B_ONE)]
	b2.text = "Bar 2 | Value: %3.1f \t Target: %3.1f" % [GameState.get_bar_value(GameState.BarID.B_TWO),
															GameState.get_bar_target(GameState.BarID.B_TWO)]
	c.text = "1 Completion: %3.1f \t|\t 2 Completion: %3.1f \t|\t Avg. Completion: %3.1f" % [
		GameState.get_bar_progress(GameState.BarID.B_ONE),
		GameState.get_bar_progress(GameState.BarID.B_TWO),
		GameState.avg_progress
	]
