extends Node2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var sprite = $Sprite2D

const lines: Array[String] = [
	"TH13F: Meatbag, to properly assess your skill set and calculate your chances of survival a demonstration of your skills is required.",
	"TH13F: Complete this training course using any tools you see fit.",
	"TH13F: Once completed your data will be logged into my memory bank and used for future calculations.",
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished

