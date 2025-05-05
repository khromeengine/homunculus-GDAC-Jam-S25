extends Sprite2D

@export var id: GameState.BarID

func _ready():
	StageState.frame_update.connect(_on_frame_update)
	
	
func _on_frame_update(delta: float, time: float):
	if (not GameState.get_bar_value(id) == GameState.MAX_BAR
		and not GameState.get_bar_value(id) == GameState.MIN_BAR):
		rotate(0.05 * GameState.get_bar_value_velocity(id) * delta * (1 - 2 * (id % 2)))
