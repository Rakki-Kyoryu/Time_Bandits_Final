extends Node2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var sprite = $Sprite2D

const lines: Array[String] = [
	"Hey there!",
	"I was told to tell you this message,",
	"Can one be a thief without the will to commit a crime? Or can one steal simply for survival? Does this still make them a thief?", 
	"But can one defend their own work without taking extra strength from a non-human form?",
	"I will show you the answer to all of these questions!",
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished


