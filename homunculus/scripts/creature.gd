extends Node2D




func _on_grow_homunculus(_args: Array):
	$AnimationTree.set("parameters/conditions/transition", true)
	await get_tree().process_frame
	$AnimationTree.set("parameters/conditions/transition", false)
