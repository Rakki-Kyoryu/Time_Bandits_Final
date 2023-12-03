extends Node2D

var plato = false
var robot = false
var gallery = false

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()

		
func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "hub":
			if plato == true:
				Global.current_scene = "holder_one"
				get_tree().change_scene_to_file("res://maps/PlatosJournal.tscn")
				Global.finish_changing_scenes()
			elif robot == true:
				Global.current_scene = "robot"
				get_tree().change_scene_to_file("res://maps/robot_map_1.tscn")
				Global.finish_changing_scenes()
			elif gallery == true:
				Global.current_scene = "gallery"
				get_tree().change_scene_to_file("res://maps/gallery.tscn")
				Global.finish_changing_scenes()


func _on_to_gallery_body_entered(body):
	if body.has_method("player_check"):
		gallery = true
		Global.transition_scene = true


func _on_to_gallery_body_exited(body):
	if body.has_method("player_check"):
		gallery = false
		Global.transition_scene = false


func _on_to_roboland_body_entered(body):
	if body.has_method("player_check"):
		robot = true
		Global.transition_scene = true


func _on_to_roboland_body_exited(body):
	if body.has_method("player_check"):
		robot = false
		Global.transition_scene = false


func _on_to_plato_body_entered(body):
	if body.has_method("player_check"):
		plato = true
		Global.transition_scene = true


func _on_to_plato_body_exited(body):
	if body.has_method("player_check"):
		plato = false
		Global.transition_scene = false
