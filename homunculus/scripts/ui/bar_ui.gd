class_name BarUI
extends TextureProgressBar

@export var lerp_weight: float = 0.25
@export var id: GameState.BarID
@export var height: int = 250
@export var width: int = 40

@onready var topY: float = global_position.y
@onready var botY: float = global_position.y + height

var _goto_value: float = 0

func _ready():
	$TextureRect.global_position.y = topY
	texture_under.set("height", height)
	texture_under.set("width", width)
	StageState.frame_update.connect(_on_frame_update)


func _on_frame_update(delta: float, time: float):
	_goto_value = GameState.get_bar_value(id)
	value = lerpf(value, _goto_value, 1 - pow(lerp_weight, 4 * delta))
	$TextureRect.global_position.y = botY - (height / 100 * GameState.get_bar_target(id))
