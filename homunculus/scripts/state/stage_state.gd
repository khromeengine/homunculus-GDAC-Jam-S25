extends Node

signal frame_update(delta: float, time: float)
signal init_game(stage: GameStages)
signal set_stage(stage: GameStages)
signal stage_done()
signal game_done()

enum GameStages {
	INTRO,
	GROWTH,
	COMPLICATIONS,
	REGRET,
	SALVATION,
	BONUS,
}

const StageResPath: Dictionary[GameStages, StringName] = {
	GameStages.INTRO: "res://resources/stage_res/00intro.tres",
	GameStages.GROWTH: "res://resources/stage_res/01growth.tres",
	GameStages.COMPLICATIONS: "res://resources/stage_res/02complications.tres",
	GameStages.REGRET: "res://resources/stage_res/03regret.tres",
	GameStages.SALVATION: "res://resources/stage_res/04salvation.tres",
	GameStages.BONUS: "res://resources/stage_res/99bonus.tres",
}

var current_time: float
var current_stage: GameStages
var current_stage_spec: StageSpec

var _game_active: bool


func _ready():
	set_stage.connect(_on_set_stage)
	stage_done.connect(_on_stage_done)
	init_game.connect(_on_init_game)
	GameState.game_ready.connect(_on_game_ready)


func _process(delta):
	if _game_active:
		current_time += delta
		frame_update.emit(delta, current_time)


func _on_set_stage(stage: GameStages):
	current_time = 0
	current_stage = stage
	current_stage_spec = load(StageResPath[stage])
	GameState.update_bars(current_stage_spec)
	GameState.done_count = 0
	

func _on_init_game(stage: GameStages):
	current_stage = stage


func _on_game_ready():
	print("Game ready.")
	_game_active = true
	set_stage.emit(current_stage)


func _on_stage_done():
	var stage = current_stage + 1
	if stage < GameStages.size():
		set_stage.emit(current_stage + 1)
	else:
		game_done.emit()
