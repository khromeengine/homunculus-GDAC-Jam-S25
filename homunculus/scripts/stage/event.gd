class_name Event
extends Resource

@export var signal_name: StringName
@export var signal_argument: StringName

func execute():
	EventSignals.emit_signal(signal_name, signal_argument)
