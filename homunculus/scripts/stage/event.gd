class_name Event
extends Resource

@export var signal_name: EventSignals.signals_list
@export var signal_argument: Array[Variant]

func execute():
	EventSignals.emit_signal(EventSignals.signal_map[signal_name], signal_argument)
