extends Node

const NUM_BARS = 2

enum BarID {
	B_ONE,
	B_TWO,
}

signal bar_ready(id: BarID)
signal game_ready()

const MIN_BAR = 0
const MAX_BAR = 100
const GOOD_RANGE = 20

var done_count: int = 0
var ready_count: int = 0

var _bars: Dictionary[BarID, Bar];
var _bar_iterators: Array;


func _ready():
	StageState.frame_update.connect(_on_frame_update)
	StageState.init_game.connect(_on_init_game)


func is_ready():
	return ready_count > NUM_BARS


func add_bar_value(id: BarID, amt: float) -> float:
	var old = _bars[id].value
	if _bars.has(id):
		_bars[id].value = clampf(_bars[id].value + amt, MIN_BAR, MAX_BAR)
	else:
		printerr("Tried adding value ", amt, " to invalid bar ", id)
	return _bars[id].value - old


func set_bar_value(id: BarID, amt: float):
	if _bars.has(id):
		_bars[id].value = clampf(amt, MIN_BAR, MAX_BAR)
	else:
		printerr("Tried setting invalid bar ", id, " to value ", amt)


func add_bar_target(id: BarID, amt: float) -> float:
	var old = _bars[id].target_value
	if _bars.has(id):
		_bars[id].target_value = clampf(_bars[id].target_value + amt, MIN_BAR, MAX_BAR)
	else:
		printerr("Tried adding target value ", amt, " to invalid bar ", id)
	return _bars[id].target_value - old


func set_bar_target(id: BarID, amt: float):
	if _bars.has(id):
		_bars[id].target_value = clampf(amt, MIN_BAR, MAX_BAR)
	else:
		printerr("Tried setting invalid bar ", id, " to target value ", amt) 


func get_bar_value(id: BarID) -> float:
	if _bars.has(id):
		return _bars[id].value
	else:
		printerr("Tried getting value of invalid bar ", id)
		return -1


func get_bar_target(id: BarID) -> float:
	if _bars.has(id):
		return _bars[id].target_value
	else:
		printerr("Tried getting target value of invalid bar ", id)
		return -1


func get_bar(id: BarID) -> Bar:
	return _bars[id]


func update_bars(spec: StageSpec) -> void:
	for id in BarID.values():
		if _bars.has(id):
			_bars[id].update_bar(spec.bar_specifications[id])
		else:
			printerr("Tried to update invalid bar ", id)


func _on_frame_update(delta: float, time: float) -> void:
	var lambda = func(bar: Bar) -> void:
		if bar.uses_target_velocity_function:
			bar.function_step(delta, time)
		else:
			bar.target_value += bar.target_velocity * delta
		bar.value += bar.value_velocity * delta
		if not bar.done:
			if (bar.value > bar.target_value - GOOD_RANGE 
					and bar.value < bar.target_value + GOOD_RANGE):
				bar.progress += bar.progress_velocity
			if bar.progress >= bar.done_progress:
				bar.done = true
				done_count += 1
				if done_count >= NUM_BARS:
					StageState.stage_done.emit()
	_bar_iterators.map(lambda)


func _init_bar(id: BarID):
	_bars[id] = Bar.new()
	_bars[id].id = id
	_bar_iterators = _bars.keys()
	ready_count += 1
	if ready_count >= NUM_BARS:
		game_ready.emit()
	bar_ready.emit(id)


func _on_init_game(_stage):
	var lambda = func(id: BarID):
		print(id)
		_init_bar(id)
	BarID.values().map(lambda)
