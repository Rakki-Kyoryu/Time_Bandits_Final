
extends Node2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var sprite = $Sprite2D

const lines: Array[String] = [
	"Hey there!",
	"Here is my route where you'll find me rare artifacts",
	"But before that, check out the gallery to the right!",
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")



func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished
