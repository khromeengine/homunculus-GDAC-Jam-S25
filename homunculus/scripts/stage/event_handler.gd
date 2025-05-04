extends Node

var timed_queue: Array[TimedEvent] = []
var progression_queue: Array[ProgressionEvent] = []


func _ready():
	StageState.frame_update.connect(_on_frame_update)
	StageState.set_stage.connect(_on_set_stage)
	

func load_event_list(list: Array):
	#print("Loading ", list)
	if not list.is_empty(): 
		if list.front() is TimedEvent:
			timed_queue.append_array(list)
			timed_queue.sort_custom(func(a: TimedEvent, b: TimedEvent): 
				a.time_threshold < b.time_threshold)
		elif list.front() is ProgressionEvent:
			progression_queue.append_array(list)
			progression_queue.sort_custom(func(a: ProgressionEvent, b: ProgressionEvent):
				a.progress_trigger_threshold < b.progress_trigger_threshold)
		elif list.front() == null:
			pass
		else:
			printerr("Tried to load Array of unexpected type to EventHandler,
				should be Array of type TimedEvent or ProgressionEvent")


func _on_set_stage(_stage):
	timed_queue.clear()
	progression_queue.clear()
	load_event_list(StageState.current_stage_spec.timed_events)
	load_event_list(StageState.current_stage_spec.progression_events)


func _on_frame_update(_delta: float, time: float):
	if not timed_queue.is_empty() and timed_queue.front().time_threshold < time:
		timed_queue.pop_front().execute()
	if (not progression_queue.is_empty() and 
		progression_queue.front().progress_trigger_threshold < GameState.avg_progress):
		progression_queue.pop_front().execute()
