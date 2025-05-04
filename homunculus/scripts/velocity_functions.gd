extends Node

enum types {
	RANDOM,
	SIN,
}

var math: Array[Callable] = [
	randomVelocity,
	sinVelocity,
]

func randomVelocity(velocity: float, delta: float, time: float, args: Array[Variant]):
	var weight = -velocity * args[0]
	var ayo = velocity + randf_range(-100 + weight, 130) * 3 * delta
	return ayo


func sinVelocity(velocity: float, delta: float, time: float, args: Array[Variant]):
	return (GameState.MAX_BAR / 2) * sin(args[0] * time)
