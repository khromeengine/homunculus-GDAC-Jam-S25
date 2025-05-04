class_name BarUI
extends TextureProgressBar

@export var lerp_weight: float = 0.25
@export var ID: GameState.BarID

var _goto_value: float = 0


func _ready():
	StageState.frame_update.connect(_on_frame_update)


func _on_frame_update(delta: float, time: float):
	_goto_value = GameState.get_bar_value(ID)
	value = lerpf(value, _goto_value, 1 - pow(lerp_weight, 4 * delta)) 
