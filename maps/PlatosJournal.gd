extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()

		
func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "plato":
			get_tree().change_scene_to_file("res://maps/PlatoBoss.tscn")
			Global.finish_changing_scenes()


func _on_plato_exit_body_entered(body):
	if body.has_method("player_check"):
		Global.transition_scene = true


func _on_plato_exit_body_exited(body):
	if body.has_method("player_check"):
		Global.transition_scene = false
