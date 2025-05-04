class_name BarUI
extends TextureProgressBar

@export var lerp_weight: float = 0.4
@export var id: GameState.BarID
@export var height: int = 250
@export var width: int = 40

@export var target_width: float = 66
@export var value_width: float = 52
@export var ex_width: float = 40

@onready var target_marker = $TargetMarker
@onready var value_marker = $ValueMarker
@onready var min_marker = $MinMarker
@onready var max_marker = $MaxMarker
@onready var topY: float = global_position.y
@onready var botY: float = global_position.y + height

var _goto_value: float = 0

func _ready():
	visible = false
	GameState.bar_ready.connect(_on_bar_ready)


func _on_frame_update(delta: float, _time: float):
	_goto_value = GameState.get_bar_value(id)
	value = lerpf(value, _goto_value, 1 - pow(lerp_weight, 13 * delta))
	value_marker.global_position.y = lerpf(botY, topY, value / GameState.MAX_BAR)
	target_marker.global_position.y = lerpf(botY, topY, GameState.get_bar_target(id) / GameState.MAX_BAR)
	min_marker.global_position.y = lerpf(botY, topY, 
		GameState.get_do_bar_target_calc(id, -GameState.GOOD_RANGE) / GameState.MAX_BAR)
	max_marker.global_position.y = lerpf(botY, topY, 
		GameState.get_do_bar_target_calc(id, GameState.GOOD_RANGE) / GameState.MAX_BAR)


func _on_bar_ready(checkid: GameState.BarID):
	if id == checkid:
		target_marker.size.x = target_width
		target_marker.position.x = (width - target_width) / 2
		value_marker.size.x = value_width
		value_marker.position.x = (width - value_width) / 2
		min_marker.size.x = width
		max_marker.size.x = width
		texture_under.set("height", height)
		texture_under.set("width", width)
		StageState.frame_update.connect(_on_frame_update)
		visible = true
